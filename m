Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id C3177B7FCC
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:06:25 +1100 (EST)
Received: by mail-pw0-f42.google.com with SMTP id 10so170185pwi.15
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:06:25 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 28/37] drivers/scsi: use .of_node instead of .archdata.of_node
	in struct device
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org,
	dwmw2@infradead.org, jeremy.kerr@canonical.com,
	James.Bottomley@suse.de, broonie@opensource.wolfsonmicro.com,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	linux-i2c@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-scsi@vger.kernel.org, alsa-devel@alsa-project.org
Date: Thu, 11 Mar 2010 11:06:22 -0700
Message-ID: <20100311180622.4824.54684.stgit@angua>
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
References: <20100311174830.4824.19820.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

.archdata.node is being removed from Microblaze, SPARC and PowerPC.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/scsi/ibmvscsi/ibmvfc.c   |    2 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 732f6d3..e230cd4 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1155,7 +1155,7 @@ static void ibmvfc_gather_partition_info(struct ibmvfc_host *vhost)
 static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 {
 	struct ibmvfc_npiv_login *login_info = &vhost->login_info;
-	struct device_node *of_node = vhost->dev->archdata.of_node;
+	struct device_node *of_node = vhost->dev->of_node;
 	const char *location;
 
 	memset(login_info, 0, sizeof(*login_info));
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index e3a18e0..c4b5af3 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -955,7 +955,7 @@ static void send_mad_capabilities(struct ibmvscsi_host_data *hostdata)
 	struct viosrp_capabilities *req;
 	struct srp_event_struct *evt_struct;
 	unsigned long flags;
-	struct device_node *of_node = hostdata->dev->archdata.of_node;
+	struct device_node *of_node = hostdata->dev->of_node;
 	const char *location;
 
 	evt_struct = get_event_struct(&hostdata->pool);
