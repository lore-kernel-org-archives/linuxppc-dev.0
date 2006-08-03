Return-Path: <LeoLi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [RFC] New target 'cuImage' - compatibility uImage
Date: Thu, 3 Aug 2006 19:47:17 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0B2F61@zch01exm20.fsl.freescale.net>
In-Reply-To: <1154552346.5550.51.camel@localhost>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "McClintock Matthew-R56630" <msm@freescale.com>,
	"linuxppc-dev" <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If my understanding to Matt's idea is correct, it will be a good way,
IMHO.  How about use the naming of uwImage(U-boot Wrapped Image) or
utImage(u-boot device-Tree Image).

-Leo
> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On =
Behalf
Of
> Matthew McClintock
> Sent: Thursday, August 03, 2006 4:59 AM
> To: linuxppc-dev
> Subject: [RFC] New target 'cuImage' - compatibility uImage
>=20
> Hi all,
>=20
> The following is a patch which creates a new target called 'cuImage'.
It
> is designed to correctly package the kernel along with the
> 'arch/powerpc/boot' wrapper code into a uImage to be loaded and
started
> by U-Boot.
>=20
> The purpose of this target is to allow boards with older versions of
> U-Boot to utilize the 'bootm' command within U-Boot to run new powerpc
> kernels. The bootwrapper will begin execution and can correctly setup
a
> flat device tree based on values passed in the bd_t structure,
something
> old versions of U-Boot are not capable of.
>=20
> One might ask why not just use the 'bootelf' command in u-boot. Well,
> not all boards have that option compiled in, and some other boards
might
> not even have access to the console. Also, the bd_t structure is not
> passed from U-Boot when using the bootelf command so we would have no
> method to correctly fill in values in the device tree. This would
> theoretically allow an old board to start a new kernel without access
to
> the console if required.
>=20
> Currently the zImage looks like this:
>=20
> ---------------------------------
> - 	_start			-
> -	boot wrapper code	-
> - ----------------------------- -
> - -	device tree	      - -
> - ----------------------------- -
> - ----------------------------- -
> - - 			      - -
> - - 	compressed	      - -
> - - 	kernel image	      - -
> - -			      - -
> - ----------------------------- -
> ---------------------------------
>=20
> And the new cuImage will look like this:
>=20
> -------------------------------------
> -	compressed uImage	  - -
> - ------------------------------- - -
> - - 	_start			- - -
> - -	boot wrapper code	- - -
> - - ----------------------------- - -
> - - -	device tree	      	- - -
> - - ----------------------------- - -
> - - ----------------------------- - -
> - - - 			      	- - -
> - - - 	UNcompressed	      	- - -
> - - - 	kernel image	      	- - -
> - - -			      	- - -
> - - ----------------------------- - -
> - --------------------------------- -
> -------------------------------------
>=20
> -Matthew
>=20
