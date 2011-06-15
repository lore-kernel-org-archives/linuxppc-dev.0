Return-Path: <john.williams@petalogix.com>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7465B6F95
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 19:38:50 +1000 (EST)
Received: by pvh10 with SMTP id 10so163215pvh.15
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 02:38:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD9E@saturn3.aculab.com>
References: <4DF84D92.2030803@in.ibm.com>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AD9E@saturn3.aculab.com>
From: John Williams <john.williams@petalogix.com>
Date: Wed, 15 Jun 2011 11:38:27 +0200
Message-ID: <BANLkTimzWn+cp5q=thHmcWz9jz+bp6tLC7CU2GBnDvEWM8jUbQ@mail.gmail.com>
Subject: Re: Relocatable kernel for ppc44x
To: David Laight <David.Laight@aculab.com>
Content-Type: multipart/alternative; boundary=000e0cd23d865221b004a5bcebd4
Cc: linuxppc-dev@ozlabs.org, monstr@monstr.eu,
	Suzuki Poulose <suzuki@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd23d865221b004a5bcebd4
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jun 15, 2011 at 11:30 AM, David Laight <David.Laight@aculab.com>wrote:

>
> > The PPC440X currently uses 256M TLB entries to pin the
> > lowmem. When we go for a relocatable kernel we have to :
> >
> > 1) Restrict the kernel load address to be 256M aligned
> >
> > OR
> >
> > 2) Use 16M TLB(the next possible TLB page size supported)
> > entries till the first
> > 256M and then use the 256M TLB entries for the rest of lowmem.
>
> What is wrong with:
>
> 3) Use 256M TLB entries with the lowest one including
>   addresses below the kernel base.
>
> Clearly the kernel shouldn't be accessing the addresses
> below its base address - but that is true of a lot of
> address space mapped into the kernel.
>

It gets mucky since we will then need need to assess how much of that 256M
mapping will be above the kernel base, determine if that is sufficient to
boot the kernel, if not then setup additional 16MB mappings and so on.  It
might be cleaner to just use multiple 16MB mappings directly?

By the way we have some patches to support a non-zero (but fixed) boot
address for PPC440.  They are against 2.6.31, it's pretty simple stuff
except also requires changes in the simpleboot wrapper.  We will post them
shortly since they are relevant to this discussion.

John
-- 
John Williams, PhD, B. Eng, B. IT
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com  p: +61-7-30090663  f: +61-7-30090663

--000e0cd23d865221b004a5bcebd4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Jun 15, 2011 at 11:30 AM, David =
Laight <span dir=3D"ltr">&lt;<a href=3D"mailto:David.Laight@aculab.com">Dav=
id.Laight@aculab.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
;">

<div class=3D"im"><br>
&gt; The PPC440X currently uses 256M TLB entries to pin the<br>
&gt; lowmem. When we go for a relocatable kernel we have to :<br>
&gt;<br>
&gt; 1) Restrict the kernel load address to be 256M aligned<br>
&gt;<br>
&gt; OR<br>
&gt;<br>
&gt; 2) Use 16M TLB(the next possible TLB page size supported)<br>
&gt; entries till the first<br>
&gt; 256M and then use the 256M TLB entries for the rest of lowmem.<br>
<br>
</div>What is wrong with:<br>
<br>
3) Use 256M TLB entries with the lowest one including<br>
 =A0 addresses below the kernel base.<br>
<br>
Clearly the kernel shouldn&#39;t be accessing the addresses<br>
below its base address - but that is true of a lot of<br>
address space mapped into the kernel.<br></blockquote><div><br></div><div>I=
t gets mucky since we will then need need to assess how much of that 256M m=
apping will be above the kernel base, determine if that is sufficient to bo=
ot the kernel, if not then setup additional 16MB mappings and so on. =A0It =
might be cleaner to just use multiple 16MB mappings directly?</div>

<div><br></div><div>By the way we have some patches to support a non-zero (=
but fixed) boot address for PPC440. =A0They are against 2.6.31, it&#39;s pr=
etty simple stuff except also requires changes in the simpleboot wrapper. =
=A0We will post them shortly since they are relevant to this discussion.</d=
iv>

<div><br></div><div>John</div><div>--=A0</div></div>John Williams, PhD, B. =
Eng, B. IT<br>PetaLogix - Linux Solutions for a Reconfigurable World<br>w: =
<a href=3D"http://www.petalogix.com" target=3D"_blank">www.petalogix.com</a=
>=A0=A0p: +61-7-30090663=A0 f: +61-7-30090663<br>



--000e0cd23d865221b004a5bcebd4--
