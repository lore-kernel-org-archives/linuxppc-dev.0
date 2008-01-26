Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id C1785DDDFD
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 16:39:41 +1100 (EST)
Message-ID: <479AC79B.8090006@pikatech.com>
Date: Sat, 26 Jan 2008 00:39:39 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH]warp.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While merging, I found a small bug that I forgot to send. I add an 
offset to a value twice.

It is much easier to diff if it doesn't show the entire file as new.

Cheers,
   Sean MacLennan

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index 8f01563..da5b7b7 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -137,7 +137,7 @@ static int __init pika_dtm_start(void)
 	}
 	of_node_put(np);
 
-	fpga = ioremap(res.start + 0x20, 4);
+	fpga = ioremap(res.start, 0x24);
 	if (fpga == NULL)
 		return -ENOENT;
 
