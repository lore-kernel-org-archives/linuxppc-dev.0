Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C33D32C0077
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 02:55:30 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 50/77] mlx5: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:49:06 +0200
Message-Id: <9650a7dfbcfd5f1da21f7b093665abf4b1041071.1380703263.git.agordeev@redhat.com>
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
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

As result of recent re-design of the MSI/MSI-X interrupts enabling
pattern this driver has to be updated to use the new technique to
obtain a optimal number of MSI/MSI-X interrupts required.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index adf0e5d..5c21e50 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -119,8 +119,13 @@ static int mlx5_enable_msix(struct mlx5_core_dev *dev)
 	int err;
 	int i;
 
+	err = pci_msix_table_size(dev->pdev);
+	if (err < 0)
+		return err;
+
 	nvec = dev->caps.num_ports * num_online_cpus() + MLX5_EQ_VEC_COMP_BASE;
 	nvec = min_t(int, nvec, num_eqs);
+	nvec = min_t(int, nvec, err);
 	if (nvec <= MLX5_EQ_VEC_COMP_BASE)
 		return -ENOSPC;
 
@@ -131,20 +136,15 @@ static int mlx5_enable_msix(struct mlx5_core_dev *dev)
 	for (i = 0; i < nvec; i++)
 		table->msix_arr[i].entry = i;
 
-retry:
-	table->num_comp_vectors = nvec - MLX5_EQ_VEC_COMP_BASE;
 	err = pci_enable_msix(dev->pdev, table->msix_arr, nvec);
-	if (err <= 0) {
+	if (err) {
+		kfree(table->msix_arr);
 		return err;
-	} else if (err > MLX5_EQ_VEC_COMP_BASE) {
-		nvec = err;
-		goto retry;
 	}
 
-	mlx5_core_dbg(dev, "received %d MSI vectors out of %d requested\n", err, nvec);
-	kfree(table->msix_arr);
+	table->num_comp_vectors = nvec - MLX5_EQ_VEC_COMP_BASE;
 
-	return -ENOSPC;
+	return 0;
 }
 
 static void mlx5_disable_msix(struct mlx5_core_dev *dev)
-- 
1.7.7.6
