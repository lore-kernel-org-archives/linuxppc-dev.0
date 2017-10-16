Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yG54G0rDrzDrJ7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 04:32:29 +1100 (AEDT)
Subject: [PATCH 1/4] char/tpm: Delete an error message for a failed memory
 allocation in tpm_ascii_bios_measurements_show()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 Kenneth Goldman <kgold@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain
 <nayna@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
Message-ID: <caf93a65-469a-04f0-2e7b-5c03b43585e0@users.sourceforge.net>
Date: Mon, 16 Oct 2017 19:31:49 +0200
MIME-Version: 1.0
In-Reply-To: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Oct 2017 17:43:55 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/char/tpm/tpm1_eventlog.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm1_eventlog.c b/drivers/char/tpm/tpm1_eventlog.c
index 9a8605e500b5..9749469cb823 100644
--- a/drivers/char/tpm/tpm1_eventlog.c
+++ b/drivers/char/tpm/tpm1_eventlog.c
@@ -280,11 +280,8 @@ static int tpm_ascii_bios_measurements_show(struct seq_file *m, void *v)
 	    (unsigned char *)(v + sizeof(struct tcpa_event));
 
 	eventname = kmalloc(MAX_TEXT_EVENT, GFP_KERNEL);
-	if (!eventname) {
-		printk(KERN_ERR "%s: ERROR - No Memory for event name\n ",
-		       __func__);
+	if (!eventname)
 		return -EFAULT;
-	}
 
 	/* 1st: PCR */
 	seq_printf(m, "%2d ", do_endian_conversion(event->pcr_index));
-- 
2.14.2
