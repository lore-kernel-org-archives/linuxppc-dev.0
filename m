Return-Path: <christoffer.dall@linaro.org>
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com
 [209.85.217.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C86F1A0BDE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 18:24:45 +1000 (AEST)
Received: by lbcga7 with SMTP id ga7so2129096lbc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 01:24:40 -0700 (PDT)
Date: Tue, 14 Apr 2015 10:24:48 +0200
From: Christoffer Dall <christoffer.dall@linaro.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 02/10] KVM: define common __KVM_GUESTDBG_USE_SW/HW_BP
 values
Message-ID: <20150414082448.GR6186@cbox>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-3-git-send-email-alex.bennee@linaro.org>
 <20150413115535.GM6186@cbox> <871tjokrnu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <871tjokrnu.fsf@linaro.org>
Cc: peter.maydell@linaro.org, kvm@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 kvmarm@lists.cs.columbia.edu, Nadav Amit <namit@cs.technion.ac.il>,
 "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, agraf@suse.de,
 Gleb Natapov <gleb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 zhichao.huang@linaro.org, jan.kiszka@siemens.com,
 Mihai Caraman <mihai.caraman@freescale.com>, bp@suse.de, drjones@redhat.com,
 marc.zyngier@arm.com, r65777@freescale.com,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 "open list:ABI/API" <linux-api@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, dahi@linux.vnet.ibm.com,
 pbonzini@redhat.com,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 13, 2015 at 03:51:33PM +0100, Alex Bennée wrote:
> 
> Christoffer Dall <christoffer.dall@linaro.org> writes:
> 
> > On Tue, Mar 31, 2015 at 04:08:00PM +0100, Alex Bennée wrote:
> >> Currently x86, powerpc and soon arm64 use the same two architecture
> >> specific bits for guest debug support for software and hardware
> >> breakpoints. This makes the shared values explicit while leaving the
> >> gate open for another architecture to use some other value if they
> >> really really want to.
> >> 
> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >> 
> >> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> >> index ab4d473..1731569 100644
> >> --- a/arch/powerpc/include/uapi/asm/kvm.h
> >> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> >> @@ -310,8 +310,8 @@ struct kvm_guest_debug_arch {
> >>   * and upper 16 bits are architecture specific. Architecture specific defines
> >>   * that ioctl is for setting hardware breakpoint or software breakpoint.
> >>   */
> >> -#define KVM_GUESTDBG_USE_SW_BP		0x00010000
> >> -#define KVM_GUESTDBG_USE_HW_BP		0x00020000
> >> +#define KVM_GUESTDBG_USE_SW_BP		__KVM_GUESTDBG_USE_SW_BP
> >> +#define KVM_GUESTDBG_USE_HW_BP		__KVM_GUESTDBG_USE_HW_BP
> >>  
> >>  /* definition of registers in kvm_run */
> >>  struct kvm_sync_regs {
> >> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> >> index d7dcef5..1438202 100644
> >> --- a/arch/x86/include/uapi/asm/kvm.h
> >> +++ b/arch/x86/include/uapi/asm/kvm.h
> >> @@ -250,8 +250,8 @@ struct kvm_debug_exit_arch {
> >>  	__u64 dr7;
> >>  };
> >>  
> >> -#define KVM_GUESTDBG_USE_SW_BP		0x00010000
> >> -#define KVM_GUESTDBG_USE_HW_BP		0x00020000
> >> +#define KVM_GUESTDBG_USE_SW_BP		__KVM_GUESTDBG_USE_SW_BP
> >> +#define KVM_GUESTDBG_USE_HW_BP		__KVM_GUESTDBG_USE_HW_BP
> >>  #define KVM_GUESTDBG_INJECT_DB		0x00040000
> >>  #define KVM_GUESTDBG_INJECT_BP		0x00080000
> >>  
> >> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >> index 5eedf84..ce2db14 100644
> >> --- a/include/uapi/linux/kvm.h
> >> +++ b/include/uapi/linux/kvm.h
> >> @@ -525,8 +525,16 @@ struct kvm_s390_irq {
> >>  
> >>  /* for KVM_SET_GUEST_DEBUG */
> >>  
> >> -#define KVM_GUESTDBG_ENABLE		0x00000001
> >> -#define KVM_GUESTDBG_SINGLESTEP		0x00000002
> >> +#define KVM_GUESTDBG_ENABLE		(1 << 0)
> >> +#define KVM_GUESTDBG_SINGLESTEP	(1 << 1)
> >> +
> >> +/*
> >> + * Architecture specific stuff uses the top 16 bits of the field,
> >
> > can you be more specific than 'stuff' here?  features?
> >
> >> + * however there is some shared commonality for the common cases
> >
> > I don't like this sentence; shared commonality is a pleonasm and the use
> > of however makes it sounds like there's some caveat here.
> 
> OK I can see that - after I looked it up ;-)
> 
> > If the top 16 bits are indeed arhictecture specific, then I think they
> > should just be defined in their architecture specific headers.  Unless
> > the idea here is that there's a fixed set of of flags that architectures
> > can choose to support, in which case it should simply be defined in the
> > common header.
> 
> Well an architecture might not support some features and want to use
> those bits for something else? I didn't want to force the bottom two
> of the architecture specific bits to wasted if the features don't exist.
> 
In that case I think the definition is local to each architecture and
should indeed just be duplicated.  The __ definitions complicate more
than they help as they are exported to userspace etc.  The KVM
maintainers may have a different view on this though.

-Christoffer
