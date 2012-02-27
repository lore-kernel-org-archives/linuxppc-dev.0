Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4E979B6F98
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 04:33:15 +1100 (EST)
Message-ID: <4F4BBE55.6020204@suse.de>
Date: Mon, 27 Feb 2012 18:33:09 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: [PATCH 24/37] KVM: PPC: booke: rework rescheduling checks
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
 <1330093591-19523-25-git-send-email-agraf@suse.de>
 <6A3DF150A5B70D4F9B66A25E3F7C888D141083@039-SN2MPN1-023.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D141083@039-SN2MPN1-023.039d.mgd.msft.net>
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

On 02/27/2012 05:34 PM, Bhushan Bharat-R65777 wrote:
>
>> +}
>> +
>> +/*
>> + * Common checks before entering the guest world.  Call with interrupts
>> + * disabled.
>> + *
>> + * returns !0 if a signal is pending and check_signal is true  */
>> +static int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu, bool
>> +check_signal) {
>> +	int r = 0;
>> +
>> +	WARN_ON_ONCE(!irqs_disabled());
>> +	while (true) {
>> +		if (need_resched()) {
>> +			local_irq_enable();
>> +			cond_resched();
>> +			local_irq_disable();
>> +			continue;
>> +		}
>> +
>> +		if (kvmppc_core_prepare_to_enter(vcpu)) {
> kvmppc_prepare_to_enter() is called even on heavyweight_exit. Should not this be called only on lightweight_exit?

Yeah, we don't need to call it when exiting anyways. That's a functional 
change though, which this patch is trying not to introduce. So we should 
rather do that as a patch on top.

Alex
