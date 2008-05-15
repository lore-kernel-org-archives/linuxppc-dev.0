Return-Path: <cjashfor@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B5A27DDF47
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 08:36:17 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4FMaDqF026417
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 18:36:13 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4FMaDZ5056588
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 16:36:13 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4FMaDhJ014707
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 16:36:13 -0600
In-Reply-To: <OFCAB2D7CB.BDD1D753-ON8725744A.00688AB6-8825744A.006C3754@us.ibm.com>
Subject: Re: Feedback requested on switching the exception wrapper
	used	for	the PMU interrupt on ppc64
To: linuxppc-dev@ozlabs.org
Message-ID: <OF79210387.4D8FF130-ON8725744A.007BDD3D-8825744A.007C2BAF@us.ibm.com>
From: Corey J Ashford <cjashfor@us.ibm.com>
Date: Thu, 15 May 2008 15:36:11 -0700
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=08BBFED9DFE85BAD8f9e8a93df938690918c08BBFED9DFE85BAD"
Cc: Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0__=08BBFED9DFE85BAD8f9e8a93df938690918c08BBFED9DFE85BAD
Content-type: text/plain; charset=US-ASCII

Just FYI:  I just tried out the code I suggested below, and it does not
work; it results in a system hang.  I have spent some time analyzing why
this doesn't work as I expected, but so far I haven't been able to figure
it out.

Regards,

Corey Ashford
Software Engineer
IBM Linux Technology Center, Linux Toolchain
Beaverton, OR
503-578-3507
cjashfor@us.ibm.com


linuxppc-dev-bounces+cjashfor=us.ibm.com@ozlabs.org wrote on 05/15/2008
12:41:55 PM:

> Hi Benjamin and Olaf,
>
> Thanks for the suggestions.
>
> Ideally, what I'm looking for is something that mimics the operation
> of MASKABLE_EXCEPTION_PSERIES.
> I've been looking at the kernel code (entry_64.S, exception.h,
> head_64.S) but am finding it quite complicated and hard to follow,
> particularly in the area of interrupt disabling wrt the soft and
> hard disable logic.
>
> My initial thought is to do something like this in the beginning of
> my perfmon2 interrupt handler:
>
> void perfmon_pmu_int_handler(struct pt_regs *regs) {
>
> if (get_paca()->soft_enabled == 0) {
> /* disable hardware interrupts */
> get_paca()->hard_enabled = 0;
> regs->msr &= ^MSR_EE;
> return;
> }
> ...
> }
>
> Does this seem like it might work?
>
> Thanks
>
> Corey Ashford
> Software Engineer
> IBM Linux Technology Center, Linux Toolchain
> Beaverton, OR
> 503-578-3507
> cjashfor@us.ibm.com
>
>
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on
> 05/14/2008 11:46:07 PM:
>
> >
> > On Tue, 2008-05-13 at 15:26 -0700, Corey Ashford wrote:
> > > The perfmon2 code is available here:
> > > http://sourceforge.net/project/showfiles.php?group_id=144822
> > >
> > > perfmon2's interrupt handler does have a single entry point.  Could I

> > > somehow mimic what the MASKABLE_EXCEPTION_PSERIES macro does inside
> > > of
> > > the perfmon2 interrupt handler?  Are there examples of this I can
look
> > > at?
> > >
> > > That would give us the best of both worlds.
> >
> > You can definitely snapshot as many data as you can, and if interrupts
> > are soft-disabled, just return to the caller, storing that snapshot in
> > some per-cpu data structure.
> >
> > You can then add something to local_irq_restore() that checks whether
> > some perfmon2 stuff happened and does the actual storing of the data
> > that were previously collected.
> >
> > Cheers,
> > Ben.
> >
> > _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
--0__=08BBFED9DFE85BAD8f9e8a93df938690918c08BBFED9DFE85BAD
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p>Just FYI:  I just tried out the code I suggested below, and it does not work; it results in a system hang.  I have spent some time analyzing why this doesn't work as I expected, but so far I haven't been able to figure it out.<br>
<br>
Regards,<br>
<br>
Corey Ashford<br>
Software Engineer<br>
IBM Linux Technology Center, Linux Toolchain<br>
Beaverton, OR <br>
503-578-3507 <br>
cjashfor@us.ibm.com<br>
<br>
<br>
<tt>linuxppc-dev-bounces+cjashfor=us.ibm.com@ozlabs.org wrote on 05/15/2008 12:41:55 PM:<br>
<br>
&gt; Hi Benjamin and Olaf,<br>
&gt; <br>
&gt; Thanks for the suggestions.<br>
&gt; <br>
&gt; Ideally, what I'm looking for is something that mimics the operation<br>
&gt; of MASKABLE_EXCEPTION_PSERIES.<br>
&gt; I've been looking at the kernel code (entry_64.S, exception.h, <br>
&gt; head_64.S) but am finding it quite complicated and hard to follow, <br>
&gt; particularly in the area of interrupt disabling wrt the soft and <br>
&gt; hard disable logic.<br>
&gt; <br>
&gt; My initial thought is to do something like this in the beginning of <br>
&gt; my perfmon2 interrupt handler:<br>
&gt; <br>
&gt; void perfmon_pmu_int_handler(struct pt_regs *regs) {<br>
&gt; <br>
&gt; if (get_paca()-&gt;soft_enabled == 0) {<br>
&gt; /* disable hardware interrupts */<br>
&gt; get_paca()-&gt;hard_enabled = 0;<br>
&gt; regs-&gt;msr &amp;= ^MSR_EE;<br>
&gt; return;<br>
&gt; }<br>
&gt; ...<br>
&gt; }<br>
&gt; <br>
&gt; Does this seem like it might work?<br>
&gt; <br>
&gt; Thanks<br>
&gt; <br>
&gt; Corey Ashford<br>
&gt; Software Engineer<br>
&gt; IBM Linux Technology Center, Linux Toolchain<br>
&gt; Beaverton, OR <br>
&gt; 503-578-3507 <br>
&gt; cjashfor@us.ibm.com<br>
&gt; <br>
&gt; <br>
&gt; Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&gt; wrote on <br>
&gt; 05/14/2008 11:46:07 PM:<br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; On Tue, 2008-05-13 at 15:26 -0700, Corey Ashford wrote:<br>
&gt; &gt; &gt; The perfmon2 code is available here: <br>
&gt; &gt; &gt; <a href="http://sourceforge.net/project/showfiles.php?group_id=144822">http://sourceforge.net/project/showfiles.php?group_id=144822</a><br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; perfmon2's interrupt handler does have a single entry point. &nbsp;Could I <br>
&gt; &gt; &gt; somehow mimic what the MASKABLE_EXCEPTION_PSERIES macro does inside<br>
&gt; &gt; &gt; of <br>
&gt; &gt; &gt; the perfmon2 interrupt handler? &nbsp;Are there examples of this I can look<br>
&gt; &gt; &gt; at?<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; That would give us the best of both worlds.<br>
&gt; &gt; <br>
&gt; &gt; You can definitely snapshot as many data as you can, and if interrupts<br>
&gt; &gt; are soft-disabled, just return to the caller, storing that snapshot in<br>
&gt; &gt; some per-cpu data structure.<br>
&gt; &gt; <br>
&gt; &gt; You can then add something to local_irq_restore() that checks whether<br>
&gt; &gt; some perfmon2 stuff happened and does the actual storing of the data<br>
&gt; &gt; that were previously collected.<br>
&gt; &gt; <br>
&gt; &gt; Cheers,<br>
&gt; &gt; Ben.<br>
&gt; &gt; <br>
&gt; &gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; Linuxppc-dev@ozlabs.org<br>
&gt; <a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a></tt></body></html>
--0__=08BBFED9DFE85BAD8f9e8a93df938690918c08BBFED9DFE85BAD--
