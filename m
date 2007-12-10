Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C36ABDDDED
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 23:00:55 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lBAC0nAd019026
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 05:00:49 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lBAC0kv3018747
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 06:00:48 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: FW:  [PATCH 0/3] UCC TDM driver for MPC83xx platforms 
Date: Mon, 10 Dec 2007 17:30:45 +0530
Message-ID: <FBA61160C48B8D438F3323FEFB4EF2C259F2FB@zin33exm24.fsl.freescale.net>
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
