Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 002151A0C4A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 20:48:49 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 13 Feb 2015 15:18:46 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id ECE2FE0056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:20:19 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1D9mhHa61538490
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:18:43 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1D9mhQP021170
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:18:43 +0530
Subject: [PATCH] powerpc/powernv: Check image loaded or not before calling
 flash
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 13 Feb 2015 15:18:42 +0530
Message-ID: <20150213094514.12351.11666.stgit@localhost.localdomain>
In-Reply-To: <20150212095323.1829.45732.stgit@localhost.localdomain>
References: <20150212095323.1829.45732.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: benh@au1.ibm.com, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Present code checks for update_flash_data in opal_flash_term_callback().
update_flash_data has been statically initialized to zero, and that
is the value of FLASH_IMG_READY. Also code update initialization happens
during subsys init.

So if reboot is issued before the subsys init stage then we endup displaying
"Flashing new firmware" message.. which may confuse end user.

This patch fixes above described issue by initializes update_flash status
to invalid state.

Reported-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
Ben, Sam,
  How about this patch?

  Initially I though of changing FLASH_IMG_READY value. But it has a impact
  on user space tool. (update_flash checks this value before calling reboot.
  See update_show function. Of course we can work around that .. But I thought
  this one is simpler approach.

-Vasant

 arch/powerpc/platforms/powernv/opal-flash.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
index 5c21d9c..0ff07ff 100644
--- a/arch/powerpc/platforms/powernv/opal-flash.c
+++ b/arch/powerpc/platforms/powernv/opal-flash.c
@@ -120,7 +120,11 @@ static struct image_header_t	image_header;
 static struct image_data_t	image_data;
 static struct validate_flash_t	validate_flash_data;
 static struct manage_flash_t	manage_flash_data;
-static struct update_flash_t	update_flash_data;
+
+/* Initialize update_flash_data status to No Operation */
+static struct update_flash_t	update_flash_data = {
+	.status = FLASH_NO_OP,
+};
 
 static DEFINE_MUTEX(image_data_mutex);
 
