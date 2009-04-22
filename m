Return-Path: <stefan.roscher@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 85D3CDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 19:11:13 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.14.3/8.13.8) with ESMTP id n3M9B70b535354
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 09:11:07 GMT
Received: from d12av06.megacenter.de.ibm.com (d12av06.megacenter.de.ibm.com
	[9.149.165.230])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n3M9B7LA3301400
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 11:11:07 +0200
Received: from d12av06.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av06.megacenter.de.ibm.com (8.13.1/8.13.3) with ESMTP id
	n3M9B6Ec032134
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 11:11:07 +0200
In-Reply-To: <adaws9dvrkp.fsf@cisco.com>
References: <200904211716.45245.ossrosch@linux.vnet.ibm.com>
	<adaws9dvrkp.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] IB/ehca: Replace vmalloc with kmalloc
From: Stefan Roscher <stefan.roscher@de.ibm.com>
Message-ID: <OFBD0C452F.7D324196-ONC12575A0.002FE221-C12575A0.0032741F@de.ibm.com>
Date: Wed, 22 Apr 2009 11:11:04 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 00312AD7C12575A0_="
Cc: Joachim Fenkes <FENKES@de.ibm.com>, OF-EWG <ewg@lists.openfabrics.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	Alexander Schmidt1 <ALEXSCHM@de.ibm.com>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 00312AD7C12575A0_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Roland,=20
thanks for the quick review. I was hoping you could apply these changes=20
for 2.6.30 because this will be the codebase for the next OFED release.
The patch is well tested in HPC environment and we haven't seen any=20
issues.
Regarding Antons patch you are right. If a user allocates an=20
unrealistically large queue pair it could happen that kmalloc() is not=20
able to allocate the memory. In this case we will return ENOMEM to the=20
user so the kernel will not be affected at all. We plan to add vmalloc()=20
call in case kmalloc() fails for the next kernel release.
=20
Mit freundlichen Gr=FC=DFen / Kind regards
=20
Stefan Roscher
=20
eHCA/eHEA Linux Driver Development
IBM Systems &Technology Group, Systems Software Development / FW I/O=20
Firmware Entwicklung 2
---------------------------------------------------------------------------=
----------------------------------------------------------------
IBM Deutschland
Schoenaicher Str. 220
71032 Boeblingen
Phone: +49-7031-16-2015
E-Mail: stefan.roscher@de.ibm.com
---------------------------------------------------------------------------=
----------------------------------------------------------------
IBM Deutschland Research & Development GmbH / Vorsitzender des=20
Aufsichtsrats: Martin Jetter
Gesch=E4ftsf=FChrung: Herbert Kircher
Sitz der Gesellschaft: B=F6blingen / Registergericht: Amtsgericht Stuttgart=
,=20
HRB 243294



From:
Roland Dreier <rdreier@cisco.com>
To:
Stefan Roscher <ossrosch@linux.vnet.ibm.com>
Cc:
"LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>, LKML=20
<linux-kernel@vger.kernel.org>, "OF-EWG" <ewg@lists.openfabrics.org>,=20
Roland Dreier <rolandd@cisco.com>, Joachim Fenkes/Germany/IBM@IBMDE,=20
Christoph Raisch/Germany/IBM@IBMDE, Alexander Schmidt1/Germany/IBM@IBMDE,=20
Stefan Roscher/Germany/IBM@IBMDE, Hoang-Nam Nguyen/Germany/IBM@IBMDE
Date:
21.04.2009 19:34
Subject:
Re: [PATCH 1/3] IB/ehca: Replace vmalloc with kmalloc



 > +             queue->queue=5Fpages =3D kmalloc(nr=5Fof=5Fpages * sizeof(=
void=20
*), GFP=5FKERNEL);

How big might this buffer be?  Any chance of allocation failure due to
memory fragmentation?

 - R.



--=_alternative 00312AD7C12575A0_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hi Roland, </font>
<br><font size=3D2 face=3D"sans-serif">thanks for the quick review. I was h=
oping
you could apply these changes for 2.6.30 because this will be the codebase
for the next OFED release.</font>
<br><font size=3D2 face=3D"sans-serif">The patch is well tested in HPC envi=
ronment
and we haven't seen any issues.</font>
<br><font size=3D2 face=3D"sans-serif">Regarding Antons patch you are right.
If a user allocates an unrealistically large queue pair it could happen
that kmalloc() is not able to allocate the memory. In this case we will
return ENOMEM to the user so the kernel will not be affected at all. We
plan to add vmalloc() call in case kmalloc() fails for the next kernel
release.</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;</font>
<br><font size=3D2 face=3D"sans-serif">Mit freundlichen Gr=FC=DFen / Kind r=
egards<br>
 <br>
Stefan Roscher<br>
 <br>
eHCA/eHEA Linux Driver Development<br>
IBM Systems &amp;Technology Group, Systems Software Development / FW I/O
Firmware Entwicklung 2<br>
---------------------------------------------------------------------------=
----------------------------------------------------------------<br>
IBM Deutschland<br>
Schoenaicher Str. 220<br>
71032 Boeblingen<br>
Phone: +49-7031-16-2015<br>
E-Mail: stefan.roscher@de.ibm.com<br>
---------------------------------------------------------------------------=
----------------------------------------------------------------<br>
IBM Deutschland Research &amp; Development GmbH / Vorsitzender des Aufsicht=
srats:
Martin Jetter<br>
Gesch=E4ftsf=FChrung: Herbert Kircher<br>
Sitz der Gesellschaft: B=F6blingen / Registergericht: Amtsgericht Stuttgart,
HRB 243294</font>
<br>
<br>
<br>
<table width=3D100%>
<tr valign=3Dtop>
<td><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">From:</font>
<td><font size=3D1 face=3D"sans-serif">Roland Dreier &lt;rdreier@cisco.com&=
gt;</font>
<tr valign=3Dtop>
<td><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To:</font>
<td><font size=3D1 face=3D"sans-serif">Stefan Roscher &lt;ossrosch@linux.vn=
et.ibm.com&gt;</font>
<tr>
<td valign=3Dtop><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc:</fo=
nt>
<td><font size=3D1 face=3D"sans-serif">&quot;LinuxPPC-Dev&quot; &lt;linuxpp=
c-dev@ozlabs.org&gt;,
LKML &lt;linux-kernel@vger.kernel.org&gt;, &quot;OF-EWG&quot; &lt;ewg@lists=
.openfabrics.org&gt;,
Roland Dreier &lt;rolandd@cisco.com&gt;, Joachim Fenkes/Germany/IBM@IBMDE,
Christoph Raisch/Germany/IBM@IBMDE, Alexander Schmidt1/Germany/IBM@IBMDE,
Stefan Roscher/Germany/IBM@IBMDE, Hoang-Nam Nguyen/Germany/IBM@IBMDE</font>
<tr valign=3Dtop>
<td><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date:</font>
<td><font size=3D1 face=3D"sans-serif">21.04.2009 19:34</font>
<tr valign=3Dtop>
<td><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject:</font>
<td><font size=3D1 face=3D"sans-serif">Re: [PATCH 1/3] IB/ehca: Replace vma=
lloc
with kmalloc</font></table>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=3D2>&nbsp;&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; queue-&gt;queue=5Fpages =3D kmalloc(nr=5Fof=5Fpages
* sizeof(void *), GFP=5FKERNEL);<br>
<br>
How big might this buffer be? &nbsp;Any chance of allocation failure due
to<br>
memory fragmentation?<br>
<br>
 - R.<br>
</font></tt>
<br>
<br>
--=_alternative 00312AD7C12575A0_=--
