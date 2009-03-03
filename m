Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (cyborg3.cyclone.com [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id 93B99DDE31
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 03:34:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Gianfar tx-babbling-errors
Date: Tue, 3 Mar 2009 11:33:59 -0500
Message-ID: <43EB80E07C42E1408726E4905FB96B04C07957@CYBORG3.cyclone.com>
In-Reply-To: <18AEF66AFDF06F4CAAA1D419D000FD3302B1EB2E@az33exm24.fsl.freescale.net>
References: <43EB80E07C42E1408726E4905FB96B04C0769D@CYBORG3.cyclone.com>
	<18AEF66AFDF06F4CAAA1D419D000FD3302B1EAB1@az33exm24.fsl.freescale.net>
	<43EB80E07C42E1408726E4905FB96B04C0774E@CYBORG3.cyclone.com>
	<18AEF66AFDF06F4CAAA1D419D000FD3302B1EB2E@az33exm24.fsl.freescale.net>
From: "Scott Coulter" <scott.coulter@cyclone.com>
To: "Haruki Dai-R35557" <Dai.Haruki@freescale.com>, <linuxppc-dev@ozlabs.org>
Cc: Gala Kumar-B11780 <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi all,

In my continued search to stop tx-babbling-errors, I grabbed the latest
blobs for gianfar.c and gianfar.h from http://git.kernel.org.  The
history says that the following changes were made since the driver
version I was using (Freescale December 2008 LTIB release for 8572):

2009-02-09 Jarek Poplawski gianfar: Fix boot hangs while bringing up
gianfar ethernet
2009-02-05 Andy Fleming gianfar: Fix potential soft reset race=20
2009-01-26 Anton Vorontsov gianfar: Revive VLAN support blob=20
2009-01-13 Anton Vorontsov gianfar: Fix soft lockup with multi-interrupt
TSECs=20
2009-01-11 Clifford Wolf netdev: gianfar: add MII ioctl handler=20
2009-01-08 Kumar Gala gianfar: Fixup use of BUS_ID_SIZE
2009-01-06 Li Yang gianfar: ensure ECNTRL[R100] is cleared on link state
change
2008-12-18 Andy Fleming gianfar: Continue polling until both tx and rx
are empty

I backed out the following change due to compile errors:

2008-12-23 Neil Horman net: Remove unused netdev arg from some NAPI
interfaces

I also added the following change which wasn't in the kernel.org git:

2009-02-26 Rini van Zetten: fix to prevent num_txbdfree from going
negative

I also left my BUG_ON() check in gfar_clean_tx_ring() in to look for
truncated packets.  So far I've done 3 complete kernel builds over NFS
with no tx-babbling-errors reported by ethtool and no bug checks.

Scott




___________________________________________________________________

  Scott N. Coulter
  Senior Software Engineer
 =20
  Cyclone Microsystems         =20
  370 James Street              Phone:  203.786.5536 ext. 118
  New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
  U.S.A.                        Web:    http://www.cyclone.com
___________________________________________________________________
