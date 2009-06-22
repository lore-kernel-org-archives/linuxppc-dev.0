Return-Path: <roel.kluin@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4D660B7154
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 00:39:36 +1000 (EST)
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com
	[209.85.219.215]) by ozlabs.org (Postfix) with ESMTP id 5C08FDDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 00:39:34 +1000 (EST)
Received: by ewy11 with SMTP id 11so4813501ewy.9
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 07:39:32 -0700 (PDT)
Message-ID: <4A3FB3E2.7090309@gmail.com>
Date: Mon, 22 Jun 2009 18:40:02 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: [PATCH] Sky CPU: redundant or incorrect tests on unsigned
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

count is unsigned and cannot be less than 0.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Can these be removed or do we need an `if (count > MAX)' test, and
what should MAX be then?

diff --git a/drivers/misc/hdpuftrs/hdpu_cpustate.c b/drivers/misc/hdpuftrs/hdpu_cpustate.c
index 176fe4e..35000cf 100644
--- a/drivers/misc/hdpuftrs/hdpu_cpustate.c
+++ b/drivers/misc/hdpuftrs/hdpu_cpustate.c
@@ -121,8 +121,6 @@ static ssize_t cpustate_read(struct file *file, char *buf,
 {
 	unsigned char data;
 
-	if (count < 0)
-		return -EFAULT;
 	if (count == 0)
 		return 0;
 
@@ -137,9 +135,6 @@ static ssize_t cpustate_write(struct file *file, const char *buf,
 {
 	unsigned char data;
 
-	if (count < 0)
-		return -EFAULT;
-
 	if (count == 0)
 		return 0;
 
