Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rHVP07dszDrZD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 13:06:52 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id m24-v6so714595pls.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 20:06:52 -0700 (PDT)
Date: Wed, 23 May 2018 11:06:46 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 5/7] KVM: PPC: reimplements LOAD_VSX/STORE_VSX
 instruction mmio emulation with analyse_intr() input
Message-ID: <20180523030646.GA2498@simonLocalRHEL7.x64>
References: <1526880266-11291-1-git-send-email-wei.guo.simon@gmail.com>
 <1526880266-11291-6-git-send-email-wei.guo.simon@gmail.com>
 <20180522094151.GA9871@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180522094151.GA9871@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,
On Tue, May 22, 2018 at 07:41:51PM +1000, Paul Mackerras wrote:
> On Mon, May 21, 2018 at 01:24:24PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > This patch reimplements LOAD_VSX/STORE_VSX instruction MMIO emulation with
> > analyse_intr() input. It utilizes VSX_FPCONV/VSX_SPLAT/SIGNEXT exported
> > by analyse_instr() and handle accordingly.
> > 
> > When emulating VSX store, the VSX reg will need to be flushed so that
> > the right reg val can be retrieved before writing to IO MEM.
> 
> When I tested this patch set with the MMIO emulation test program I
> have, I got a host crash on the first test that used a VSX instruction
> with a register number >= 32, that is, a VMX register.  The crash was
> that it hit the BUG() at line 1193 of arch/powerpc/kvm/powerpc.c.
> 
> The reason it hit the BUG() is that vcpu->arch.io_gpr was 0xa3.
> What's happening here is that analyse_instr gives a register numbers
> in the range 32 - 63 for VSX instructions which access VMX registers.
> When 35 is ORed with 0x80 (KVM_MMIO_REG_VSX) we get 0xa3.
> 
> The old code didn't pass the high bit of the register number to
> kvmppc_handle_vsx_load/store, but instead passed it via the
> vcpu->arch.mmio_vsx_tx_sx_enabled field.  With your patch set we still
> set and use that field, so the patch below on top of your patches is
> the quick fix.  Ideally we would get rid of that field and just use
> the high (0x20) bit of the register number instead, but that can be
> cleaned up later.
> 
> If you like, I will fold the patch below into this patch and push the
> series to my kvm-ppc-next branch.
> 
> Paul.
Sorry my test missed this kind of cases. Please go ahead to fold the patch
as you suggested.  Thanks for point it out.

If you like, I can do the clean up work. If I understand correctly,
we need to expand io_gpr to u16 from u8 so that reg number can use 
6 bits and leave room for other reg flag bits.

BR,
- Simon

> ---
> diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
> index 0165fcd..afde788 100644
> --- a/arch/powerpc/kvm/emulate_loadstore.c
> +++ b/arch/powerpc/kvm/emulate_loadstore.c
> @@ -242,8 +242,8 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
>  			}
>  
>  			emulated = kvmppc_handle_vsx_load(run, vcpu,
> -					KVM_MMIO_REG_VSX|op.reg, io_size_each,
> -					1, op.type & SIGNEXT);
> +					KVM_MMIO_REG_VSX | (op.reg & 0x1f),
> +					io_size_each, 1, op.type & SIGNEXT);
>  			break;
>  		}
>  #endif
> @@ -363,7 +363,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
>  			}
>  
>  			emulated = kvmppc_handle_vsx_store(run, vcpu,
> -					op.reg, io_size_each, 1);
> +					op.reg & 0x1f, io_size_each, 1);
>  			break;
>  		}
>  #endif
