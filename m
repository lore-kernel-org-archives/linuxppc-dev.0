Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id B5A34DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 11:17:20 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] qe: add ability to upload QE firmware
Date: Thu, 6 Dec 2007 01:17:14 +0100
References: <11968944871776-git-send-email-timur@freescale.com>
	<200712060056.39368.arnd@arndb.de> <47573CCE.4000606@freescale.com>
In-Reply-To: <47573CCE.4000606@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712060117.14768.arnd@arndb.de>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 06 December 2007, Timur Tabi wrote:
> > In that case, I think it
> > would really be better to just put the blob into the tree and only
> > have the fw loading code in the kernel instead of duplicating it in the=
 boot
> > loader.
>=20
> That would require the firmware to present in RAM for all time, since the=
 device=20
> tree cannot be unloaded.

Yes, that's a backdraw of my approach, but in the case of spidernet, it was=
 only
an insignificant amount of RAM. Don't know what sizes of RAM and QE firmware
to expect typically on the machines you care about.

> Besides, you might need to have the firmware loaded in =20
> U-Boot anyway. =A0If your console is connected to the QE, then you'll nee=
d the=20
> UART firmware loaded before you can see anything. =A0That's why U-Boot ne=
eds its=20
> own version.

Right, so you can't really get around having it in some boot loaders at lea=
st.
IIRC you said that the firmware is only needed for serial output on some ch=
ips
but not on others. What about the case where you don't need it for serial b=
ut
still want to provide it by the firmware, and perhaps use something other t=
han
U-boot? Is that relevant?

I'm not trying to convince you of this if it's completely pointless for
all your systems, just want to make sure you're aware of this option,
because spending a few extra code lines on it now may save you some trouble
if you need this later.

> > Regarding the question whether the firmware should be a device node or
> > a property of another node, I'd prefer a simple property, because the
> > firmware itself is not really a device you can access, but I don't care
> > much about that.
>=20
> Technically, the firmware could be considered a device on the QE, because=
 it's=20
> loaded into I-RAM and it can significantly alter the behavior of the devi=
ce.=20

Well, it doesn't have any of the standard properties like registers or inte=
rrupts
though.

> Having it its own node also lets me compartmentalize it. =A0If I want to =
expand=20
> the node and add more properties, it's cleaner.

Yes, that makes a lot of sense.

	Arnd <><
