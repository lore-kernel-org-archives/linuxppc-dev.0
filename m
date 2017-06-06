Return-Path: <chrisp@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wj7pz1GlPzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 09:55:22 +1000 (AEST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: bp@alien8.de,
	linux-edac@vger.kernel.org
Cc: mchehab@kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: EDAC: simplify total memory calculation
Date: Wed,  7 Jun 2017 11:54:57 +1200
Message-Id: <20170606235500.22772-1-chris.packham@alliedtelesis.co.nz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This take the approach used by cell_edac.c to obtain the total memory from
the devicetree and applies it to mv64x60_edac.c, altera_edac.c and
cpc925_edac.c which were all manually parsing the reg property. In the case
of mv64x60 this actually fixes cases where #address/size-cells != 1. For
altera and cpc925 this is just a cleanup.

Chris Packham (3):
  EDAC: mv64x60: calculate memory size correctly
  EDAC: altera: simplify calculation of total memory
  EDAC: cpc925: simplify calculation of total memory

 drivers/edac/altera_edac.c  | 24 ++++++++----------------
 drivers/edac/cpc925_edac.c  | 32 ++++++++++----------------------
 drivers/edac/mv64x60_edac.c | 17 +++++++++++------
 3 files changed, 29 insertions(+), 44 deletions(-)

-- 
2.13.0
