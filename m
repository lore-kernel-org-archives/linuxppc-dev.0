Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9FA1EDE15E
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 01:47:07 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4TFl28F031815
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 11:47:02 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4TFksIh058458
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 09:46:59 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4TFksTb026904
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 09:46:54 -0600
Date: Thu, 29 May 2008 10:40:36 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20080529104036.43e1345d@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull from:

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

to pick up some of the initial changes for 2.6.27 in the 4xx tree.
They include some PIKA Warp updates, a DCR infrastructure rework, and
David's large dts conversion patch (which accounts for most of the
large diffstat).

I'll have some more updates a bit later, but I'd like to get these into
your next branch now as they've been sitting in mine for a while to get
testing coverage.

josh

David Gibson (1):
      [POWERPC] Convert remaining dts-v0 files to v1

Josh Boyer (2):
      [POWERPC] 4xx: Fix PCI mem in rainier DTS
      [POWERPC] 4xx: Fix compiler warning on DCR_NATIVE only builds

Sean MacLennan (2):
      [POWERPC] PIKA Warp: Update DTS to support Rev B boards
      [POWERPC] PIKA Warp: Update platform code to support Rev B boards

Stephen Neuendorffer (1):
      [POWERPC] Refactor DCR code

 arch/powerpc/boot/cuboot-warp.c        |   47 +++++-
 arch/powerpc/boot/dts/bamboo.dts       |  142 ++++++++--------
 arch/powerpc/boot/dts/canyonlands.dts  |  222 ++++++++++++------------
 arch/powerpc/boot/dts/ebony.dts        |  164 +++++++++---------
 arch/powerpc/boot/dts/ep405.dts        |  100 ++++++------
 arch/powerpc/boot/dts/glacier.dts      |  262 ++++++++++++++--------------
 arch/powerpc/boot/dts/haleakala.dts    |  136 ++++++++--------
 arch/powerpc/boot/dts/holly.dts        |  122 +++++++-------
 arch/powerpc/boot/dts/katmai.dts       |  210 ++++++++++++-----------
 arch/powerpc/boot/dts/kilauea.dts      |  182 ++++++++++----------
 arch/powerpc/boot/dts/makalu.dts       |  182 ++++++++++----------
 arch/powerpc/boot/dts/ps3.dts          |   16 +-
 arch/powerpc/boot/dts/rainier.dts      |  163 +++++++++---------
 arch/powerpc/boot/dts/sequoia.dts      |  172 ++++++++++---------
 arch/powerpc/boot/dts/taishan.dts      |  212 ++++++++++++------------
 arch/powerpc/boot/dts/walnut.dts       |  118 +++++++-------
 arch/powerpc/boot/dts/warp.dts         |  145 +++++++++-------
 arch/powerpc/boot/dts/yosemite.dts     |  146 ++++++++--------
 arch/powerpc/platforms/44x/warp-nand.c |   49 ++++--
 arch/powerpc/platforms/44x/warp.c      |  293 ++++++++++++++++++++++++++------
 arch/powerpc/sysdev/dcr.c              |  156 +++++++++++++----
 include/asm-powerpc/dcr-generic.h      |   49 ++++++
 include/asm-powerpc/dcr-mmio.h         |   20 ++-
 include/asm-powerpc/dcr-native.h       |   16 +-
 include/asm-powerpc/dcr.h              |   39 ++++-
 25 files changed, 1928 insertions(+), 1435 deletions(-)
