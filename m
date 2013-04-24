Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C13C2C0172
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 16:20:17 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 11:45:13 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0141E125804E
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 11:51:42 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O6JxiA9371934
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 11:49:59 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O6K4Qh020057
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 16:20:05 +1000
Subject: [PATCH v2 1/8] powerpc/pseries: Remove syslog prefix in
 uncompressed oops text
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 11:50:03 +0530
Message-ID: <20130424062003.7341.96872.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130424061807.7341.909.stgit@aruna-ThinkPad-T420>
References: <20130424061807.7341.909.stgit@aruna-ThinkPad-T420>
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

Removal of syslog prefix in the uncompressed oops text will
help in capturing more oops data.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Reviewed-by: Jim Keniston <jkenisto@us.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 8733a86..e54a8b7 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -619,7 +619,7 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
 	}
 	if (rc != 0) {
 		kmsg_dump_rewind(dumper);
-		kmsg_dump_get_buffer(dumper, true,
+		kmsg_dump_get_buffer(dumper, false,
 				     oops_data, oops_data_sz, &text_len);
 		err_type = ERR_TYPE_KERNEL_PANIC;
 		*oops_len = (u16) text_len;
