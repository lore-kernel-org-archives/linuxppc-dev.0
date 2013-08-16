Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A78B2C02AD
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 23:19:07 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Fri, 16 Aug 2013 23:02:22 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A3B50357804E
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 23:19:04 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7GD34XQ43909290
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 23:03:04 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7GDJ3bv015829
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 23:19:04 +1000
Subject: [RFC PATCH v2 10/11] efi-pstore: Read and write to the 'compressed'
 flag of pstore
To: linuxppc-dev@ozlabs.org, tony.luck@intel.com, linux-kernel@vger.kernel.org,
 keescook@chromium.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Fri, 16 Aug 2013 18:48:57 +0530
Message-ID: <20130816131857.3338.26295.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, cbouatmailru@gmail.com,
 mahesh@linux.vnet.ibm.com, ccross@android.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In pstore write, Efi will add a character 'C'(compressed) or
D'(decompressed) in its header while writing to persistent store.
In pstore read, read the header and update the 'compressed' flag
accordingly.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 drivers/firmware/efi/efi-pstore.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 9a5425f..5002d50 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -35,6 +35,7 @@ struct pstore_read_data {
 	enum pstore_type_id *type;
 	int *count;
 	struct timespec *timespec;
+	bool *compressed;
 	char **buf;
 };
 
@@ -42,7 +43,7 @@ static int efi_pstore_read_func(struct efivar_entry *entry, void *data)
 {
 	efi_guid_t vendor = LINUX_EFI_CRASH_GUID;
 	struct pstore_read_data *cb_data = data;
-	char name[DUMP_NAME_LEN];
+	char name[DUMP_NAME_LEN], data_type;
 	int i;
 	int cnt;
 	unsigned int part;
@@ -54,12 +55,23 @@ static int efi_pstore_read_func(struct efivar_entry *entry, void *data)
 	for (i = 0; i < DUMP_NAME_LEN; i++)
 		name[i] = entry->var.VariableName[i];
 
-	if (sscanf(name, "dump-type%u-%u-%d-%lu",
+	if (sscanf(name, "dump-type%u-%u-%d-%lu-%c",
+		   cb_data->type, &part, &cnt, &time, &data_type) == 5) {
+		*cb_data->id = part;
+		*cb_data->count = cnt;
+		cb_data->timespec->tv_sec = time;
+		cb_data->timespec->tv_nsec = 0;
+		if (data_type == 'C')
+			*cb_data->compressed = true;
+		else
+			*cb_data->compressed = false;
+	} else if (sscanf(name, "dump-type%u-%u-%d-%lu",
 		   cb_data->type, &part, &cnt, &time) == 4) {
 		*cb_data->id = part;
 		*cb_data->count = cnt;
 		cb_data->timespec->tv_sec = time;
 		cb_data->timespec->tv_nsec = 0;
+		*cb_data->compressed = false;
 	} else if (sscanf(name, "dump-type%u-%u-%lu",
 			  cb_data->type, &part, &time) == 3) {
 		/*
@@ -71,6 +83,7 @@ static int efi_pstore_read_func(struct efivar_entry *entry, void *data)
 		*cb_data->count = 0;
 		cb_data->timespec->tv_sec = time;
 		cb_data->timespec->tv_nsec = 0;
+		*cb_data->compressed = false;
 	} else
 		return 0;
 
@@ -96,6 +109,7 @@ static ssize_t efi_pstore_read(u64 *id, enum pstore_type_id *type,
 	data.type = type;
 	data.count = count;
 	data.timespec = timespec;
+	data.compressed = compressed;
 	data.buf = buf;
 
 	return __efivar_entry_iter(efi_pstore_read_func, &efivar_sysfs_list, &data,
@@ -112,8 +126,8 @@ static int efi_pstore_write(enum pstore_type_id type,
 	efi_guid_t vendor = LINUX_EFI_CRASH_GUID;
 	int i, ret = 0;
 
-	sprintf(name, "dump-type%u-%u-%d-%lu", type, part, count,
-		get_seconds());
+	sprintf(name, "dump-type%u-%u-%d-%lu-%c", type, part, count,
+		get_seconds(), compressed ? 'C' : 'D');
 
 	for (i = 0; i < DUMP_NAME_LEN; i++)
 		efi_name[i] = name[i];
