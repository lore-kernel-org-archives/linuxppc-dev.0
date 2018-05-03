Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c6nh43YpzF2VC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 17:52:56 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id k11-v6so11421785pgo.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 May 2018 00:52:56 -0700 (PDT)
Date: Thu, 3 May 2018 15:52:51 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/11] KVM: PPC: Fix a mmio_host_swabbed uninitialized
 usage issue when VMX store
Message-ID: <20180503075251.GD6755@simonLocalRHEL7.x64>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-4-git-send-email-wei.guo.simon@gmail.com>
 <20180503054826.GD6795@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503054826.GD6795@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 03, 2018 at 03:48:26PM +1000, Paul Mackerras wrote:
> On Wed, Apr 25, 2018 at 07:54:36PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > When KVM emulates VMX store, it will invoke kvmppc_get_vmx_data() to
> > retrieve VMX reg val. kvmppc_get_vmx_data() will check mmio_host_swabbed
> > to decide which double word of vr[] to be used. But the
> > mmio_host_swabbed can be uninitiazed during VMX store procedure:
> > 
> > kvmppc_emulate_loadstore
> > 	\- kvmppc_handle_store128_by2x64
> > 		\- kvmppc_get_vmx_data
> > 
> > This patch corrects this by using kvmppc_need_byteswap() to choose
> > double word of vr[] and initialized mmio_host_swabbed to avoid invisble
> > trouble.
> > 
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> 
> The patch is correct, but I think the patch description needs to say
> that vcpu->arch.mmio_host_swabbed is not meant to be used at all for
> emulation of store instructions, and this patch makes that true for
> VMX stores.
I will revise the commit message accordingly.

> 
> Paul.

Thanks,
- Simon
