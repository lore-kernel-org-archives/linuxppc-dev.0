Return-Path: <jason.mcmullan@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 664B8679FE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 May 2005 23:20:07 +1000 (EST)
In-Reply-To: <20050514072826.GB20021@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-cg8+jxunGCTiXu7nvkFA"
References: <1116011879.9050.92.camel@jmcmullan.timesys>
	<20050514072826.GB20021@kroah.com>
Date: Mon, 16 May 2005 09:20:01 -0400
Message-ID: <1116249602.9050.105.camel@jmcmullan.timesys>
MIME-Version: 1.0
Date: Mon, 16 May 2005 09:14:02 -0400
Message-ID: <1116249602.9050.105.camel@jmcmullan.timesys>
From: "McMullan, Jason" <jason.mcmullan@timesys.com>
To: "Greg KH" <greg@kroah.com>,
	<akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, ecashin@coraid.com,
	PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2.6.11.7] ATA Over Ethernet Root, Mark 2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-cg8+jxunGCTiXu7nvkFA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[First off: Andrew, I'm sorry I didn't make it more clear that the AOE
 root patch was just for review, not for submission. Please remove it
 from -mm]


On Sat, 2005-05-14 at 00:28 -0700, Greg KH wrote:
> I'm guessing you are only testing this out on devfs?

  Yes. udev takes 5 minutes to complete on my 8mb, 100Mhz board.

> Why not fix this up properly, and allow root devices on _any_ type of
> block device that is not immediately present at "try to mount time"?  The
> USB and firewire users of the world will love you...

  Sure. No problem. Where is this patch you speak of?

> Also, please CC the aoe maintainer, that's documented in
> Documentation/SubmittingPatches :)

  I did to support@coraid.com, in a separate message.

> > +config ATA_OVER_ETH_ROOT_SHELF
> > +	int "Shelf ID"
> > +	depends on ATA_OVER_ETH_ROOT
>=20
> Ick.  Why not use a boot parameter if you really want to use something
> so icky (hint, we should rely on the name or major/minor, not something
> else like this.)

  Because kernel major/minor change dynamically based upon the number of
AOE blades on your LAN. As setting them in __setup() - sure, no problem,
this patch was just a 15 minute hack job.


> You do know devfs is going away in 2 months, right?

  Yes, much to my disappointment. udevd is so frick'n bloaty.

> Looks like you are mixing up shelf and slot values with major and minor
> numbers.  I'm confused.

  As was I. The original driver uses the words 'major' and 'minor' to
mean *both* kernel major/minor numbers and AOE blade slot/shelf IDs,
depending on context. Took me a bit to wrap my brain around it too.

> Should be in a separate patch, to fix up devfs issues in the driver,
> right?  This goes for the other devfs calls in this patch.  That is if
> you don't mind me removing them in 2 months :)

  Yeah, I know, I was just being lazy and using the uber-fast devfs.

> So, my main question is, why is this patch needed?  Is it because aoe
> devices aren't quite present and found quick enough during the boot
> process?

  Yep.

> If so, I suggest one of the two solutions:
> 	- do like the rest of the world does for usb and firewire and
> 	  other types of slow boot devices and use an initrd/initramfs
> 	  that mounts the root partition after it is properly found.
> 	  Distros do this all the time, so there are lots of examples to
> 	  pull from if you want to do this for yours.

   I only have 8Mb of RAM. No room for initrd.

> 	- fix up the patch that is floating around that allows the
> 	  kernel to pause and wait and not oops out if the root
> 	  partition is not found.  That way all users of all kinds of
> 	  slow devices can benefit, and driver specific hacks like this
> 	  are not needed.

   Again, this happy patch you speak of... Where can I find this wonder?

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-cg8+jxunGCTiXu7nvkFA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCiJ4B8/0vJ5szK6kRAg4OAJ9XJXTyrcC5Hje/Ph3XuNwAjOUP0gCcDqP6
J33zlnLk8kiLS54nWxoLnwY=
=6U2Z
-----END PGP SIGNATURE-----

--=-cg8+jxunGCTiXu7nvkFA--
