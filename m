Return-Path: <michael@ozlabs.org>
To: <apw@shadowen.org>
Message-Id: <547098715b7ba4beb99bf2674a22debca001dc68.1210902536.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Discourage use of __initcall() in favour of device_initcall()
Date: Fri, 16 May 2008 11:49:14 +1000 (EST)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	rpjday@crashcourse.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a comment above the definition of __initcall(), just in case
someone looks here.

And add a checkpatch warning for new uses of __initcall().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

How's this? My perl skills are not good, but this seems to work.

 include/linux/init.h  |    1 +
 scripts/checkpatch.pl |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 21d658c..6390e22 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -193,6 +193,7 @@ extern void (*late_time_init)(void);
 #define late_initcall(fn)		__define_initcall("7",fn,7)
 #define late_initcall_sync(fn)		__define_initcall("7s",fn,7s)
 
+/* Please use device_initcall() directly in new code */
 #define __initcall(fn) device_initcall(fn)
 
 #define __exitcall(fn) \
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b6bbbcd..3faff3f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2026,6 +2026,10 @@ sub process {
 		if ($line =~ /\bsimple_(strto.*?)\s*\(/) {
 			WARN("consider using strict_$1 in preference to simple_$1\n" . $herecurr);
 		}
+# check for __initcall(), use device_initcall() explicitly please
+		if ($line =~ /^.\s*__initcall\(/) {
+			WARN("please use device_initcall() instead of __initcall()\n" . $herecurr);
+		}
 
 # use of NR_CPUS is usually wrong
 # ignore definitions of NR_CPUS and usage to define arrays as likely right
-- 
1.5.3.7.1.g4e596e
