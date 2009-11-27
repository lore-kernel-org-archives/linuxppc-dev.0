Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id F1D2F100AD6
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Nov 2009 09:33:48 +1100 (EST)
Date: Sat, 28 Nov 2009 01:33:47 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: systemtap@sourceware.org
Subject: [PATCH 6/8] Use proper types for do_div
Message-ID: <20091127223347.GF21805@oksana.dev.rtsoft.ru>
References: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

do_div accepts unsigned 64-bit integer type for dividend, signed types
would cause do_div's typecheck fail:

stat-common.c: In function 'needed_space':
stat-common.c:50: error: comparison of distinct pointer types lacks a cast
...same errors in time.c and tapset-timers.cxx's generated code...

A fix for time.c is special, on ppc32 cycles_t is 32-bit, so technically
we don't need do_div, but since the whole _stp_gettimeofday_ns() operates
on 64-bit types we'd better be safe and use uint64_t for the math.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 runtime/stat-common.c |    8 ++++----
 runtime/time.c        |    3 ++-
 tapset-timers.cxx     |    2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/runtime/stat-common.c b/runtime/stat-common.c
index 7123dc8..f970304 100644
--- a/runtime/stat-common.c
+++ b/runtime/stat-common.c
@@ -34,7 +34,7 @@ static int _stp_stat_calc_buckets(int stop, int start, int interval)
 	return buckets;
 }
 
-static int needed_space(int64_t v)
+static int needed_space(uint64_t v)
 {
 	int space = 0;
 
@@ -134,7 +134,7 @@ static void _stp_stat_print_histogram_buf(char *buf, size_t size, Hist st, stat
 {
 	int scale, i, j, val_space, cnt_space;
 	int low_bucket = -1, high_bucket = 0, over = 0, under = 0;
-	int64_t val, v, valmax = 0;
+	uint64_t val, v, valmax = 0;
 	int eliding = 0;
 	char *cur_buf = buf, *fake = buf;
 	char **bufptr = (buf == NULL ? &fake : &cur_buf);
@@ -186,7 +186,7 @@ static void _stp_stat_print_histogram_buf(char *buf, size_t size, Hist st, stat
 	if (valmax <= HIST_WIDTH)
 		scale = 1;
 	else {
-		int64_t tmp = valmax;
+		uint64_t tmp = valmax;
 		int rem = do_div(tmp, HIST_WIDTH);
 		scale = tmp;
 		if (rem) scale++;
@@ -282,7 +282,7 @@ static void _stp_stat_print_histogram(Hist st, stat *sd)
 	_stp_print_flush();
 }
 
-static void __stp_stat_add (Hist st, stat *sd, int64_t val)
+static void __stp_stat_add (Hist st, stat *sd, uint64_t val)
 {
 	int n;
 	if (sd->count == 0) {
diff --git a/runtime/time.c b/runtime/time.c
index 58c23e5..d588370 100644
--- a/runtime/time.c
+++ b/runtime/time.c
@@ -275,7 +275,8 @@ static int64_t
 _stp_gettimeofday_ns(void)
 {
     int64_t base;
-    cycles_t last, delta;
+    cycles_t last;
+    uint64_t delta;
     unsigned int freq;
     unsigned int seq;
     stp_time_t *time;
diff --git a/tapset-timers.cxx b/tapset-timers.cxx
index 6574626..7195cfa 100644
--- a/tapset-timers.cxx
+++ b/tapset-timers.cxx
@@ -241,7 +241,7 @@ hrtimer_derived_probe_group::emit_interval (translator_output* o)
 {
   o->line() << "({";
   o->newline(1) << "unsigned long nsecs;";
-  o->newline() << "int64_t i = stp->intrv;";
+  o->newline() << "uint64_t i = stp->intrv;";
   o->newline() << "if (stp->rnd != 0) {";
   // XXX: why not use stp_random_pm instead of this?
   o->newline(1) << "int64_t r;";
-- 
1.6.3.3
