Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 91A032C098B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 03:40:27 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 54/77] ntb: Ensure number of MSIs on SNB is enough for the
 link interrupt
Date: Wed,  2 Oct 2013 12:49:10 +0200
Message-Id: <5d9c5b2d3bbc444ff32bddeece7a239d046bd79c.1380703263.git.agordeev@redhat.com>
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 stable@vger.kernel.org, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org,
 Alexander Gordeev <agordeev@redhat.com>, linux-pci@vger.kernel.org,
 iss_storagedev@hp.com, linux-driver@qlogic.com, Tejun Heo <tj@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 e1000-devel@lists.sourceforge.net, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/ntb/ntb_hw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ntb/ntb_hw.c b/drivers/ntb/ntb_hw.c
index de2062c..eccd5e5 100644
--- a/drivers/ntb/ntb_hw.c
+++ b/drivers/ntb/ntb_hw.c
@@ -1066,7 +1066,7 @@ static int ntb_setup_msix(struct ntb_device *ndev)
 		/* On SNB, the link interrupt is always tied to 4th vector.  If
 		 * we can't get all 4, then we can't use MSI-X.
 		 */
-		if (ndev->hw_type != BWD_HW) {
+		if ((rc < SNB_MSIX_CNT) && (ndev->hw_type != BWD_HW)) {
 			rc = -EIO;
 			goto err1;
 		}
-- 
1.7.7.6
