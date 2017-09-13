Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsXSN0WcczDqlw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 16:53:40 +1000 (AEST)
Date: Wed, 13 Sep 2017 16:53:34 +1000
In-Reply-To: <20170913045124.GA5071@fergus.ozlabs.ibm.com>
References: <20170913045124.GA5071@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----9Y8GLQBIIT65PSDGMBMIISFIEIJMLP"
Subject: Re: [PATCH] powerpc: Fix handling of alignment interrupt on dcbz
 instruction
To: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 linuxppc-dev@ozlabs.org
CC: Michal Sojka <sojkam1@fel.cvut.cz>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
From: Michael Ellerman <michael@ellerman.id.au>
Message-ID: <56511543-E4A4-45B9-8BE3-A8FA2D8BCE0E@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------9Y8GLQBIIT65PSDGMBMIISFIEIJMLP
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michal, Christian, can you please confirm this fixes the problems you were =
seeing=2E

cheers

On 13 September 2017 2:51:24 pm AEST, Paul Mackerras <paulus@ozlabs=2Eorg>=
 wrote:
>This fixes the emulation of the dcbz instruction in the alignment
>interrupt handler=2E  The error was that we were comparing just the
>instruction type field of op=2Etype rather than the whole thing,
>and therefore the comparison "type !=3D CACHEOP + DCBZ" was always
>true=2E
>
>Fixes: 31bfdb036f12 ("powerpc: Use instruction emulation infrastructure
>to handle alignment faults")
>Signed-off-by: Paul Mackerras <paulus@ozlabs=2Eorg>
>---
> arch/powerpc/kernel/align=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/kernel/align=2Ec b/arch/powerpc/kernel/align=2E=
c
>index 26b9994d27ee=2E=2E43ef25156480 100644
>--- a/arch/powerpc/kernel/align=2Ec
>+++ b/arch/powerpc/kernel/align=2Ec
>@@ -341,7 +341,7 @@ int fix_alignment(struct pt_regs *regs)
>=20
> 	type =3D op=2Etype & INSTR_TYPE_MASK;
> 	if (!OP_IS_LOAD_STORE(type)) {
>-		if (type !=3D CACHEOP + DCBZ)
>+		if (op=2Etype !=3D CACHEOP + DCBZ)
> 			return -EINVAL;
> 		PPC_WARN_ALIGNMENT(dcbz, regs);
> 		r =3D emulate_dcbz(op=2Eea, regs);
>--=20
>2=2E11=2E0

--=20
Sent from my Android phone with K-9 Mail=2E Please excuse my brevity=2E
------9Y8GLQBIIT65PSDGMBMIISFIEIJMLP
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>Michal, Christian, can you please confirm this fix=
es the problems you were seeing=2E<br>
<br>
cheers<br><br><div class=3D"gmail_quote">On 13 September 2017 2:51:24 pm A=
EST, Paul Mackerras &lt;paulus@ozlabs=2Eorg&gt; wrote:<blockquote class=3D"=
gmail_quote" style=3D"margin: 0pt 0pt 0pt 0=2E8ex; border-left: 1px solid r=
gb(204, 204, 204); padding-left: 1ex;">
<pre class=3D"k9mail">This fixes the emulation of the dcbz instruction in =
the alignment<br />interrupt handler=2E  The error was that we were compari=
ng just the<br />instruction type field of op=2Etype rather than the whole =
thing,<br />and therefore the comparison &quot;type !=3D CACHEOP + DCBZ&quo=
t; was always<br />true=2E<br /><br />Fixes: 31bfdb036f12 (&quot;powerpc: U=
se instruction emulation infrastructure to handle alignment faults&quot;)<b=
r />Signed-off-by: Paul Mackerras &lt;paulus@ozlabs=2Eorg&gt;<br />---<br /=
> arch/powerpc/kernel/align=2Ec | 2 +-<br /> 1 file changed, 1 insertion(+)=
, 1 deletion(-)<br /><br />diff --git a/arch/powerpc/kernel/align=2Ec b/arc=
h/powerpc/kernel/align=2Ec<br />index 26b9994d27ee=2E=2E43ef25156480 100644=
<br />--- a/arch/powerpc/kernel/align=2Ec<br />+++ b/arch/powerpc/kernel/al=
ign=2Ec<br />@@ -341,7 +341,7 @@ int fix_alignment(struct pt_regs *regs)<br=
 /> <br />  type =3D op=2Etype &amp; INSTR_TYPE_MASK;<br />  if (!OP_IS_LOA=
D_STORE(type)) {<br />-  if (type !=3D CACHEOP + DCBZ)<br />+  if (op=2Etyp=
e !=3D CACHEOP + DCBZ)<br />    return -EINVAL;<br />   PPC_WARN_ALIGNMENT(=
dcbz, regs);<br />   r =3D emulate_dcbz(op=2Eea, regs);</pre></blockquote><=
/div><br>
-- <br>
Sent from my Android phone with K-9 Mail=2E Please excuse my brevity=2E</b=
ody></html>
------9Y8GLQBIIT65PSDGMBMIISFIEIJMLP--
