Return-Path: <wcohen@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8R9g3TT9zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 02:46:47 +1100 (AEDT)
Subject: Re: gcc trunk fails to build kernel on PowerPC64 due to oprofile
 warnings
To: Anton Blanchard <anton@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, rric@kernel.org
References: <20170126100044.7e439f72@kryten>
Cc: oprofile-list@lists.sf.net, linuxppc-dev@lists.ozlabs.org,
 Robert Richter <rric@kernel.org>
From: William Cohen <wcohen@redhat.com>
Message-ID: <fe2c2fd9-d255-61ca-5328-ca5d45827f47@redhat.com>
Date: Thu, 26 Jan 2017 10:46:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170126100044.7e439f72@kryten>
Content-Type: multipart/mixed; boundary="------------6162262BE16C5C97753D8CEE"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------6162262BE16C5C97753D8CEE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 01/25/2017 06:00 PM, Anton Blanchard wrote:
> Hi,
> 
> gcc trunk has failed to build PowerPC64 kernels for a month or so. The issue
> is in oprofile, which is common code but ends up being sucked into
> arch/powerpc and therefore subject to the -Werror applied to arch/powerpc:
>  
> linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c: In function ‘oprofile_create_stats_files’:
> linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c:55:25: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 7 [-Werror=format-truncation=]
>    snprintf(buf, 10, "cpu%d", i);
>                          ^~
> linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c:55:21: note: using the range [1, -2147483648] for directive argument
>    snprintf(buf, 10, "cpu%d", i);
>                      ^~~~~~~
> linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c:55:3: note: format output between 5 and 15 bytes into a destination of size 10
>    snprintf(buf, 10, "cpu%d", i);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   LD      crypto/async_tx/built-in.o
>   CC      lib/random32.o
> cc1: all warnings being treated as errors
> 
> Anton
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> oprofile-list mailing list
> oprofile-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/oprofile-list
> 

The attached patch should make the buffer large enough to eliminate the warning.

-Will

--------------6162262BE16C5C97753D8CEE
Content-Type: text/x-patch;
 name="0001-Avoid-hypthetical-string-truncation-in-oprofile-stat.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-Avoid-hypthetical-string-truncation-in-oprofile-stat.pa";
 filename*1="tch"

>From 7e46dbd7dc5bc941926a4a63c28ccebf46493e8d Mon Sep 17 00:00:00 2001
From: William Cohen <wcohen@redhat.com>
Date: Thu, 26 Jan 2017 10:33:59 -0500
Subject: [PATCH] Avoid hypthetical string truncation in oprofile stats buffer
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Increased the size of an internal oprofile driver buffer ensuring that
the string was never truncated for any possible int value to avoid the
following gcc-7 compiler error on ppc when building the kernel:

linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c: In function ‘oprofile_create_stats_files’:
linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c:55:25: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 7 [-Werror=format-truncation=]
   snprintf(buf, 10, "cpu%d", i);
                         ^~
linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c:55:21: note: using the range [1, -2147483648] for directive argument
   snprintf(buf, 10, "cpu%d", i);
                     ^~~~~~~
linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c:55:3: note: format output between 5 and 15 bytes into a destination of size 10
   snprintf(buf, 10, "cpu%d", i);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  LD      crypto/async_tx/built-in.o
  CC      lib/random32.o
cc1: all warnings being treated as errors

Signed-off-by: William Cohen <wcohen@redhat.com>
---
 drivers/oprofile/oprofile_stats.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/oprofile/oprofile_stats.c b/drivers/oprofile/oprofile_stats.c
index 59659ce..6fe7538 100644
--- a/drivers/oprofile/oprofile_stats.c
+++ b/drivers/oprofile/oprofile_stats.c
@@ -43,7 +43,7 @@ void oprofile_create_stats_files(struct dentry *root)
 	struct oprofile_cpu_buffer *cpu_buf;
 	struct dentry *cpudir;
 	struct dentry *dir;
-	char buf[10];
+	char buf[16];
 	int i;
 
 	dir = oprofilefs_mkdir(root, "stats");
@@ -52,7 +52,7 @@ void oprofile_create_stats_files(struct dentry *root)
 
 	for_each_possible_cpu(i) {
 		cpu_buf = &per_cpu(op_cpu_buffer, i);
-		snprintf(buf, 10, "cpu%d", i);
+		snprintf(buf, 16, "cpu%d", i);
 		cpudir = oprofilefs_mkdir(dir, buf);
 
 		/* Strictly speaking access to these ulongs is racy,
-- 
2.9.3


--------------6162262BE16C5C97753D8CEE--
