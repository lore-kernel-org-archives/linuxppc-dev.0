Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 271E5DDF1F
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 02:00:38 +1100 (EST)
Message-ID: <477CF841.2020200@windriver.com>
Date: Thu, 03 Jan 2008 09:59:13 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [DTC] small ftdump cleanup patch
References: <20080103144056.GB28644@windriver.com> <E1JARRd-0005ED-Qr@jdl.com>
In-Reply-To: <E1JARRd-0005ED-Qr@jdl.com>
Content-Type: multipart/mixed; boundary="------------060707060802070504030504"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060707060802070504030504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jon Loeliger wrote:
> So, like, the other day Paul Gortmaker mumbled:
>   
>> Here is a small patch to clean up the usage info and the error returns
>> for ftdump -- not sure what the future holds for ftdump vs. simply using
>> "dtc -I dtb -O dts someblob.dtb" ...
>>
>> Paul.
>>     
>
> Paul,
>
> Any chance of a signed-off-by line?
>   

Sure,  here is the whole thing.

Paul.



--------------060707060802070504030504
Content-Type: text/plain;
 name="0001-ftdump-minor-usage-and-error-return-cleanup.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-ftdump-minor-usage-and-error-return-cleanup.txt"

>From cef80fcd1efddaebcb366fb897430260cebb0c84 Mon Sep 17 00:00:00 2001
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 3 Jan 2008 09:56:09 -0500
Subject: [PATCH] ftdump: minor usage and error return cleanup

Improve the usage info and use standard error return values in ftdump.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 ftdump.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/ftdump.c b/ftdump.c
index 53343d7..49bc7cf 100644
--- a/ftdump.c
+++ b/ftdump.c
@@ -8,6 +8,8 @@
 #include <ctype.h>
 #include <netinet/in.h>
 #include <byteswap.h>
+#include <errno.h>
+#include <libgen.h>
 
 #include <fdt.h>
 
@@ -165,21 +167,22 @@ int main(int argc, char *argv[])
 	char buf[16384];	/* 16k max */
 	int size;
 
-	if (argc < 2) {
-		fprintf(stderr, "supply input filename\n");
-		return 5;
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s filename.dtb\n", basename(argv[0]));
+		fprintf(stderr, "\t-dump binary device tree blob contents.\n");
+		return EINVAL;
 	}
 
 	fp = fopen(argv[1], "rb");
 	if (fp == NULL) {
 		fprintf(stderr, "unable to open %s\n", argv[1]);
-		return 10;
+		return errno;
 	}
 
 	size = fread(buf, 1, sizeof(buf), fp);
 	if (size == sizeof(buf)) {	/* too large */
 		fprintf(stderr, "file too large\n");
-		return 10;
+		return EFBIG;
 	}
 
 	dump_blob(buf);
-- 
1.5.0.rc1.gf4b6c


--------------060707060802070504030504--
