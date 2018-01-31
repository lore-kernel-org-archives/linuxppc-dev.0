Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com
 [IPv6:2607:f8b0:4001:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWg6B1tJLzF0PP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 21:51:29 +1100 (AEDT)
Received: by mail-io0-x244.google.com with SMTP id 25so14728435ioj.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 02:51:29 -0800 (PST)
Date: Wed, 31 Jan 2018 18:51:24 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Alexander Graf <agraf@suse.de>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH] KVM: PPC: Book3S PR: close a race window when SVCPU
 pointer is hold before kvmppc_copy_from_svcpu()
Message-ID: <20180131105124.GL3261@simonLocalRHEL7.x64>
References: <1517372604-21405-1-git-send-email-wei.guo.simon@gmail.com>
 <02181006-3013-5ed0-66cb-b5ec685ac466@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <02181006-3013-5ed0-66cb-b5ec685ac466@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alex,
On Wed, Jan 31, 2018 at 10:28:05AM +0100, Alexander Graf wrote:
> 
> 
> On 31.01.18 05:23, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > commit 40fdd8c88c4a ("KVM: PPC: Book3S: PR: Make svcpu -> vcpu store
> > preempt savvy") and commit 3d3319b45eea ("KVM: PPC: Book3S: PR: Enable
> > interrupts earlier") is trying to turns on preemption early when
> > return into highmem guest exit handler.
> > 
> > However there is a race window in following example at
> > arch/powerpc/kvm/book3s_interrupts.S:
> > 
> > highmem guest exit handler:
> > ...
> > 195         GET_SHADOW_VCPU(r4)
> > 196         bl      FUNC(kvmppc_copy_from_svcpu)
> > ...
> > 239         bl      FUNC(kvmppc_handle_exit_pr)
> > 
> > If there comes a preemption between line 195 and 196, line 196
> > may hold an invalid SVCPU reference with following sequence:
> > 1) Qemu task T1 runs at GET_SHADOW_VCPU(r4) at line 195, on CPU A.
> > 2) T1 is preempted and switch out CPU A. As a result, it checks
> > CPU A's svcpu->in_use (=1 at present) and flush cpu A's svcpu to
> > T1's vcpu.
> > 3) Another task T2 switches into CPU A and it may update CPU A's
> > svcpu->in_use into 1.
> > 4) T1 is scheduled into CPU B. But it still holds CPU A's svcpu
> > reference as R4. Then it executes kvmppc_copy_from_svcpu() with
> > R4 and it will corrupt T1's VCPU with T2's content. T2's VCPU
> > will also be impacted.
> > 
> > This patch moves the svcpu->in_use into VCPU so that the vcpus
> > sharing the same svcpu can work properly and fix the above case.
> > 
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> 
> Sorry, the previous version would only compile on 32bit PPC ;). Please
> find the fixed one which just uses svcpu_get() and _put() here:
> 
> 
> https://github.com/agraf/linux-2.6/commit/f9e3ca44c9a9d4930d6dccaacb518734746059c3
> 
> 
> Alex
Your solution looks better than mine :)
Unfortunately somehow I cannot reproduce my issue without the fix. So 
I cannot test it currently.

Reviewed-by: Simon Guo <wei.guo.simon@gmail.com>

Thanks,
- Simon
