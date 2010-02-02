Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 027EAB7D2C
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2010 09:40:08 +1100 (EST)
Message-Id: <201002022240.o12Me1iY018842@imap1.linux-foundation.org>
Subject: [patch 1/2] powerpc: Sky CPU: redundant or incorrect tests on unsigned
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Tue, 02 Feb 2010 14:40:01 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Cc: waite@skycomputers.com, roel.kluin@gmail.com, gorcunov@gmail.com,
	linuxppc-dev@ozlabs.org, galak@gate.crashing.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Roel Kluin <roel.kluin@gmail.com>

count is unsigned and cannot be less than 0.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Acked-by: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kumar Gala <galak@gate.crashing.org>
Cc: Brian Waite <waite@skycomputers.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/misc/hdpuftrs/hdpu_cpustate.c |    5 -----
 1 file changed, 5 deletions(-)

diff -puN drivers/misc/hdpuftrs/hdpu_cpustate.c~powerpc-sky-cpu-redundant-or-incorrect-tests-on-unsigned drivers/misc/hdpuftrs/hdpu_cpustate.c
--- a/drivers/misc/hdpuftrs/hdpu_cpustate.c~powerpc-sky-cpu-redundant-or-incorrect-tests-on-unsigned
+++ a/drivers/misc/hdpuftrs/hdpu_cpustate.c
@@ -121,8 +121,6 @@ static ssize_t cpustate_read(struct file
 {
 	unsigned char data;
 
-	if (count < 0)
-		return -EFAULT;
 	if (count == 0)
 		return 0;
 
@@ -137,9 +135,6 @@ static ssize_t cpustate_write(struct fil
 {
 	unsigned char data;
 
-	if (count < 0)
-		return -EFAULT;
-
 	if (count == 0)
 		return 0;
 
_
