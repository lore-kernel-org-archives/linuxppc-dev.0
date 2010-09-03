Return-Path: <willschm@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AC849B7159
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Sep 2010 06:10:17 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o83JwEZQ021013
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Sep 2010 13:58:14 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o83KAAmj110124
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Sep 2010 14:10:10 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o83KA9Ej005543
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Sep 2010 14:10:10 -0600
In-Reply-To: <4C7F3E6C.3010905@us.ibm.com>
References: <4C488CCD.60004@us.ibm.com> <20100819155824.GD2690@in.ibm.com>
	<4C7CAB72.2050305@us.ibm.com> <1283320481.32679.32.camel@concordia>
	<4C7E6CCC.8090700@us.ibm.com> <4C7E9FC1.60004@us.ibm.com>
	<1283371161.2356.53.camel@gandalf.stny.rr.com>
	<4C7EBAA8.7030601@us.ibm.com> <11579.1283389322@neuling.org>
	<1283400367.2356.69.camel@gandalf.stny.rr.com>
	<4C7F3E6C.3010905@us.ibm.com>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
To: Darren Hart <darren@dvhart.com>
Message-ID: <OF59221546.2AA75701-ON86257793.006BB148-86257793.006ECA45@us.ibm.com>
From: Will Schmidt <willschm@us.ibm.com>
Date: Fri, 3 Sep 2010 15:10:07 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=09BBFD00DFF837D88f9e8a93df938690918c09BBFD00DFF837D8"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Neuling <mikey@neuling.org>, Gautham R Shenoy <ego@in.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Ankita Garg <ankita@in.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=09BBFD00DFF837D88f9e8a93df938690918c09BBFD00DFF837D8
Content-type: text/plain; charset=US-ASCII


dvhltc@linux.vnet.ibm.com wrote on 09/02/2010 01:04:28 AM:

> Subject
>
> Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
> CONFIG_PREEMPT on pseries

> With this in place, we no longer see the preempt_count dropping below
> zero. However, if I offline/online a CPU about 246 times I hit the
> opposite problem, a preempt_count() overflow. There appears to be a
> missing preempt_enable() somewhere in the offline/online paths.

This (preempt_count overflow) also occurred in mainline (with
CONFIG_PREEMPT=y) in 2.6.35, but not in 2.6.36-rc3.   A
bisect seems to indicate it was fixed with
a7c2bb8279d20d853e43c34584eaf2b039de8026   "powerpc: Re-enable preemption
before cpu_die()".

Which may look familiar.  :-)

It looks like this patch went to mainline (likely via the powerpc tree),
but may
have not gotten back into the -rt branch.

-Will

>
> --
> Darren Hart
> IBM Linux Technology Center
> Real-Time Linux Team
--0__=09BBFD00DFF837D88f9e8a93df938690918c09BBFD00DFF837D8
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>dvhltc@linux.vnet.ibm.com wrote on 09/02/2010 01:04:28 AM:<br>
<br>
&gt; Subject</tt><br>
<tt>&gt; <br>
&gt; Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with <br>
&gt; CONFIG_PREEMPT on pseries</tt><br>
<tt>&nbsp;<br>
&gt; With this in place, we no longer see the preempt_count dropping below<br>
&gt; zero. However, if I offline/online a CPU about 246 times I hit the<br>
&gt; opposite problem, a preempt_count() overflow. There appears to be a<br>
&gt; missing preempt_enable() somewhere in the offline/online paths.</tt><br>
<br>
<tt>This (preempt_count overflow) also occurred in mainline (with</tt><br>
<tt>CONFIG_PREEMPT=y) in 2.6.35, but not in 2.6.36-rc3. &nbsp; A </tt><br>
<tt>bisect seems to indicate it was fixed with </tt><br>
<tt>a7c2bb8279d20d853e43c34584eaf2b039de8026 &nbsp; &quot;powerpc: Re-enable preemption before cpu_die()&quot;.</tt><br>
<br>
<tt>Which may look familiar. &nbsp;:-)</tt><br>
<br>
<tt>It looks like this patch went to mainline (likely via the powerpc tree), but may</tt><br>
<tt>have not gotten back into the -rt branch. &nbsp; &nbsp;</tt><br>
<br>
<tt>-Will</tt><br>
<tt><br>
&gt; <br>
&gt; -- <br>
&gt; Darren Hart<br>
&gt; IBM Linux Technology Center<br>
&gt; Real-Time Linux Team<br>
</tt></body></html>
--0__=09BBFD00DFF837D88f9e8a93df938690918c09BBFD00DFF837D8--
