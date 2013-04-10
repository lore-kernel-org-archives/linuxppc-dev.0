Return-Path: <shhuiw@gmail.com>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 02C232C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 10:46:41 +1000 (EST)
Received: by mail-pd0-f177.google.com with SMTP id u11so3955700pdi.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2013 17:46:39 -0700 (PDT)
Message-ID: <5164B664.6070306@gmail.com>
Date: Wed, 10 Apr 2013 08:46:28 +0800
From: Wang Sheng-Hui <shhuiw@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Suzuki K. Poulose" <suzuki@in.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] fadump: allow duplicate assignment to
 /sys/kernel/fadump_registered
 when it's assigned the desired value already
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the fadump is enabled, we have /sys/kernel/fadump_enabled assigned 1.
But sometimes we need to restart the fadump service by 'service kdump restart',
in case the kdump script has added the fadump detect/support already.
In current implementation, we cannot re-assign 1 to /sys/kernel/fadump_enabled
if 1 is already set and we have added more logic check in the user space script.

I think we can enable the duplicate assignment to ease the user space tools,
as long as the value is the right 1 or 0.

Signed-off-by: Wang Sheng-Hui <shhuiw@gmail.com>
---
  arch/powerpc/kernel/fadump.c |    8 ++------
  1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 06c8202..e1347e5 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1140,18 +1140,14 @@ static ssize_t fadump_register_store(struct kobject *kobj,

  	switch (buf[0]) {
  	case '0':
-		if (fw_dump.dump_registered == 0) {
-			ret = -EINVAL;
+		if (fw_dump.dump_registered == 0)
  			goto unlock_out;
-		}
  		/* Un-register Firmware-assisted dump */
  		fadump_unregister_dump(&fdm);
  		break;
  	case '1':
-		if (fw_dump.dump_registered == 1) {
-			ret = -EINVAL;
+		if (fw_dump.dump_registered == 1)
  			goto unlock_out;
-		}
  		/* Register Firmware-assisted dump */
  		register_fadump();
  		break;
-- 
1.7.10.4
