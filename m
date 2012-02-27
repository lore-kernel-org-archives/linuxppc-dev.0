Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F30D9B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 05:23:31 +1100 (EST)
Message-ID: <4F4BCA1F.5040905@suse.de>
Date: Mon, 27 Feb 2012 19:23:27 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: [PATCH 24/37] KVM: PPC: booke: rework rescheduling checks
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
 <1330093591-19523-25-git-send-email-agraf@suse.de>
 <6A3DF150A5B70D4F9B66A25E3F7C888D141083@039-SN2MPN1-023.039d.mgd.msft.net>
 <4F4BBE55.6020204@suse.de>
In-Reply-To: <4F4BBE55.6020204@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/27/2012 06:33 PM, Alexander Graf wrote:
> On 02/27/2012 05:34 PM, Bhushan Bharat-R65777 wrote:
>>
>>> +}
>>> +
>>> +/*
>>> + * Common checks before entering the guest world.  Call with 
>>> interrupts
>>> + * disabled.
>>> + *
>>> + * returns !0 if a signal is pending and check_signal is true  */
>>> +static int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu, bool
>>> +check_signal) {
>>> +    int r = 0;
>>> +
>>> +    WARN_ON_ONCE(!irqs_disabled());
>>> +    while (true) {
>>> +        if (need_resched()) {
>>> +            local_irq_enable();
>>> +            cond_resched();
>>> +            local_irq_disable();
>>> +            continue;
>>> +        }
>>> +
>>> +        if (kvmppc_core_prepare_to_enter(vcpu)) {
>> kvmppc_prepare_to_enter() is called even on heavyweight_exit. Should 
>> not this be called only on lightweight_exit?
>
> Yeah, we don't need to call it when exiting anyways. That's a 
> functional change though, which this patch is trying not to introduce. 
> So we should rather do that as a patch on top.

So how about this (warning! broken whitespace)?


diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 7a16b56..616aa2d 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -464,7 +464,7 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
   *
   * returns !0 if a signal is pending and check_signal is true
   */
-static int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu, bool 
check_signal)
+static int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
  {
         int r = 0;

@@ -483,7 +483,7 @@ static int kvmppc_prepare_to_enter(struct kvm_vcpu 
*vcpu, bool check_signal)
                         continue;
                 }

-               if (check_signal && signal_pending(current))
+               if (signal_pending(current))
                         r = 1;

                 break;
@@ -507,7 +507,7 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct 
kvm_vcpu *vcpu)
         }

         local_irq_disable();
-       if (kvmppc_prepare_to_enter(vcpu, true)) {
+       if (kvmppc_prepare_to_enter(vcpu)) {
                 kvm_run->exit_reason = KVM_EXIT_INTR;
                 ret = -EINTR;
                 goto out;
@@ -941,13 +941,16 @@ int kvmppc_handle_exit(struct kvm_run *run, struct 
kvm_vcpu *vcpu,
          * To avoid clobbering exit_reason, only check for signals if we
          * aren't already exiting to userspace for some other reason.
          */
-       local_irq_disable();
-       if (kvmppc_prepare_to_enter(vcpu, !(r & RESUME_HOST))) {
-               run->exit_reason = KVM_EXIT_INTR;
-               r = (-EINTR << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
-               kvmppc_account_exit(vcpu, SIGNAL_EXITS);
+       if (!(r & RESUME_HOST)) {
+               local_irq_disable();
+               if (kvmppc_prepare_to_enter(vcpu)) {
+                       run->exit_reason = KVM_EXIT_INTR;
+                       r = (-EINTR << 2) | RESUME_HOST | (r & 
RESUME_FLAG_NV);
+                       kvmppc_account_exit(vcpu, SIGNAL_EXITS);
+               }
         }

+out:
         return r;
  }
