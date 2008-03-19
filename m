Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B86B6DDE23
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 15:32:11 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8897A.2DAF659E"
Subject: RE: [PATCH] [RFC] Xilinx: Add generic configuration option to enable
	all xilinx drivers.
Date: Tue, 18 Mar 2008 21:32:02 -0700
References: <20080212213120.D51157F806B@mail176-sin.bigfish.com>
	<fa686aa40803182115k241050f0meafccc29b4ef16@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080319043205.12E1F11E0071@mail67-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8897A.2DAF659E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hmm... interesting points.  I guess my feeling was that XILINX_DRIVERS =
could be a more broadly configurable option, with some of these ideas in =
mind.  Currently, it's hidden by default, but we could easily change =
this to be visible by default, or selected by a broader number of =
architectures.  I tend to think about them as a group: What if x86 *did* =
support the primitives needed by these drivers, then if the individual =
drivers depend on XILINX_DRIVERS, then the modification could be made in =
one spot.  By your suggestion, we would have to modify each one =
independantly.

I do dislike the hodgepodge of different configuration dependencies =
(such as Sysace)... It makes sense to me to have them be uniformly =
available.  If they are all going to be PPC32 || microblaze, then it =
seems to me like there should be an intermediate configuration option =
that expresses exactly that set.

Would you feel differently if we flipped the dependencies around, like =
XILINX_DRIVERS depends on PPC32 || MICROBLAZE?

Steve


-----Original Message-----
From: glikely@secretlab.ca on behalf of Grant Likely
Sent: Tue 3/18/2008 9:15 PM
To: Stephen Neuendorffer
Cc: linuxppc-dev@ozlabs.org; jacmet@sunsite.dk
Subject: Re: [PATCH] [RFC] Xilinx: Add generic configuration option to =
enable all xilinx drivers.
=20
On Tue, Feb 12, 2008 at 3:31 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> In the future, this will be used to provide similar configuration for
>  PowerPC and Microblaze.  It may also be convenient for those using
>  Xilinx cores as peripherals for external processors, rather than
>  explicitly having a dependance on the processor architecture.
>
>  Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>
>  ---
>
>  Grant,
>
>  This is the patch, updated for all of the drivers that I think are in
>  the tree.  I think the problematic parts may be the ppc part, which =
is
>  required for backward compatibility.  If this has to wait until ppc
>  dies, then that's fine with me, I guess.
>
>  It may also be better to clean up the Kconfig lines for Sysace and
>  framebuffer drivers by having PPC32 or PPC4xx select XILINX_DRIVERS.
>  My understanding is that those config options are there because of
>  people using external PPCs with those devices in the FPGA.

Hey Steve;

I haven't forgotten about this patch, but I've been thinking about it
some more and I'm coming to the conclusion that it might just be
better to eliminate driver dependence on XILINX_DRIVERS and
XILINX_VIRTEX entirely and instead just make each of them "depends on
PPC32 || MICROBLAZE".  There's no reason to restrict compiling these
drivers to platforms that are known to have xilinx parts on them.

I know that in most cases they will not be used, but by relaxing the
dependencies they will get compile tested on more platforms than they
are now and they'll get picked up for make allyesconfigs builds.  In
my mind this means greater chances of compile bugs getting found and
reported.

In fact, it would be nice to drop the PPC32 || MICROBLAZE dependency
too; but I think the drivers are using io primitives at the moment
that are not portable to x86.

Thoughts?

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.



------_=_NextPart_001_01C8897A.2DAF659E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: [PATCH] [RFC] Xilinx: Add generic configuration option to =
enable all xilinx drivers.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Hmm... interesting points.&nbsp; I guess my feeling =
was that XILINX_DRIVERS could be a more broadly configurable option, =
with some of these ideas in mind.&nbsp; Currently, it's hidden by =
default, but we could easily change this to be visible by default, or =
selected by a broader number of architectures.&nbsp; I tend to think =
about them as a group: What if x86 *did* support the primitives needed =
by these drivers, then if the individual drivers depend on =
XILINX_DRIVERS, then the modification could be made in one spot.&nbsp; =
By your suggestion, we would have to modify each one independantly.<BR>
<BR>
I do dislike the hodgepodge of different configuration dependencies =
(such as Sysace)... It makes sense to me to have them be uniformly =
available.&nbsp; If they are all going to be PPC32 || microblaze, then =
it seems to me like there should be an intermediate configuration option =
that expresses exactly that set.<BR>
<BR>
Would you feel differently if we flipped the dependencies around, like =
XILINX_DRIVERS depends on PPC32 || MICROBLAZE?<BR>
<BR>
Steve<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: glikely@secretlab.ca on behalf of Grant Likely<BR>
Sent: Tue 3/18/2008 9:15 PM<BR>
To: Stephen Neuendorffer<BR>
Cc: linuxppc-dev@ozlabs.org; jacmet@sunsite.dk<BR>
Subject: Re: [PATCH] [RFC] Xilinx: Add generic configuration option to =
enable all xilinx drivers.<BR>
<BR>
On Tue, Feb 12, 2008 at 3:31 PM, Stephen Neuendorffer<BR>
&lt;stephen.neuendorffer@xilinx.com&gt; wrote:<BR>
&gt; In the future, this will be used to provide similar configuration =
for<BR>
&gt;&nbsp; PowerPC and Microblaze.&nbsp; It may also be convenient for =
those using<BR>
&gt;&nbsp; Xilinx cores as peripherals for external processors, rather =
than<BR>
&gt;&nbsp; explicitly having a dependance on the processor =
architecture.<BR>
&gt;<BR>
&gt;&nbsp; Signed-off-by: Stephen Neuendorffer =
&lt;stephen.neuendorffer@xilinx.com&gt;<BR>
&gt;<BR>
&gt;&nbsp; ---<BR>
&gt;<BR>
&gt;&nbsp; Grant,<BR>
&gt;<BR>
&gt;&nbsp; This is the patch, updated for all of the drivers that I =
think are in<BR>
&gt;&nbsp; the tree.&nbsp; I think the problematic parts may be the ppc =
part, which is<BR>
&gt;&nbsp; required for backward compatibility.&nbsp; If this has to =
wait until ppc<BR>
&gt;&nbsp; dies, then that's fine with me, I guess.<BR>
&gt;<BR>
&gt;&nbsp; It may also be better to clean up the Kconfig lines for =
Sysace and<BR>
&gt;&nbsp; framebuffer drivers by having PPC32 or PPC4xx select =
XILINX_DRIVERS.<BR>
&gt;&nbsp; My understanding is that those config options are there =
because of<BR>
&gt;&nbsp; people using external PPCs with those devices in the =
FPGA.<BR>
<BR>
Hey Steve;<BR>
<BR>
I haven't forgotten about this patch, but I've been thinking about =
it<BR>
some more and I'm coming to the conclusion that it might just be<BR>
better to eliminate driver dependence on XILINX_DRIVERS and<BR>
XILINX_VIRTEX entirely and instead just make each of them &quot;depends =
on<BR>
PPC32 || MICROBLAZE&quot;.&nbsp; There's no reason to restrict compiling =
these<BR>
drivers to platforms that are known to have xilinx parts on them.<BR>
<BR>
I know that in most cases they will not be used, but by relaxing the<BR>
dependencies they will get compile tested on more platforms than =
they<BR>
are now and they'll get picked up for make allyesconfigs builds.&nbsp; =
In<BR>
my mind this means greater chances of compile bugs getting found and<BR>
reported.<BR>
<BR>
In fact, it would be nice to drop the PPC32 || MICROBLAZE dependency<BR>
too; but I think the drivers are using io primitives at the moment<BR>
that are not portable to x86.<BR>
<BR>
Thoughts?<BR>
<BR>
Cheers,<BR>
g.<BR>
<BR>
--<BR>
Grant Likely, B.Sc., P.Eng.<BR>
Secret Lab Technologies Ltd.<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8897A.2DAF659E--
