Return-Path: <evil@g-house.de>
Received: from mail.g-house.de (ns1.g-housing.de [62.75.136.201])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FC902BDB5
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Dec 2004 15:16:06 +1100 (EST)
Message-ID: <41B3DCD7.3020503@g-house.de>
Date: Mon, 06 Dec 2004 05:15:19 +0100
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: sheutlin@gmx.de
References: <41B23DF2.4010303@g-house.de>	
	<1102207299.6778.16.camel@weizen.left.earth>
	<41B34863.3090007@g-house.de>
	<1102297574.7138.17.camel@weizen.left.earth>
In-Reply-To: <1102297574.7138.17.camel@weizen.left.earth>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Sven Hartge <hartge@ds9.argh.org>
Subject: Re: [FYI] linux 2.6 still not^Wnow working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sebastian Heutling schrieb:
> 
> Pure trial and error in the first time. When realising that something is
> wrong with the assigned interrupts (looking at the kernel output) we
> tried to set the ones that were working in a 2.4 kernel. When the
> machine finally booted a "lspci" showed that the slot number changed.

lspci, sounds easy ;-)
but i never would have looked at slot numbering....

> 
> Is it that onboard network tulip kind of thingy? Do you have some other
> PCI cards installed?

the card is onboard. since i had some issues with this card in early 2.4
kernels too, i used to have another NIC. in fact, very often i only
compiled with 3c59x enabled - OF cared about the onboard NIC (tulip) and
once the kernel is loaded, the tulip is not needed any more and 3c59x
takes over.

http://nerdbynature.de/bits/sheep/2.6.10-rc3/  has some details.

> I used to have an extra symbios logic scsi-host-adapter installed.
> On high network load and loading/writing to a HD (using onboard scsi), I
> noticed a lot of problems: either the scsi-host-adapter lost the
> interrupt or the network driver lost some packets or both. After having
> removed the extra scsi-host-adapter it works fine now.

hm, when i had 3 scsi-disks in this machine (fine IBM ones, hmmmm..) i
only used the on-board scsi-bus. there was no other scsi-host-adapter
inside, but i noticed the very same problems: upon massive i/o, the
machine got stuck for 30sec, sometimes longer, load increased to 30..40 or
so, then the machine got back, with a syslog full of scsi errors.



it's still so incredible that a 3-liner solved this issue. the bug-report
was opened over a year ago...

thanks again,
Christian.
- --
BOFH excuse #13:

we're waiting for [the phone company] to fix that line
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBs9zX+A7rjkF8z0wRArwBAKDZ2ywiukQl/b/uPTG1/1jWHrIsxQCeIcKb
ltnS8407uSUM+J6jiJABxxc=
=Ts4X
-----END PGP SIGNATURE-----
