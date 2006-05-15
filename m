Return-Path: <jimix@watson.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E50EA679E6
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 01:48:02 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4FFlwvK024413
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 11:47:58 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4FFlvrI174300
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 09:47:57 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k4FFlvod000837
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 09:47:57 -0600
Received: from [10.0.1.3] (sig-9-65-60-6.mts.ibm.com [9.65.60.6])
	by d03av03.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	k4FFlrZW000353
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 09:47:54 -0600
Mime-Version: 1.0 (Apple Message framework v749.3)
Message-Id: <D46A754B-CDF8-4582-80BA-39B50ACD2D55@watson.ibm.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linuxppc-dev@ozlabs.org
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: [dtc][PATCH] Fix ftdump data walking
Date: Mon, 15 May 2006 11:47:43 -0400
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes a pointer addition bug in ftdump and handles endian  
issue.

Signed-off-by: Jimi Xenidis <jimix@watson.ibm.com>
---
diff --git a/ftdump.c b/ftdump.c
index 4d4354b..7e643c8 100644
--- a/ftdump.c
+++ b/ftdump.c
@@ -67,7 +67,8 @@ static void print_data(const void *data,
	} else if ((len % 4) == 0) {
		printf(" = <");
		for (i = 0; i < len; i += 4)
-			printf("%08x%s", *((uint32_t *)data + i),
+			printf("%08x%s",
+			       be32_to_cpu(*((uint32_t *)((ulong)data + i))),
			       i < (len - 4) ? " " : "");
		printf(">");
	} else {
