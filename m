Return-Path: <cjashfor@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D1FA5DDF0C
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 10:26:23 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4G0N1o1028044
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 20:23:01 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4G0QKfT108304
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 18:26:20 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4G0QJQR026797
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 18:26:20 -0600
In-Reply-To: <18476.51426.864747.201527@cargo.ozlabs.ibm.com>
Subject: Re: Feedback requested on switching the exception wrapper
	used	for	the PMU interrupt on ppc64
To: Paul Mackerras <paulus@samba.org>
Message-ID: <OF9F7498FD.1A1E4CC2-ON8725744B.000071C8-8825744B.00026A92@us.ibm.com>
From: Corey J Ashford <cjashfor@us.ibm.com>
Date: Thu, 15 May 2008 17:26:18 -0700
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=08BBFED8DF93F7588f9e8a93df938690918c08BBFED8DF93F758"
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0__=08BBFED8DF93F7588f9e8a93df938690918c08BBFED8DF93F758
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



Paul Mackerras <paulus@samba.org> wrote on 05/15/2008 04:36:02 PM:

> Corey J Ashford writes:
>
> > Ideally, what I'm looking for is something that mimics the operatio=
n of
> > MASKABLE_EXCEPTION_PSERIES.
> > I've been looking at the kernel code (entry_64.S, exception.h,
head_64.S)
> > but am finding it quite complicated and hard to follow, particularl=
y in
the
> > area of interrupt disabling wrt the soft and hard disable logic.
> >
> > My initial thought is to do something like this in the beginning of=
 my
> > perfmon2 interrupt handler:
> >
> > void perfmon_pmu_int_handler(struct pt_regs *regs) {
> >
> >       if (get_paca()->soft_enabled =3D=3D 0) {
> >             /* disable hardware interrupts */
> >             get_paca()->hard_enabled =3D 0;
> >             regs->msr &=3D ^MSR_EE;
> >             return;
> >       }
> > ...
> > }
> >
> > Does this seem like it might work?
>
> That's a start (with ~MSR_EE rather than ^MSR_EE, of course).  You
> also need to set a flag in that case, and test the flag in the part o=
f
> arch/powerpc/kernel/irq.c:raw_local_irq_restore() that hard-enables
> interrupts.  If the flag is set then you should call back into the
> perfmon2 code at that point (and clear the flag, of course).  You
> could add a field to the paca for that flag.
>
> You probably also want to read some of the PMU's SPRs when you first
> get the interrupt and save their values away, and then when you get
> the call back from raw_local_irq_restore, use the saved values rather=

> than what's currently in the SPRs, since the saved values will be mor=
e
> accurate.
>
> Paul.

Hi Paul,

Thanks for the feedback.  I don't believe I need a separate flag, becau=
se
the PMU interrupt (via the PMAO bit) will still be pending when interru=
pts
are hard enabled again, and the handler will be reentered automatically=
.

I'll think about the issue of caching the SPR values some more, but I d=
on't
want to complicate things too much.  PMU event counts are not so critic=
al
that they need to so accurately reflect the exact value at the time of =
the
interrupt.

I discovered through some trial and error that get_paca() doesn't work
correctly in the interrupt handler.  It appears that the value of r13 (=
the
PACA pointer) is not initialized.  Perhaps r13 is a scratch register us=
ed
by the compiler?

Fortunately, because the soft enable flag is available in the pt_regs
structure, and because the hard enable flag will be set to the same as =
the
value of regs->msr's MSR_EE flag in the restore code, I now have this c=
ode
in the interrupt handler:

void perfmon_pmu_int_handler(struct pt_regs *regs) {

      if (regs->softe =3D=3D 0) {
            /* disable hardware interrupts */
            regs->msr &=3D ~MSR_EE;
            return;
      }
      ...
}

This code does seem to be working, but needs more testing.

Regards,

- Corey

Corey Ashford
Software Engineer
IBM Linux Technology Center, Linux Toolchain
Beaverton, OR
503-578-3507
cjashfor@us.ibm.com
=

--0__=08BBFED8DF93F7588f9e8a93df938690918c08BBFED8DF93F758
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>Paul Mackerras &lt;paulus@samba.org&gt; wrote on 05/15/2008 04:3=
6:02 PM:<br>
<br>
&gt; Corey J Ashford writes:<br>
&gt; <br>
&gt; &gt; Ideally, what I'm looking for is something that mimics the op=
eration of<br>
&gt; &gt; MASKABLE_EXCEPTION_PSERIES.<br>
&gt; &gt; I've been looking at the kernel code (entry_64.S, exception.h=
, head_64.S)<br>
&gt; &gt; but am finding it quite complicated and hard to follow, parti=
cularly in the<br>
&gt; &gt; area of interrupt disabling wrt the soft and hard disable log=
ic.<br>
&gt; &gt; <br>
&gt; &gt; My initial thought is to do something like this in the beginn=
ing of my<br>
&gt; &gt; perfmon2 interrupt handler:<br>
&gt; &gt; <br>
&gt; &gt; void perfmon_pmu_int_handler(struct pt_regs *regs) {<br>
&gt; &gt; <br>
&gt; &gt; &nbsp; &nbsp; &nbsp; if (get_paca()-&gt;soft_enabled =3D=3D 0=
) {<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* disable hardware=
 interrupts */<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; get_paca()-&gt;hard=
_enabled =3D 0;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; regs-&gt;msr &amp;=3D=
 ^MSR_EE;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; }<br>
&gt; &gt; ...<br>
&gt; &gt; }<br>
&gt; &gt; <br>
&gt; &gt; Does this seem like it might work?<br>
&gt; <br>
&gt; That's a start (with ~MSR_EE rather than ^MSR_EE, of course). &nbs=
p;You<br>
&gt; also need to set a flag in that case, and test the flag in the par=
t of<br>
&gt; arch/powerpc/kernel/irq.c:raw_local_irq_restore() that hard-enable=
s<br>
&gt; interrupts. &nbsp;If the flag is set then you should call back int=
o the<br>
&gt; perfmon2 code at that point (and clear the flag, of course). &nbsp=
;You<br>
&gt; could add a field to the paca for that flag.<br>
&gt; <br>
&gt; You probably also want to read some of the PMU's SPRs when you fir=
st<br>
&gt; get the interrupt and save their values away, and then when you ge=
t<br>
&gt; the call back from raw_local_irq_restore, use the saved values rat=
her<br>
&gt; than what's currently in the SPRs, since the saved values will be =
more<br>
&gt; accurate.<br>
&gt; <br>
&gt; Paul.</tt><br>
<tt><br>
Hi Paul,</tt><br>
<br>
<tt>Thanks for the feedback. &nbsp;I don't believe I need a separate fl=
ag, because the PMU interrupt (via the PMAO bit) will still be pending =
when interrupts are hard enabled again, and the handler will be reenter=
ed automatically.</tt><br>
<br>
<tt>I'll think about the issue of caching the SPR values some more, but=
 I don't want to complicate things too much. &nbsp;PMU event counts are=
 not so critical that they need to so accurately reflect the exact valu=
e at the time of the interrupt.</tt><br>
<br>
<tt>I discovered through some trial and error that get_paca() doesn't w=
ork correctly in the interrupt handler. &nbsp;It appears that the value=
 of r13 (the PACA pointer) is not initialized. &nbsp;Perhaps r13 is a s=
cratch register used by the compiler?</tt><br>
<br>
<tt>Fortunately, because the soft enable flag is available in the pt_re=
gs structure, and because the hard enable flag will be set to the same =
as the value of regs-&gt;msr's MSR_EE flag in the restore code, I now h=
ave this code in the interrupt handler:</tt><br>
<br>
<tt>void perfmon_pmu_int_handler(struct pt_regs *regs) {<br>
<br>
	if (regs-&gt;softe =3D=3D 0) {<br>
		/* disable hardware interrupts */<br>
		regs-&gt;msr &amp;=3D ~MSR_EE;<br>
		return;</tt><br>
<tt>	}</tt><br>
<tt>	...</tt><br>
<tt>}<br>
</tt><br>
<tt>This code does seem to be working, but needs more testing.</tt><br>=

<br>
<tt>Regards,</tt><br>
<br>
<tt>- Corey</tt><br>
<br>
<tt>Corey Ashford<br>
Software Engineer<br>
IBM Linux Technology Center, Linux Toolchain<br>
Beaverton, OR <br>
503-578-3507 <br>
cjashfor@us.ibm.com<br>
</tt><br>
</body></html>=

--0__=08BBFED8DF93F7588f9e8a93df938690918c08BBFED8DF93F758--
