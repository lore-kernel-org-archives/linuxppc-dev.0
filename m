Return-Path: <cjashfor@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 001CADEDB9
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 07:25:44 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4GLPaqg002041
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 17:25:36 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4GLParZ094822
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 15:25:36 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4GLPaCY008004
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 15:25:36 -0600
In-Reply-To: <18476.56587.887087.503435@cargo.ozlabs.ibm.com>
Subject: Re: Feedback requested on switching the exception wrapper
	used	for	the PMU interrupt on ppc64
To: Paul Mackerras <paulus@samba.org>
Message-ID: <OFC7EADF7A.153B9685-ON8725744B.006297D2-8825744B.0075B487@us.ibm.com>
From: Corey J Ashford <cjashfor@us.ibm.com>
Date: Fri, 16 May 2008 14:25:34 -0700
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=08BBFED8DFF111428f9e8a93df938690918c08BBFED8DFF11142"
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0__=08BBFED8DFF111428f9e8a93df938690918c08BBFED8DFF11142
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


Paul Mackerras <paulus@samba.org> wrote on 05/15/2008 06:02:03 PM:

> Corey J Ashford writes:
>
> > Thanks for the feedback.  I don't believe I need a separate flag,
because
> > the PMU interrupt (via the PMAO bit) will still be pending when
interrupts
> > are hard enabled again, and the handler will be reentered
automatically.
>
> If that were the case then we wouldn't have had the problem with
> losing PMU interrupts that meant we had to change the PMU interrupt
> handler from a MASKABLE_EXCEPTION to a STD_EXCEPTION.  This was in
> commit 449d846dbcbf61bdf7d50a923e4791102168c292.
>
> My understanding is that the PMU only requests an interrupt when PMAO=

> goes from 0 to 1 (i.e. it's edge-triggered).  If the CPU takes the
> interrupt and then sets MSR.EE again (e.g. by returning from the
> interrupt handler), and PMAO has not been reset to 0, then I don't
> think the PMU requests another interrupt at that point.
>

I went back and looked through my notes, and found that the problem wit=
h
looping in the interrupt handler I had a couple of months ago was not w=
ith
PMAO not being cleared, but because there were unused counters (PMC5 an=
d/or
PMC6) were not zeroed out in the interrupt handler and so they continue=
d to
count past 0x80000000, causing PMAO to become asserted on every count.
This was on POWER5+, and so the behavior may be different on other chip=
s.
I do find it a little odd that it would set PMAO on every count past
0x80000000, instead of just on the transition from 0x7fffffff to
0x80000000.

In any case, I do need to save the fact that an interrupt occurred and =
to
reassert the interrupt in local_irq_restore (it appears to be the case =
that
raw_local_irq_restore for POWER is new in 2.6.26.  I'm working on 2.6.2=
5 at
the moment)

Thanks for your reply, as it could have taken me a long time to find th=
is
problem otherwise.

- Corey

Corey Ashford
Software Engineer
IBM Linux Technology Center, Linux Toolchain
Beaverton, OR
503-578-3507
cjashfor@us.ibm.com=

--0__=08BBFED8DFF111428f9e8a93df938690918c08BBFED8DFF11142
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>Paul Mackerras &lt;paulus@samba.org&gt; wrote on 05/15/2008 06:0=
2:03 PM:<br>
<br>
&gt; Corey J Ashford writes:<br>
&gt; <br>
&gt; &gt; Thanks for the feedback. &nbsp;I don't believe I need a separ=
ate flag, because<br>
&gt; &gt; the PMU interrupt (via the PMAO bit) will still be pending wh=
en interrupts<br>
&gt; &gt; are hard enabled again, and the handler will be reentered aut=
omatically.<br>
&gt; <br>
&gt; If that were the case then we wouldn't have had the problem with<b=
r>
&gt; losing PMU interrupts that meant we had to change the PMU interrup=
t<br>
&gt; handler from a MASKABLE_EXCEPTION to a STD_EXCEPTION. &nbsp;This w=
as in<br>
&gt; commit 449d846dbcbf61bdf7d50a923e4791102168c292.<br>
&gt; <br>
&gt; My understanding is that the PMU only requests an interrupt when P=
MAO<br>
&gt; goes from 0 to 1 (i.e. it's edge-triggered). &nbsp;If the CPU take=
s the<br>
&gt; interrupt and then sets MSR.EE again (e.g. by returning from the<b=
r>
&gt; interrupt handler), and PMAO has not been reset to 0, then I don't=
<br>
&gt; think the PMU requests another interrupt at that point.<br>
&gt; <br>
</tt><br>
<tt>I went back and looked through my notes, and found that the problem=
 with looping in the interrupt handler I had a couple of months ago was=
 not with PMAO not being cleared, but because there were unused counter=
s (PMC5 and/or PMC6) were not zeroed out in the interrupt handler and s=
o they continued to count past 0x80000000, causing PMAO to become asser=
ted on every count. &nbsp;This was on POWER5+, and so the behavior may =
be different on other chips. &nbsp;I do find it a little odd that it wo=
uld set PMAO on every count past 0x80000000, instead of just on the tra=
nsition from 0x7fffffff to 0x80000000.</tt><br>
<br>
<tt>In any case, I do need to save the fact that an interrupt occurred =
and to reassert the interrupt in local_irq_restore (it appears to be th=
e case that raw_local_irq_restore for POWER is new in 2.6.26. &nbsp;I'm=
 working on 2.6.25 at the moment)</tt><br>
<br>
<tt>Thanks for your reply, as it could have taken me a long time to fin=
d this problem otherwise.</tt><br>
<br>
<tt>- Corey</tt><br>
<br>
<tt>Corey Ashford<br>
Software Engineer<br>
IBM Linux Technology Center, Linux Toolchain<br>
Beaverton, OR <br>
503-578-3507 <br>
cjashfor@us.ibm.com<br>
</tt></body></html>=

--0__=08BBFED8DFF111428f9e8a93df938690918c08BBFED8DFF11142--
