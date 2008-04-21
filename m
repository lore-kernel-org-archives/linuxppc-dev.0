Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 57E50DE0F9
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 13:56:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8A363.A898326A"
Subject: RE: [PATCH 1/2] [v3][POWERPC] refactor dcr code
Date: Sun, 20 Apr 2008 20:56:20 -0700
References: <1206914576.10388.132.camel@pasglop><20080418215513.ACA0C17F007A@mail131-dub.bigfish.com>
	<20080419093500.752c1930@zod.rchland.ibm.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Message-Id: <20080421035624.E528B48806A@mail212-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8A363.A898326A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



> > +void dcr_unmap_generic(dcr_host_t host, unsigned int dcr_c)
> > +{
> > +	if (host.type =3D=3D NATIVE)
> > +		dcr_unmap_native(host.host.native, dcr_c);
> > +	else
> > +		dcr_unmap_mmio(host.host.mmio, dcr_c);
>
> What happens if host.type =3D=3D INVALID?  Same question for the other
> accessors in dcr_*_generic.

I guess looking back on it, I assumed that MAP_OK would return 0, =
meaning that behavior was undefined,
but I agree it's probably safer to have some error reporting there...  =
There starts to become a speed tradeoff
at some point, which would make function pointers more attractive.  If =
the ioremap does fail, or the
dcr-access-method can't be determined, then dcr_unmap_mmio would =
probably SEGV anyway, although that's
not something I'd really want to rely on.  I'll put an error case in =
there.

> > +enum host_type_t {MMIO, NATIVE, INVALID};
>
> Should these be DCR_HOST_MMIO, DCR_HOST_NATIVE, DCR_HOST_INVALID?
>
> I worry about the generic nature of the names.

Also seems reasonable,=20

Steve

------_=_NextPart_001_01C8A363.A898326A
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: [PATCH 1/2] [v3][POWERPC] refactor dcr code</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>
<BR>

<P><FONT SIZE=3D2>&gt; &gt; +void dcr_unmap_generic(dcr_host_t host, =
unsigned int dcr_c)<BR>
&gt; &gt; +{<BR>
&gt; &gt; +&nbsp;&nbsp; if (host.type =3D=3D NATIVE)<BR>
&gt; &gt; +&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dcr_unmap_native(host.host.native, dcr_c);<BR>
&gt; &gt; +&nbsp;&nbsp; else<BR>
&gt; &gt; +&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dcr_unmap_mmio(host.host.mmio, dcr_c);<BR>
&gt;<BR>
&gt; What happens if host.type =3D=3D INVALID?&nbsp; Same question for =
the other<BR>
&gt; accessors in dcr_*_generic.<BR>
<BR>
I guess looking back on it, I assumed that MAP_OK would return 0, =
meaning that behavior was undefined,<BR>
but I agree it's probably safer to have some error reporting =
there...&nbsp; There starts to become a speed tradeoff<BR>
at some point, which would make function pointers more attractive.&nbsp; =
If the ioremap does fail, or the<BR>
dcr-access-method can't be determined, then dcr_unmap_mmio would =
probably SEGV anyway, although that's<BR>
not something I'd really want to rely on.&nbsp; I'll put an error case =
in there.<BR>
<BR>
&gt; &gt; +enum host_type_t {MMIO, NATIVE, INVALID};<BR>
&gt;<BR>
&gt; Should these be DCR_HOST_MMIO, DCR_HOST_NATIVE, =
DCR_HOST_INVALID?<BR>
&gt;<BR>
&gt; I worry about the generic nature of the names.<BR>
<BR>
Also seems reasonable,<BR>
<BR>
Steve<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8A363.A898326A--
