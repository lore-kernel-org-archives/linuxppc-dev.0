Return-Path: <SRS0=5lCP=YT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A502CA9EB9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Oct 2019 23:08:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B196D20863
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Oct 2019 23:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B196D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 470xVM5xX0zDqsw
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Oct 2019 10:08:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 470xSK59qRzDqs1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Oct 2019 10:06:40 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9QN6B4B014950;
 Sat, 26 Oct 2019 18:06:11 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x9QN69JB014947;
 Sat, 26 Oct 2019 18:06:09 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Sat, 26 Oct 2019 18:06:09 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] powerpc/32: Switch VDSO to C implementation.
Message-ID: <20191026230609.GY28442@gate.crashing.org>
References: <8ce3582f7f7da9ff0286ced857e5aa2e5ae6746e.1571662378.git.christophe.leroy@c-s.fr>
 <alpine.DEB.2.21.1910212312520.2078@nanos.tec.linutronix.de>
 <f4486e86-3c0c-0eec-1639-0e5956cdb8f1@c-s.fr>
 <95bd2367-8edc-29db-faa3-7729661e05f2@c-s.fr>
 <alpine.DEB.2.21.1910261751140.10190@nanos.tec.linutronix.de>
 <439bce37-9c2c-2afe-9c9e-2f500472f9f8@c-s.fr>
 <alpine.DEB.2.21.1910262026340.10190@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910262026340.10190@nanos.tec.linutronix.de>
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 luto@kernel.org, vincenzo.frascino@arm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Oct 26, 2019 at 08:48:27PM +0200, Thomas Gleixner wrote:
> On Sat, 26 Oct 2019, Christophe Leroy wrote:
> Let's look at the code:
> 
> __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
> {
>         const struct vdso_data *vd = __arch_get_vdso_data();
> 
>         if (likely(tv != NULL)) {
> 		struct __kernel_timespec ts;
> 
>                 if (do_hres(&vd[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
>                         return gettimeofday_fallback(tv, tz);
> 
>                 tv->tv_sec = ts.tv_sec;
>                 tv->tv_usec = (u32)ts.tv_nsec / NSEC_PER_USEC;
> 
> IIRC PPC did some magic math tricks to avoid that. Could you just for the
> fun of it replace this division with
> 
>        (u32)ts.tv_nsec >> 10;

On this particular CPU (the 885, right?) a division by 1000 is just 9
cycles.  On other CPUs it can be more, say 19 cycles like on the 750; not
cheap at all, but not hugely expensive either, comparatively.

(A 64/32->32 division is expensive on all 32-bit PowerPC: there is no
hardware help for it at all, so it's all done in software.)

Of course the compiler won't do a division by a constant with a division
instruction at all, so it's somewhat cheaper even, 5 or 6 cycles or so.

> One thing which might be worth to try as well is to mark all functions in
> that file as inline. The speedup by the do_hres() inlining was impressive
> on PPC.

The hand-optimised asm code will pretty likely win handsomely, whatever
you do.  Especially on cores like the 885 (no branch prediction, single
issue, small caches, etc.: every instruction counts).

Is there any reason to replace this hand-optimised code?  It was written
for exacty this reason?  These functions are critical and should be as
fast as possible.


Segher
