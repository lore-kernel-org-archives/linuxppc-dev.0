Return-Path: <saurav.kashyap@qlogic.com>
Received: from mx0a-0016ce01.pphosted.com (mx0a-0016ce01.pphosted.com
 [67.231.148.157])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 583A02C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 04:17:06 +1000 (EST)
From: Saurav Kashyap <saurav.kashyap@qlogic.com>
To: Alexander Gordeev <agordeev@redhat.com>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 59/77] qla2xxx: Update MSI/MSI-X interrupts
 enablement code
Date: Thu, 3 Oct 2013 17:42:33 +0000
Message-ID: <F5D084D6342F9B479C34599BB0A03E4D8982E209@AVMB1.qlogic.org>
In-Reply-To: <54f6b89372f51cd27a6adf6ecc91b8bf6bb5ba74.1380703263.git.agordeev@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "VMware,
 Inc." <pv-drivers@vmware.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Andy King <acking@vmware.com>, linux-scsi <linux-scsi@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 "iss_storagedev@hp.com" <iss_storagedev@hp.com>,
 Dept-Eng Linux Driver <Linux-Driver@qlogic.com>, Tejun Heo <tj@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev <netdev@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 "e1000-devel@lists.sourceforge.net" <e1000-devel@lists.sourceforge.net>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Saurav Kashyap <saurav.kashyap@qlogic.com>


>As result of recent re-design of the MSI/MSI-X interrupts enabling
>pattern this driver has to be updated to use the new technique to
>obtain a optimal number of MSI/MSI-X interrupts required.
>
>Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
>---
> drivers/scsi/qla2xxx/qla_isr.c |   18 +++++++++++-------
> 1 files changed, 11 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/scsi/qla2xxx/qla_isr.c
>b/drivers/scsi/qla2xxx/qla_isr.c
>index df1b30b..6c11ab9 100644
>--- a/drivers/scsi/qla2xxx/qla_isr.c
>+++ b/drivers/scsi/qla2xxx/qla_isr.c
>@@ -2836,16 +2836,20 @@ qla24xx_enable_msix(struct qla_hw_data *ha,
>struct rsp_que *rsp)
> 	for (i =3D 0; i < ha->msix_count; i++)
> 		entries[i].entry =3D i;
>=20
>-	ret =3D pci_enable_msix(ha->pdev, entries, ha->msix_count);
>-	if (ret) {
>+	ret =3D pci_msix_table_size(ha->pdev);
>+	if (ret < 0) {
>+		goto msix_failed;
>+	} else {
> 		if (ret < MIN_MSIX_COUNT)
> 			goto msix_failed;
>=20
>-		ql_log(ql_log_warn, vha, 0x00c6,
>-		    "MSI-X: Failed to enable support "
>-		    "-- %d/%d\n Retry with %d vectors.\n",
>-		    ha->msix_count, ret, ret);
>-		ha->msix_count =3D ret;
>+		if (ret < ha->msix_count) {
>+			ql_log(ql_log_warn, vha, 0x00c6,
>+			    "MSI-X: Failed to enable support "
>+			    "-- %d/%d\n Retry with %d vectors.\n",
>+			    ha->msix_count, ret, ret);
>+			ha->msix_count =3D ret;
>+		}
> 		ret =3D pci_enable_msix(ha->pdev, entries, ha->msix_count);
> 		if (ret) {
> msix_failed:
>--=20
>1.7.7.6
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
