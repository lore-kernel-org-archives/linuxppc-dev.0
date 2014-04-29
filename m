Return-Path: <michael.neuling@gmail.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8A68A14008E
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 17:06:05 +1000 (EST)
Received: by mail-pa0-f41.google.com with SMTP id kp14so3478212pab.28
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 00:06:03 -0700 (PDT)
MIME-Version: 1.0
Sender: michael.neuling@gmail.com
In-Reply-To: <535F4E10.2020300@linux.vnet.ibm.com>
References: <1396422144-11032-1-git-send-email-khandual@linux.vnet.ibm.com>
 <533BD922.4070009@linux.vnet.ibm.com>
 <535F4E10.2020300@linux.vnet.ibm.com>
Date: Tue, 29 Apr 2014 17:06:03 +1000
Message-ID: <CAEjGV6yi5YY95tM-HY4akN4BGXGn4chA8_sCaqvWx3HPSu2V3w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add new ptrace request macros on PowerPC
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary=047d7bacb78aa23d5304f82910cf
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
 avagin@openvz.org, roland@redhat.com, oleg@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7bacb78aa23d5304f82910cf
Content-Type: text/plain; charset=UTF-8

How is it causing the problem?

Mikey

On 29 Apr 2014 17:02, "Anshuman Khandual" <khandual@linux.vnet.ibm.com>
wrote:
>
> On 04/02/2014 03:02 PM, Anshuman Khandual wrote:
> > On 04/02/2014 12:32 PM, Anshuman Khandual wrote:
> >>      This patch series adds new ELF note sections which are used to
> >> create new ptrace request macros for various transactional memory and
> >> miscellaneous registers on PowerPC. Please find the test case
exploiting
> >> the new ptrace request macros and it's results on a POWER8 system.
> >>
> >> RFC: https://lkml.org/lkml/2014/4/1/292
> >>
> >> ============================== Results ==============================
> >> -------TM specific SPR------
> >> TM TFHAR: 100009dc
> >> TM TEXASR: de000001ac000001
> >> TM TFIAR: c00000000003f386
> >> TM CH ORIG_MSR: 900000050000f032
> >> TM CH TAR: 6
> >> TM CH PPR: c000000000000
> >> TM CH DSCR: 1
> >> -------TM checkpointed GPR-----
> >> TM CH GPR[0]: 1000097c
> >> TM CH GPR[1]: 5
> >> TM CH GPR[2]: 6
> >> TM CH GPR[7]: 1
> >> TM CH NIP: 100009dc
> >> TM CH LINK: 1000097c
> >> TM CH CCR: 22000422
> >> -------TM running GPR-----
> >> TM RN GPR[0]: 1000097c
> >> TM RN GPR[1]: 7
> >> TM RN GPR[2]: 8
> >> TM RN GPR[7]: 5
> >> TM RN NIP: 100009fc
> >> TM RN LINK: 1000097c
> >> TM RN CCR: 2000422
> >> -------TM running FPR-----
> >> TM RN FPR[0]: 1002d3a3780
> >> TM RN FPR[1]: 7
> >> TM RN FPR[2]: 8
> >> TM RN FPSCR: 0
> >> -------TM checkpointed FPR-----
> >> TM CH FPR[0]: 1002d3a3780
> >> TM CH FPR[1]: 5
> >> TM CH FPR[2]: 6
> >> TM CH FPSCR: 0
> >> -------Running miscellaneous registers-------
> > TM RN DSCR: 0
> >
> > There is a problem in here which I forgot to mention. The running DSCR
value
> > comes from thread->dscr component of the target process. While we are
inside the
> > transaction (which is the case here as we are stuck at "b ."
instruction and
> > have not reached TEND) thread->dscr should have the running value of
the DSCR
> > register at that point of time. Here we expect the DSCR value to be 5
instead
> > of 0 as shown in the output above. During the tests when I moved the "b
." after
> > TEND, the thread->dscr gets the value of 5 while all check pointed reg
values are
> > thrown away. I believe there is some problem in the way thread->dscr
context
> > is saved away inside the TM section. Will look into this problem
further and
> > keep informed.
>
> Reason behind this inconsistent DSCR register value is because of the
following commit
> where the kernel reverts the DSCR register into a default value to avoid
running with
> the user set value for a long time, thus preventing any potential
performance degradation.
> Same reason applies to the PPR register as well. So its not a problem but
an expected
> behaviour.
>
> commit e9bdc3d6143d1c4b8d8ce5231fc958268331f983
> Author: Michael Neuling <mikey@neuling.org>
> Date:   Thu Sep 26 13:29:09 2013 +1000
>
>     powerpc/tm: Switch out userspace PPR and DSCR sooner
>
>     When we do a treclaim or trecheckpoint we end up running with
userspace
>     PPR and DSCR values.  Currently we don't do anything special to avoid
>     running with user values which could cause a severe performance
>     degradation.
>
>     This patch moves the PPR and DSCR save and restore around treclaim and
>     trecheckpoint so that we run with user values for a much shorter
period.
>     More care is taken with the PPR as it's impact is greater than the
DSCR.
>
>     This is similar to user exceptions, where we run HTM_MEDIUM early to
>     ensure that we don't run with a userspace PPR values in the kernel.
>

--047d7bacb78aa23d5304f82910cf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">How is it causing the problem?</p>
<p dir=3D"ltr">Mikey</p>
<p dir=3D"ltr">On 29 Apr 2014 17:02, &quot;Anshuman Khandual&quot; &lt;<a h=
ref=3D"mailto:khandual@linux.vnet.ibm.com">khandual@linux.vnet.ibm.com</a>&=
gt; wrote:<br>
&gt;<br>
&gt; On 04/02/2014 03:02 PM, Anshuman Khandual wrote:<br>
&gt; &gt; On 04/02/2014 12:32 PM, Anshuman Khandual wrote:<br>
&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0This patch series adds new ELF note secti=
ons which are used to<br>
&gt; &gt;&gt; create new ptrace request macros for various transactional me=
mory and<br>
&gt; &gt;&gt; miscellaneous registers on PowerPC. Please find the test case=
 exploiting<br>
&gt; &gt;&gt; the new ptrace request macros and it&#39;s results on a POWER=
8 system.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; RFC: <a href=3D"https://lkml.org/lkml/2014/4/1/292">https://l=
kml.org/lkml/2014/4/1/292</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Results =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt;&gt; -------TM specific SPR------<br>
&gt; &gt;&gt; TM TFHAR: 100009dc<br>
&gt; &gt;&gt; TM TEXASR: de000001ac000001<br>
&gt; &gt;&gt; TM TFIAR: c00000000003f386<br>
&gt; &gt;&gt; TM CH ORIG_MSR: 900000050000f032<br>
&gt; &gt;&gt; TM CH TAR: 6<br>
&gt; &gt;&gt; TM CH PPR: c000000000000<br>
&gt; &gt;&gt; TM CH DSCR: 1<br>
&gt; &gt;&gt; -------TM checkpointed GPR-----<br>
&gt; &gt;&gt; TM CH GPR[0]: 1000097c<br>
&gt; &gt;&gt; TM CH GPR[1]: 5<br>
&gt; &gt;&gt; TM CH GPR[2]: 6<br>
&gt; &gt;&gt; TM CH GPR[7]: 1<br>
&gt; &gt;&gt; TM CH NIP: 100009dc<br>
&gt; &gt;&gt; TM CH LINK: 1000097c<br>
&gt; &gt;&gt; TM CH CCR: 22000422<br>
&gt; &gt;&gt; -------TM running GPR-----<br>
&gt; &gt;&gt; TM RN GPR[0]: 1000097c<br>
&gt; &gt;&gt; TM RN GPR[1]: 7<br>
&gt; &gt;&gt; TM RN GPR[2]: 8<br>
&gt; &gt;&gt; TM RN GPR[7]: 5<br>
&gt; &gt;&gt; TM RN NIP: 100009fc<br>
&gt; &gt;&gt; TM RN LINK: 1000097c<br>
&gt; &gt;&gt; TM RN CCR: 2000422<br>
&gt; &gt;&gt; -------TM running FPR-----<br>
&gt; &gt;&gt; TM RN FPR[0]: 1002d3a3780<br>
&gt; &gt;&gt; TM RN FPR[1]: 7<br>
&gt; &gt;&gt; TM RN FPR[2]: 8<br>
&gt; &gt;&gt; TM RN FPSCR: 0<br>
&gt; &gt;&gt; -------TM checkpointed FPR-----<br>
&gt; &gt;&gt; TM CH FPR[0]: 1002d3a3780<br>
&gt; &gt;&gt; TM CH FPR[1]: 5<br>
&gt; &gt;&gt; TM CH FPR[2]: 6<br>
&gt; &gt;&gt; TM CH FPSCR: 0<br>
&gt; &gt;&gt; -------Running miscellaneous registers-------<br>
&gt; &gt; TM RN DSCR: 0<br>
&gt; &gt;<br>
&gt; &gt; There is a problem in here which I forgot to mention. The running=
 DSCR value<br>
&gt; &gt; comes from thread-&gt;dscr component of the target process. While=
 we are inside the<br>
&gt; &gt; transaction (which is the case here as we are stuck at &quot;b .&=
quot; instruction and<br>
&gt; &gt; have not reached TEND) thread-&gt;dscr should have the running va=
lue of the DSCR<br>
&gt; &gt; register at that point of time. Here we expect the DSCR value to =
be 5 instead<br>
&gt; &gt; of 0 as shown in the output above. During the tests when I moved =
the &quot;b .&quot; after<br>
&gt; &gt; TEND, the thread-&gt;dscr gets the value of 5 while all check poi=
nted reg values are<br>
&gt; &gt; thrown away. I believe there is some problem in the way thread-&g=
t;dscr context<br>
&gt; &gt; is saved away inside the TM section. Will look into this problem =
further and<br>
&gt; &gt; keep informed.<br>
&gt;<br>
&gt; Reason behind this inconsistent DSCR register value is because of the =
following commit<br>
&gt; where the kernel reverts the DSCR register into a default value to avo=
id running with<br>
&gt; the user set value for a long time, thus preventing any potential perf=
ormance degradation.<br>
&gt; Same reason applies to the PPR register as well. So its not a problem =
but an expected<br>
&gt; behaviour.<br>
&gt;<br>
&gt; commit e9bdc3d6143d1c4b8d8ce5231fc958268331f983<br>
&gt; Author: Michael Neuling &lt;<a href=3D"mailto:mikey@neuling.org">mikey=
@neuling.org</a>&gt;<br>
&gt; Date: =C2=A0 Thu Sep 26 13:29:09 2013 +1000<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 powerpc/tm: Switch out userspace PPR and DSCR sooner<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 When we do a treclaim or trecheckpoint we end up running=
 with userspace<br>
&gt; =C2=A0 =C2=A0 PPR and DSCR values. =C2=A0Currently we don&#39;t do any=
thing special to avoid<br>
&gt; =C2=A0 =C2=A0 running with user values which could cause a severe perf=
ormance<br>
&gt; =C2=A0 =C2=A0 degradation.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 This patch moves the PPR and DSCR save and restore aroun=
d treclaim and<br>
&gt; =C2=A0 =C2=A0 trecheckpoint so that we run with user values for a much=
 shorter period.<br>
&gt; =C2=A0 =C2=A0 More care is taken with the PPR as it&#39;s impact is gr=
eater than the DSCR.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 This is similar to user exceptions, where we run HTM_MED=
IUM early to<br>
&gt; =C2=A0 =C2=A0 ensure that we don&#39;t run with a userspace PPR values=
 in the kernel.<br>
&gt;<br>
</p>

--047d7bacb78aa23d5304f82910cf--
