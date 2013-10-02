Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E41A12C03C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 03:34:56 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 20/77] csiostor: Return -ENOSPC when not enough MSI-X
 vectors available
Date: Wed,  2 Oct 2013 12:48:36 +0200
Message-Id: <db7d3fc15ca0d902ea354d0aa293416563c440c3.1380703262.git.agordeev@redhat.com>
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
 drivers/scsi/csiostor/csio_isr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_isr.c b/drivers/scsi/csiostor/csio_isr.c
index 91ba91d..abf20ab 100644
--- a/drivers/scsi/csiostor/csio_isr.c
+++ b/drivers/scsi/csiostor/csio_isr.c
@@ -533,7 +533,7 @@ csio_enable_msix(struct csio_hw *hw)
 			csio_info(hw, "Not using MSI-X, remainder:%d\n", rv);
 
 		kfree(entries);
-		return -ENOMEM;
+		return -ENOSPC;
 	}
 
 	/* Save off vectors */
-- 
1.7.7.6
