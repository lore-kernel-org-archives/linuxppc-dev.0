Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B860C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 14:48:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9408221726
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 14:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9408221726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bN3f2zq7zDqTQ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 01:48:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jpoimboe@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bMyc2TzMzDqW9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2019 01:44:08 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AFEB43005148;
 Fri,  5 Apr 2019 14:44:05 +0000 (UTC)
Received: from treble (ovpn-123-87.rdu2.redhat.com [10.10.123.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DDE991001E81;
 Fri,  5 Apr 2019 14:43:59 +0000 (UTC)
Date: Fri, 5 Apr 2019 09:43:56 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH RFC 5/5] arm64/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
Message-ID: <20190405144356.zdi7fwoanz72xduh@treble>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <5f70df57b19bbccc4a0d5d76134b4681c9a50b0b.1554396090.git.jpoimboe@redhat.com>
 <be6ba8fe-b261-668a-05b9-7fa937ae650a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be6ba8fe-b261-668a-05b9-7fa937ae650a@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 05 Apr 2019 14:44:06 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, Jiri Kosina <jikos@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jon Masters <jcm@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 05, 2019 at 03:39:58PM +0100, Steven Price wrote:
> On 04/04/2019 17:44, Josh Poimboeuf wrote:
> > Configure arm64 runtime CPU speculation bug mitigations in accordance
> > with the 'cpu_spec_mitigations=' cmdline options.  This affects
> > Meltdown and Speculative Store Bypass.
> > 
> > The default behavior is unchanged.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 2 ++
> >  arch/arm64/kernel/cpu_errata.c                  | 4 ++++
> >  arch/arm64/kernel/cpufeature.c                  | 6 ++++++
> >  3 files changed, 12 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index e838af96daa4..0b54385ee7a8 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2553,11 +2553,13 @@
> >  			off
> >  				Disable all speculative CPU mitigations.
> >  				Equivalent to: nopti [x86, powerpc]
> > +					       kpti=0 [arm64]
> >  					       nospectre_v1 [powerpc]
> >  					       nospectre_v2 [x86, powerpc, s390]
> >  					       spectre_v2_user=off [x86]
> >  					       nobp=0 [s390]
> >  					       spec_store_bypass_disable=off [x86, powerpc]
> > +					       ssbd=force-off [arm64]
> >  					       l1tf=off [x86]
> >  
> >  			auto (default)
> > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> > index 9950bb0cbd52..db8d27e3fb1c 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/arm-smccc.h>
> >  #include <linux/psci.h>
> >  #include <linux/types.h>
> > +#include <linux/cpu.h>
> >  #include <asm/cpu.h>
> >  #include <asm/cputype.h>
> >  #include <asm/cpufeature.h>
> > @@ -385,6 +386,9 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
> >  		return false;
> >  	}
> >  
> > +	if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
> > +		ssbd_state = ARM64_SSBD_FORCE_DISABLE;
> > +
> >  	switch (psci_ops.conduit) {
> >  	case PSCI_CONDUIT_HVC:
> >  		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 4061de10cea6..4512b582d50f 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/stop_machine.h>
> >  #include <linux/types.h>
> >  #include <linux/mm.h>
> > +#include <linux/cpu.h>
> >  #include <asm/cpu.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/cpu_ops.h>
> > @@ -978,6 +979,11 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> >  		__kpti_forced = -1;
> >  	}
> >  
> > +	if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF) {
> > +		str = "cpu_spec_mitigations=off";
> 
> Might also be worth changing the initialisation of str, currently it is:
> 
> > 	char const *str = "command line option";
> 
> But now we have two command line options, perhaps "kpti command line
> option".

Yes, agreed, thanks.

-- 
Josh
