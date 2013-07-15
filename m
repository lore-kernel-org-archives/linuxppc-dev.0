Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 12F722C030F
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:56:54 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Mon, 15 Jul 2013 22:19:14 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 00E2B1258052
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 22:26:09 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6FGukHb14090458
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 22:26:46 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6FGunjY019863
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:56:49 +1000
Subject: [PATCH 09/11] erst: Read and write to the 'compressed' flag of pstore
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Mon, 15 Jul 2013 22:26:45 +0530
Message-ID: <20130715165645.1520.72286.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
References: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, tony.luck@intel.com, mahesh@linux.vnet.ibm.com,
 cbouatmailru@gmail.com, anton@samba.org, ccross@android.com,
 keescook@chromium.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In pstore write, set the section type to CPER_SECTION_TYPE_DMESG_COMPR
if the data is compressed. In pstore read, read the section type and
update the 'compressed' flag accordingly.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 drivers/acpi/apei/erst.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index b0dca8e..62df189 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -956,6 +956,9 @@ static struct pstore_info erst_info = {
 #define CPER_SECTION_TYPE_DMESG						\
 	UUID_LE(0xc197e04e, 0xd545, 0x4a70, 0x9c, 0x17, 0xa5, 0x54,	\
 		0x94, 0x19, 0xeb, 0x12)
+#define CPER_SECTION_TYPE_DMESG_Z					\
+	UUID_LE(0x4f118707, 0x04dd, 0x4055, 0xb5, 0xdd, 0x95, 0x6d,	\
+		0x34, 0xdd, 0xfa, 0xc6)
 #define CPER_SECTION_TYPE_MCE						\
 	UUID_LE(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
 		0x04, 0x4a, 0x38, 0xfc)
@@ -1034,7 +1037,12 @@ skip:
 	}
 	memcpy(*buf, rcd->data, len - sizeof(*rcd));
 	*id = record_id;
+	*compressed = false;
 	if (uuid_le_cmp(rcd->sec_hdr.section_type,
+			CPER_SECTION_TYPE_DMESG_Z) == 0) {
+		*type = PSTORE_TYPE_DMESG;
+		*compressed = true;
+	} else if (uuid_le_cmp(rcd->sec_hdr.section_type,
 			CPER_SECTION_TYPE_DMESG) == 0)
 		*type = PSTORE_TYPE_DMESG;
 	else if (uuid_le_cmp(rcd->sec_hdr.section_type,
@@ -1085,7 +1093,10 @@ static int erst_writer(enum pstore_type_id type, enum kmsg_dump_reason reason,
 	rcd->sec_hdr.flags = CPER_SEC_PRIMARY;
 	switch (type) {
 	case PSTORE_TYPE_DMESG:
-		rcd->sec_hdr.section_type = CPER_SECTION_TYPE_DMESG;
+		if (compressed)
+			rcd->sec_hdr.section_type = CPER_SECTION_TYPE_DMESG_Z;
+		else
+			rcd->sec_hdr.section_type = CPER_SECTION_TYPE_DMESG;
 		break;
 	case PSTORE_TYPE_MCE:
 		rcd->sec_hdr.section_type = CPER_SECTION_TYPE_MCE;
