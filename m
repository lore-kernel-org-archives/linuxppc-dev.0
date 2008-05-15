Return-Path: <cjashfor@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7D1B5DE0D6
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 05:42:01 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4FJchSM006480
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 15:38:43 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4FJfvxX058220
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 13:41:57 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4FJfvnU012920
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 13:41:57 -0600
In-Reply-To: <1210833967.8297.76.camel@pasglop>
Subject: Re: Feedback requested on switching the exception wrapper used
	for	the PMU interrupt on ppc64
To: benh@kernel.crashing.org, Olof Johansson <olof@lixom.net>
Message-ID: <OFCAB2D7CB.BDD1D753-ON8725744A.00688AB6-8825744A.006C3754@us.ibm.com>
From: Corey J Ashford <cjashfor@us.ibm.com>
Date: Thu, 15 May 2008 12:41:55 -0700
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=08BBFED9DFFB0C268f9e8a93df938690918c08BBFED9DFFB0C26"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0__=08BBFED9DFFB0C268f9e8a93df938690918c08BBFED9DFFB0C26
Content-type: text/plain; charset=US-ASCII

Hi Benjamin and Olaf,

Thanks for the suggestions.

Ideally, what I'm looking for is something that mimics the operation of
MASKABLE_EXCEPTION_PSERIES.
I've been looking at the kernel code (entry_64.S, exception.h, head_64.S)
but am finding it quite complicated and hard to follow, particularly in the
area of interrupt disabling wrt the soft and hard disable logic.

My initial thought is to do something like this in the beginning of my
perfmon2 interrupt handler:

void perfmon_pmu_int_handler(struct pt_regs *regs) {

      if (get_paca()->soft_enabled == 0) {
            /* disable hardware interrupts */
            get_paca()->hard_enabled = 0;
            regs->msr &= ^MSR_EE;
            return;
      }
...
}

Does this seem like it might work?

Thanks

Corey Ashford
Software Engineer
IBM Linux Technology Center, Linux Toolchain
Beaverton, OR
503-578-3507
cjashfor@us.ibm.com


Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 05/14/2008
11:46:07 PM:

>
> On Tue, 2008-05-13 at 15:26 -0700, Corey Ashford wrote:
> > The perfmon2 code is available here:
> > http://sourceforge.net/project/showfiles.php?group_id=144822
> >
> > perfmon2's interrupt handler does have a single entry point.  Could I
> > somehow mimic what the MASKABLE_EXCEPTION_PSERIES macro does inside
> > of
> > the perfmon2 interrupt handler?  Are there examples of this I can look
> > at?
> >
> > That would give us the best of both worlds.
>
> You can definitely snapshot as many data as you can, and if interrupts
> are soft-disabled, just return to the caller, storing that snapshot in
> some per-cpu data structure.
>
> You can then add something to local_irq_restore() that checks whether
> some perfmon2 stuff happened and does the actual storing of the data
> that were previously collected.
>
> Cheers,
> Ben.
>
>
--0__=08BBFED9DFFB0C268f9e8a93df938690918c08BBFED9DFFB0C26
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p>Hi Benjamin and Olaf,<br>
<br>
Thanks for the suggestions.<br>
<br>
Ideally, what I'm looking for is something that mimics the operation of MASKABLE_EXCEPTION_PSERIES.<br>
I've been looking at the kernel code (entry_64.S, exception.h, head_64.S) but am finding it quite complicated and hard to follow, particularly in the area of interrupt disabling wrt the soft and hard disable logic.<br>
<br>
My initial thought is to do something like this in the beginning of my perfmon2 interrupt handler:<br>
<br>
<tt>void perfmon_pmu_int_handler(struct pt_regs *regs) {</tt><br>
<br>
<tt>	if (get_paca()-&gt;soft_enabled == 0) {</tt><br>
<tt>		/* disable hardware interrupts */</tt><br>
<tt>		get_paca()-&gt;hard_enabled = 0;</tt><br>
<tt>		regs-&gt;msr &amp;= ^MSR_EE;</tt><br>
<tt>		return;</tt><br>
<tt>	}</tt><br>
<tt>...</tt><br>
<tt>}</tt><br>
<br>
Does this seem like it might work?<br>
<br>
Thanks<br>
<br>
Corey Ashford<br>
Software Engineer<br>
IBM Linux Technology Center, Linux Toolchain<br>
Beaverton, OR <br>
503-578-3507 <br>
cjashfor@us.ibm.com<br>
<br>
<br>
<tt>Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&gt; wrote on 05/14/2008 11:46:07 PM:<br>
<br>
&gt; <br>
&gt; On Tue, 2008-05-13 at 15:26 -0700, Corey Ashford wrote:<br>
&gt; &gt; The perfmon2 code is available here: <br>
&gt; &gt; <a href="http://sourceforge.net/project/showfiles.php?group_id=144822">http://sourceforge.net/project/showfiles.php?group_id=144822</a><br>
&gt; &gt; <br>
&gt; &gt; perfmon2's interrupt handler does have a single entry point. &nbsp;Could I <br>
&gt; &gt; somehow mimic what the MASKABLE_EXCEPTION_PSERIES macro does inside<br>
&gt; &gt; of <br>
&gt; &gt; the perfmon2 interrupt handler? &nbsp;Are there examples of this I can look<br>
&gt; &gt; at?<br>
&gt; &gt; <br>
&gt; &gt; That would give us the best of both worlds.<br>
&gt; <br>
&gt; You can definitely snapshot as many data as you can, and if interrupts<br>
&gt; are soft-disabled, just return to the caller, storing that snapshot in<br>
&gt; some per-cpu data structure.<br>
&gt; <br>
&gt; You can then add something to local_irq_restore() that checks whether<br>
&gt; some perfmon2 stuff happened and does the actual storing of the data<br>
&gt; that were previously collected.<br>
&gt; <br>
&gt; Cheers,<br>
&gt; Ben.<br>
&gt; <br>
&gt; <br>
</tt></body></html>
--0__=08BBFED9DFFB0C268f9e8a93df938690918c08BBFED9DFFB0C26--
