Return-Path: <mike@it-loops.com>
Received: from lvps87-230-0-242.dedicated.hosteurope.de
	(lvps87-230-0-242.dedicated.hosteurope.de [87.230.0.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "plesk", Issuer "plesk" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C2CCBDDF6F
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 18:35:09 +1100 (EST)
MIME-Version: 1.0
Date: Tue, 03 Mar 2009 08:35:02 +0100
From: Michael Guntsche <mike@it-loops.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: PHY not found after migration of gianfar driver to an
	=?UTF-8?Q?of=5Fplatform=5Fdriver?=
In-Reply-To: <fa686aa40903020708y1f9f8ceeueb13f9146534df8d@mail.gmail.com>
References: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
	<fa686aa40902280703p5ad8ee73y116d7e2252df21a5@mail.gmail.com>
	<3B1D47A2-329E-491E-B3AC-E76C1CE1762D@it-loops.com>
	<fa686aa40903011353t464b1df3obd553132e5bc2570@mail.gmail.com>
	<CD026D29-687D-4078-960E-108CC94C30E4@it-loops.com>
	<fa686aa40903011715u2aed4c23tb8182634fa1220f6@mail.gmail.com>
	<c19541729a7d99548faadbabe5c7646c@localhost>
	<fa686aa40903020708y1f9f8ceeueb13f9146534df8d@mail.gmail.com>
Message-ID: <9d38520266f15d80352d1554e63c1ce6@localhost>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2 Mar 2009 08:08:02 -0700, Grant Likely <grant.likely@secretlab.ca>
wrote:
> On Mon, Mar 2, 2009 at 4:58 AM, Michael Guntsche <mike@it-loops.com>
wrote:
> You mean like loading it of the CF or something?  Yeah, I suppose so
> if you wrote a minimal CF driver, but that seems the hard way around
> also.  You're far better off to statically link in a .dtb image and
> modify it.  If the bootloader doesn't provide you with any useful
> information, you can read the SoC registers to detect memory size and
> clock rate.  If you're lucky, the bootloader will have already
> assigned the correct MAC addresses for you and you can read those out
> also.



> 
> You can also try inspecting the memory pointed to by r3-r7 and seeing
> if any of them point to something interesting.

Regarding the registers I did a 

printf("Reg: %lu\n", r3); 

after the init of the serial console. While r4 to r7 where empty, I got
back a number 8756... from R3. 
I do not know what's in there though. Is there another better way to get to
the data?


> Oh.  So routerboot does understand dtb blobs?  Okay, I didn't
> understand that.  Yes, you can call the libfdt functions in your
> platform_init() to add the missing nodes.
I don't know if routerboot understands dtb blobs. If I boot with a standard
vmlinux image the board boots
as well so I think that the firmware provides a tree the prom code can
read. 
As for adding additional information to the tree, can I also use libfdt
functions in platform/83xx/rbppc.c or is it better to do this via a
dedicated platform_init that simpleboot then uses?


Once again thank you very much for helping me with this,
Michael
