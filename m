Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0618DDFDD
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 15:58:44 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m0B4waBd019527
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 21:58:37 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0B4wBGQ017274
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 22:58:12 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE:  [PATCH 0/3] UCC TDM driver for MPC83xx platforms 
Date: Fri, 11 Jan 2008 10:28:10 +0530
Message-ID: <FBA61160C48B8D438F3323FEFB4EF2C26E7662@zin33exm24.fsl.freescale.net>
In-Reply-To: <FBA61160C48B8D438F3323FEFB4EF2C26E765F@zin33exm24.fsl.freescale.net>
References: <FBA61160C48B8D438F3323FEFB4EF2C259F2F6@zin33exm24.fsl.freescale.net>
	<FBA61160C48B8D438F3323FEFB4EF2C26E765F@zin33exm24.fsl.freescale.net>
From: "Aggrwal Poonam" <Poonam.Aggrwal@freescale.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
Hello  All

I am waiting for more feedback on the patches.

If there are no objections please consider them for 2.6.25.

With Regards
Poonam=20
=20
=20

-----Original Message-----
From: netdev-owner@vger.kernel.org [mailto:netdev-owner@vger.kernel.org]
On Behalf Of Aggrwal Poonam
Sent: Monday, December 10, 2007 5:23 PM
To: rubini@vision.unipv.it; linux-ppcdev@ozlabs.kernel.org;
netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Gala Kumar
Cc: Barkowski Michael; Phillips Kim; Kalra Ashish; Cutler Richard
Subject: [PATCH 0/3] UCC TDM driver for MPC83xx platforms=20

There are three patches
[PATCH 1/3] drivers/misc : UCC TDM driver for mpc83xx platforms. This
driver is usable in VoIP iind of applications to interface with SLIC
kind of devices to exchange TDM voice samples.

[PATCH 2/3] arch/ : Platform changes
- device tree entries for UCC TDM driver for MPC8323ERDB platform.
- QE changes related to TDM , like,
	 1) Modified ucc_fast_init so that it can be used by fast UCC
based TDM driver. Mainly changes have been made to configure TDM clocks
and Fsyncs.

	2) Modified get_brg_clk so that it can return the input frequncy
and input source of any BRG by reading the corresponding entries from
device tree.

	3) Added new nodes brg and clocks in the device tree which
represent input clocks for different BRGs.

	4) Modified qe_setbrg accordingly.
- new device tree entries added for "clocks" and "brg"

[PATCH 3/3] Documentation
- Modified Documentation to explain the device tree entries related to
UCC TDM driver and the new nodes added("clocks" and "brg")

The patch applies over a merge of galak's for-2.6.25 plus for-2.6.24
plus of_doc_update branches.
In brief the steps were
git clone
git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
powerpc-galak git checkout -b for-2.6.25 origin/for-2.6.25 git checkout
-b for-2.6.24 origin/for-2.6.24 git checkout -b of_doc_update
origin/of_doc_update
git pull . for-2.6.24    # merge the other two
git pull . for-2.6.25=20
git checkout -b tdm      # clean slate for tdm rebase work

Also after applying the patches changes have to be made corresponding to
Tabi's patch "qe: add function qe_clock_source".

The driver has been tested with a VoIP stack and application on
MPC8323ERDB.

With Regards
Poonam=20
=20
=20
--
To unsubscribe from this list: send the line "unsubscribe netdev" in the
body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
