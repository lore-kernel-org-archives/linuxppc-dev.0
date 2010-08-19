Return-Path: <willschm@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4C5BB70DD
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Aug 2010 04:58:21 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7JInRDd023630
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 12:49:27 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o7JIwHUi232810
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 12:58:17 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o7JIwFGv014191
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 12:58:17 -0600
In-Reply-To: <20100819155824.GD2690@in.ibm.com>
References: <4C488CCD.60004@us.ibm.com> <20100819155824.GD2690@in.ibm.com>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
To: Ankita Garg <ankita@in.ibm.com>
Message-ID: <OF09575C34.96A56527-ON86257784.00660539-86257784.00683561@us.ibm.com>
From: Will Schmidt <willschm@us.ibm.com>
Date: Thu, 19 Aug 2010 13:58:13 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=09BBFD17DFF583A98f9e8a93df938690918c09BBFD17DFF583A9"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	dvhltc@linux.vnet.ibm.com, Steven Rostedt <rostedt@goodmis.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=09BBFD17DFF583A98f9e8a93df938690918c09BBFD17DFF583A9
Content-type: text/plain; charset=US-ASCII

Ankita Garg <ankita@in.ibm.com> wrote on 08/19/2010 10:58:24 AM:
> Subject
> Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
> CONFIG_PREEMPT on pseries
>
> Hi Darren,
>
> On Thu, Jul 22, 2010 at 11:24:13AM -0700, Darren Hart wrote:
> >
> > With some instrumentation we were able to determine that the
> > preempt_count() appears to change across the extended_cede_processor()
> > call.  Specifically across the plpar_hcall_norets(H_CEDE) call. On
> > PREEMPT_RT we call this with preempt_count=1 and return with
> > preempt_count=0xffffffff. On mainline with CONFIG_PREEMPT=y, the value
> > is different (0x65) but is still incorrect.
>
> I was trying to reproduce this issue on a 2.6.33.7-rt29 kernel. I could
> easily reproduce this on the RT kernel and not the non-RT kernel.
> However, I hit it every single time I did a cpu online operation. I also
> noticed that the issue persists even when I disable H_CEDE by passing
> the "cede_offline=0" kernel commandline parameter. Could you pl confirm
> if you observe the same in your setup ?

If you see it every time, double-check that you have
http://patchwork.ozlabs.org/patch/60922/  or an equivalent in your tree.
(The
patch moves the preempt_enable_no_resched() call up above a call to cpu_die
().  An
earlier variation called a preempt_enable before calling
start_secondary_resume()).

Darren and I have been seeing different problems (different
dedicated-processor LPARS
on the same physical system).  He's seeing scrambled preempt_count values,
I'm tending
to see a system hang/death [with processor backtraces
showing .pseries_mach_cpu_die or
.pseries_dedicated_idle_sleep as expected, but no processes running] .

I'll be curious which you end up seeing.   With 2.6.33.7-rt27 as of a few
minutes ago,
I'm still seeing a system hang/death.



>
> However, the issue still remains. Will spend few cycles looking into
> this issue.
>
> >
> > Also of interest is that this path
> > cpu_idle()->cpu_die()->pseries_mach_cpu_die() to start_secondary()
> > enters with a preempt_count=1 if it wasn't corrupted across the hcall.
> > The early boot path from _start however appears to call
> > start_secondary() with a preempt_count of 0.
> >
> > The following patch is most certainly not correct, but it does
eliminate
> > the situation on mainline 100% of the time (there is still a 25%
> > reproduction rate on PREEMPT_RT). Can someone comment on:
> >
> > 1) How can the preempt_count() get mangled across the H_CEDE hcall?
> > 2) Should we call preempt_enable() in cpu_idle() prior to cpu_die() ?
> >
> > Hacked-up-by: Darren Hart <dvhltc@us.ibm.com>
> >
> > Index: linux-2.6.33.6/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > ===================================================================
> > --- linux-2.6.33.6.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > +++ linux-2.6.33.6/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > @@ -138,6 +138,7 @@ static void pseries_mach_cpu_die(void)
> >            * Kernel stack will be reset and start_secondary()
> >            * will be called to continue the online operation.
> >            */
> > +         preempt_count() = 0;
> >           start_secondary_resume();
> >        }
> >     }
> >
> >
>
> --
> Regards,
> Ankita Garg (ankita@in.ibm.com)
> Linux Technology Center
> IBM India Systems & Technology Labs,
> Bangalore, India
--0__=09BBFD17DFF583A98f9e8a93df938690918c09BBFD17DFF583A9
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>Ankita Garg &lt;ankita@in.ibm.com&gt; wrote on 08/19/2010 10:58:24 AM:<br>
&gt; Subject</tt><br>
<tt>&gt; Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with <br>
&gt; CONFIG_PREEMPT on pseries</tt><br>
<tt>&gt; <br>
&gt; Hi Darren,<br>
&gt; <br>
&gt; On Thu, Jul 22, 2010 at 11:24:13AM -0700, Darren Hart wrote:<br>
&gt; &gt; <br>
&gt; &gt; With some instrumentation we were able to determine that the<br>
&gt; &gt; preempt_count() appears to change across the extended_cede_processor()<br>
&gt; &gt; call. &nbsp;Specifically across the plpar_hcall_norets(H_CEDE) call. On<br>
&gt; &gt; PREEMPT_RT we call this with preempt_count=1 and return with<br>
&gt; &gt; preempt_count=0xffffffff. On mainline with CONFIG_PREEMPT=y, the value<br>
&gt; &gt; is different (0x65) but is still incorrect.<br>
&gt; <br>
&gt; I was trying to reproduce this issue on a 2.6.33.7-rt29 kernel. I could<br>
&gt; easily reproduce this on the RT kernel and not the non-RT kernel.<br>
&gt; However, I hit it every single time I did a cpu online operation. I also<br>
&gt; noticed that the issue persists even when I disable H_CEDE by passing<br>
&gt; the &quot;cede_offline=0&quot; kernel commandline parameter. Could you pl confirm<br>
&gt; if you observe the same in your setup ? </tt><br>
<br>
<tt>If you see it every time, double-check that you have </tt><br>
<tt><a href="http://patchwork.ozlabs.org/patch/60922/">http://patchwork.ozlabs.org/patch/60922/</a> &nbsp;or an equivalent in your tree. &nbsp;(The</tt><br>
<tt>patch moves the preempt_enable_no_resched() call up above a call to cpu_die(). &nbsp;An</tt><br>
<tt>earlier variation called a preempt_enable before calling start_secondary_resume()).</tt><br>
<br>
<tt>Darren and I have been seeing different problems (different dedicated-processor LPARS</tt><br>
<tt>on the same physical system). &nbsp;He's seeing scrambled preempt_count values, I'm tending</tt><br>
<tt>to see a system hang/death [with processor backtraces showing .pseries_mach_cpu_die or</tt><br>
<tt>.pseries_dedicated_idle_sleep as expected, but no processes running] .</tt><br>
<br>
<tt>I'll be curious which you end up seeing. &nbsp; With 2.6.33.7-rt27 as of a few minutes ago, </tt><br>
<tt>I'm still seeing a system hang/death.</tt><br>
<br>
<br>
<tt><br>
&gt; <br>
&gt; However, the issue still remains. Will spend few cycles looking into<br>
&gt; this issue.<br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; Also of interest is that this path<br>
&gt; &gt; cpu_idle()-&gt;cpu_die()-&gt;pseries_mach_cpu_die() to start_secondary()<br>
&gt; &gt; enters with a preempt_count=1 if it wasn't corrupted across the hcall.<br>
&gt; &gt; The early boot path from _start however appears to call<br>
&gt; &gt; start_secondary() with a preempt_count of 0.<br>
&gt; &gt; <br>
&gt; &gt; The following patch is most certainly not correct, but it does eliminate<br>
&gt; &gt; the situation on mainline 100% of the time (there is still a 25%<br>
&gt; &gt; reproduction rate on PREEMPT_RT). Can someone comment on:<br>
&gt; &gt; <br>
&gt; &gt; 1) How can the preempt_count() get mangled across the H_CEDE hcall?<br>
&gt; &gt; 2) Should we call preempt_enable() in cpu_idle() prior to cpu_die() ?<br>
&gt; &gt; <br>
&gt; &gt; Hacked-up-by: Darren Hart &lt;dvhltc@us.ibm.com&gt;<br>
&gt; &gt; <br>
&gt; &gt; Index: linux-2.6.33.6/arch/powerpc/platforms/pseries/hotplug-cpu.c<br>
&gt; &gt; ===================================================================<br>
&gt; &gt; --- linux-2.6.33.6.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c<br>
&gt; &gt; +++ linux-2.6.33.6/arch/powerpc/platforms/pseries/hotplug-cpu.c<br>
&gt; &gt; @@ -138,6 +138,7 @@ static void pseries_mach_cpu_die(void)<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* Kernel stack will be reset and start_secondary()<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* will be called to continue the online operation.<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; preempt_count() = 0;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; start_secondary_resume();<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; &gt; &nbsp; &nbsp; }<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Regards,<br>
&gt; Ankita Garg (ankita@in.ibm.com)<br>
&gt; Linux Technology Center<br>
&gt; IBM India Systems &amp; Technology Labs,<br>
&gt; Bangalore, India<br>
</tt></body></html>
--0__=09BBFD17DFF583A98f9e8a93df938690918c09BBFD17DFF583A9--
