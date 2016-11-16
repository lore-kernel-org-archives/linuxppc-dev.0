Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0067.outbound.protection.outlook.com [104.47.40.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJn480HFTzDt1c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:40:39 +1100 (AEDT)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <oss@buserror.net>, <roy.pledge@nxp.com>
Subject: [PATCH 00/17] soc/qman: Fixes, endianness handling and related cleanup
Date: Wed, 16 Nov 2016 16:40:13 +0200
Message-ID: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* endianness fixes to ensure correct handling on little endian CPUs,
  as the qman h/w is big endian;
* removal of a platform device hack that may fail, used for dma mapping;
* various fixes and code cleanup;


Claudiu Manoil (15):
  soc/qman: Fix h/w resource cleanup error path handling
  soc/qbman: Fix resource leak on portal probing error path
  soc/qman: Fix struct qm_fqd set accessor for context_a
  soc/qman: Fix direct access to fd's addr_lo, use proper accesor
  soc/qman: test: Fix implementation of fd_cmp()
  soc/qman: Don't add a new platform device for dma mapping
  soc/qman: test: Don't use dummy platform device for dma mapping
  soc/qman: Remove redundant checks from qman_create_cgr()
  soc/qman: Remove unused struct qm_mcc* layouts
  soc/qman: Fix accesses to fqid, cleanup
  soc/qman: Drop unused field from eqcr/dqrr descriptors
  soc/qbman: Handle endianness of qm/bm_in/out()
  soc/qman: Change remaining contextB into context_b
  soc/qman: Clean up CGR CSCN target update operations
  soc/qman: Handle endianness of h/w descriptors

Madalin Bucur (2):
  soc/qman: Check ioremap return value
  soc/qman: Replace of_get_property() with portable equivalent

 drivers/soc/fsl/qbman/bman.c            |   6 +-
 drivers/soc/fsl/qbman/bman_portal.c     |  17 ++-
 drivers/soc/fsl/qbman/dpaa_sys.h        |   1 +
 drivers/soc/fsl/qbman/qman.c            | 231 +++++++++++++++-----------------
 drivers/soc/fsl/qbman/qman_ccsr.c       |   3 +
 drivers/soc/fsl/qbman/qman_portal.c     |  41 ++++--
 drivers/soc/fsl/qbman/qman_priv.h       |  17 +--
 drivers/soc/fsl/qbman/qman_test_api.c   |  27 ++--
 drivers/soc/fsl/qbman/qman_test_stash.c |  36 +++--
 include/soc/fsl/qman.h                  |  62 +++++----
 10 files changed, 231 insertions(+), 210 deletions(-)

-- 
1.7.11.7
