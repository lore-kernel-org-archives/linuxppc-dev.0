Return-Path: <memorylost@tin.it>
Received: from smtp-out30.alice.it (smtp-out30.alice.it [85.33.2.30])
	by ozlabs.org (Postfix) with ESMTP id CE1BDB7D28
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Mar 2010 01:04:20 +1100 (EST)
Message-ID: <4BA0DF86.8000209@tin.it>
Date: Wed, 17 Mar 2010 14:56:22 +0100
From: LD <memorylost@tin.it>
MIME-Version: 1.0
To: Linux ppc mailing list <linuxppc-dev@lists.ozlabs.org>
Subject: MPC5121e - using both USB modules
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,
I am working on a custom MPC5121e board, adapting 2.6.24 kernel.
The board has two USB ports:
- - cell-index 0 uses internal phy
- - cell-index 1 uses external phy

For mechanical/commercial reasons I cannot use Mini-A / Mini-B connectors, so I
have two "host" connectors, but the board should be capable of doing host or
device by dip-switch selection and using an external M/M connector adapter.

First I enabled cell-index 0 only in dts file, dr_mode = "otg", used OTG kernel
modules ; I succeeded in switching from host to device mode : port 0 is working.

Cell-index 1: disabled cell 0 and wrote some tweaks in drivers to enable correct
USB clocks (I saw some recent patches about this), then realized that the
hardware people have chosen a wrong ULPI phy (CY7C68003), which is capable of
doing only device, not host (arrrggghh !!) ; next boards will have a different
phy (capable of OTG).
I have some preliminary boards with this Cypress phy and tried enabling this
cell in otg mode to try and see if I can work in device mode, but strange things
- - ehci_hub_control complains. I suppose the phy is not ok to work this way.

Now I am trying to arrive to something like:
cell-0 : dr_mode = otg
cell-1 : dr_mode = peripheral

This way I could save the preliminary boards, with cell-1 working only as a usb
device. I am having problems with processor reset in inserting modules, still
not clear what is happening.

Anyway, final target will be (new boards):
cell-0 : dr_mode = otg
cell-1 : dr_mode = otg
Each port will have its dip-switch to select host or device mode.

So, here we are:
- - anyone having some suggestions or link to documentation please ?
- - is it possible to have two ports working as "peripheral" ? Not necessary for
me, but just to understand the "linux" constraints (if any).
I could, for example, use file_storage to one USB cell and ethernet-dev to the
other...
I also have to investigate how to tell file_storage which USB cell to use : map
both USB cells to the same pseudo-disk seems not good.


Thanks,
best regards

Lucio Dona'
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLoN+FvxHCsvXy9okRAtvfAJ4pEaBgPfmKLVRgczx3C1yYlQ8QdwCfYoyO
0KCTXBxZrALLHG/7BziuZpA=
=W1D6
-----END PGP SIGNATURE-----
