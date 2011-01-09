Return-Path: <htejun@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id B180EB7121
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Jan 2011 09:48:26 +1100 (EST)
Received: by vws20 with SMTP id 20so7484948vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 09 Jan 2011 14:48:23 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 9 Jan 2011 17:48:20 -0500
From: Tejun Heo <tj@kernel.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH #upstream-fixes] pata_mpc52xx: inherit from ata_bmdma_port_ops
Message-ID: <20110109224820.GB26607@mtj.dyndns.org>
References: <201101031445.47922.roman.fietze@telemotive.de>
	<20110103135929.GO18831@htj.dyndns.org>
	<4D21DD55.2000000@ru.mvista.com>
	<AANLkTi=5TrmxeWppabYaFUr-AhLwWcn4b_EQgLSJT44T@mail.gmail.com>
	<4D21EAF1.2010504@ru.mvista.com> <4D21FA4D.3030506@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D21FA4D.3030506@mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Sergei Shtylyov <sshtylyov@mvista.com>,
	Roman Fietze <roman.fietze@telemotive.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pata_mpc52xx supports BMDMA but inherits ata_sff_port_ops which
triggers BUG_ON() when a DMA command is issued.  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Roman Fietze <roman.fietze@telemotive.de>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: stable@kernel.org
---
 drivers/ata/pata_mpc52xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 8cc536e..d7d8026 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -610,7 +610,7 @@ static struct scsi_host_template mpc52xx_ata_sht = {
 };
 
 static struct ata_port_operations mpc52xx_ata_port_ops = {
-	.inherits		= &ata_sff_port_ops,
+	.inherits		= &ata_bmdma_port_ops,
 	.sff_dev_select		= mpc52xx_ata_dev_select,
 	.set_piomode		= mpc52xx_ata_set_piomode,
 	.set_dmamode		= mpc52xx_ata_set_dmamode,
