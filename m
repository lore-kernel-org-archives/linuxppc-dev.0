Return-Path: <SRS0=Rflt=F2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93C6C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Dec 2020 17:33:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2CC22583
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Dec 2020 17:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2CC22583
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0k2b5gmyzDqWF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Dec 2020 04:33:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4D0k0s2B2mzDqQm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2020 04:31:54 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0BMHTPhH009690;
 Tue, 22 Dec 2020 11:29:25 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 0BMHTMBu009689;
 Tue, 22 Dec 2020 11:29:22 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 22 Dec 2020 11:29:22 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Xiaoming Ni <nixiaoming@huawei.com>
Subject: Re: [PATCH] powerpc:Don't print raw EIP/LR hex values in dump_stack()
 and show_regs()
Message-ID: <20201222172922.GE2672@gate.crashing.org>
References: <20201221032758.12143-1-nixiaoming@huawei.com>
 <2279fc96-1f10-0c3f-64d9-734f18758620@csgroup.eu>
 <20201221163130.GZ2672@gate.crashing.org>
 <ad814ccf34c14c76b45e50b6e7741c3a@AcuMS.aculab.com>
 <20201221171228.GA2672@gate.crashing.org>
 <9b874bd4-9ac8-eb94-8432-8d6193c3feaf@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b874bd4-9ac8-eb94-8432-8d6193c3feaf@huawei.com>
User-Agent: Mutt/1.4.2.3i
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
Cc: "ravi.bangoria@linux.ibm.com" <ravi.bangoria@linux.ibm.com>,
 "mikey@neuling.org" <mikey@neuling.org>,
 "yanaijie@huawei.com" <yanaijie@huawei.com>,
 "wangle6@huawei.com" <wangle6@huawei.com>,
 "haren@linux.ibm.com" <haren@linux.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Laight <David.Laight@aculab.com>, "paulus@samba.org" <paulus@samba.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 22, 2020 at 09:45:03PM +0800, Xiaoming Ni wrote:
> On 2020/12/22 1:12, Segher Boessenkool wrote:
> >On Mon, Dec 21, 2020 at 04:42:23PM +0000, David Laight wrote:
> >>From: Segher Boessenkool
> >>>Sent: 21 December 2020 16:32
> >>>
> >>>On Mon, Dec 21, 2020 at 04:17:21PM +0100, Christophe Leroy wrote:
> >>>>Le 21/12/2020 à 04:27, Xiaoming Ni a écrit :
> >>>>>Since the commit 2b0e86cc5de6 ("powerpc/fsl_booke/32: implement KASLR
> >>>>>infrastructure"), the powerpc system is ready to support KASLR.
> >>>>>To reduces the risk of invalidating address randomization, don't print 
> >>>>>the
> >>>>>EIP/LR hex values in dump_stack() and show_regs().
> >>>
> >>>>I think your change is not enough to hide EIP address, see below a dump
> >>>>with you patch, you get "Faulting instruction address: 0xc03a0c14"
> >>>
> >>>As far as I can see the patch does nothing to the GPR printout.  Often
> >>>GPRs contain code addresses.  As one example, the LR is moved via a GPR
> >>>(often GPR0, but not always) for storing on the stack.
> >>>
> >>>So this needs more work.
> >>
> >>If the dump_stack() is from an oops you need the real EIP value
> >>on order to stand any chance of making headway.
> >
> >Or at least the function name + offset, yes.
> >
> When the system is healthy, only symbols and offsets are printed,
> Output address and symbol + offset when the system is dying
> Does this meet both debugging and security requirements?

If you have the vmlinux, sym+off is enough to find what instruction
caused the crash.

It does of course not give all the information you get in a crash dump
with all the registers, so it does hinder debugging a bit.  This is a
tradeoff.

Most debugging will need xmon or similar (or printf-style debugging)
anyway; and otoh the register dump will render KASLR largely
ineffective.

> For example:
> 
> +static void __show_regs_ip_lr(const char *flag, unsigned long addr)
> +{
> + if (system_going_down()) { /* panic oops reboot */
> +         pr_cont("%s["REG"] %pS", flag, addr, (void *)addr);
> + } else {
> +         pr_cont("%s%pS", flag, (void *)addr);
> + }
> +}

*If* you are certain the system goes down immediately, and you are also
certain this information will not help defeat ASLR after a reboot, you
could just print whatever, sure.

Otherwise, you only want to show some very few registers.  Or, make sure
no attackers can ever see these dumps (which is hard, many systems trust
all (local) users with it!)  Which means we first will need some very
different patches, before any of this can be much useful :-(


Segher
