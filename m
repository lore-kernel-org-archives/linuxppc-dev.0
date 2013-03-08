Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C22392C03AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 14:38:51 +1100 (EST)
Message-ID: <51395D2C.6040007@asianux.com>
Date: Fri, 08 Mar 2013 11:38:20 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] drivers/tty/hvc: fixup original commit:
 9276dfd27897a0b29d8b5814f39a1f82f56b6b6b
References: <512C2F5D.1080207@asianux.com> <512F343E.7010201@suse.cz>
 <512F3BC5.8020903@asianux.com> <512F3C60.9070409@asianux.com>
 <512F5FDC.3060000@suse.cz> <51355142.4070505@asianux.com>
 <5135BCAB.5040500@suse.cz> <51381352.9090803@asianux.com>
 <513818EC.9050504@asianux.com> <1362636305.3548.58.camel@pasglop>
In-Reply-To: <1362636305.3548.58.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 wfp5p@virginia.edu, tklauser@distanz.ch, Jiri Slaby <jslaby@suse.cz>,
 alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


  originally I did not notice src buf len and dest buf len are the same.
    so origianlly, it is not a bug issue, it is only for beautify code.
    and now, using strcpy is better.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/hvc/hvcs.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 81e939e..9330a4b 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -885,8 +885,7 @@ static void hvcs_set_pi(struct hvcs_partner_info
*pi, struct hvcs_struct *hvcsd)
 	hvcsd->p_partition_ID  = pi->partition_ID;

 	/* copy the null-term char too */
-	strlcpy(&hvcsd->p_location_code[0],
-			&pi->location_code[0], sizeof(hvcsd->p_location_code));
+	strcpy(&hvcsd->p_location_code[0], &pi->location_code[0]);
 }

 /*
-- 
1.7.7.6
