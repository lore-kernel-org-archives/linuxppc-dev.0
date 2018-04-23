Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Tzpk3DHmzF24L
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 18:17:34 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] powerpc: rtas: clean up time handling
Date: Mon, 23 Apr 2018 10:10:26 +0200
Message-Id: <20180423081114.1813726-2-arnd@arndb.de>
In-Reply-To: <20180423081114.1813726-1-arnd@arndb.de>
References: <20180423081114.1813726-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The to_tm() helper function operates on a signed integer for the time,
so it will suffer from overflow in 2038, even on 64-bit kernels.

Rather than fix that function, this replaces its use in the rtas
procfs implementation with the standard rtc_time64_to_tm() helper
that is very similar but is not affected by the overflow.

In order to actually support long times, the parser function gets
changed to 64-bit user input and output as well. Note that the tm_mon
and tm_year representation is slightly different, so we have to manually
add an offset here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/rtas-proc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index fb070d8cad07..80864b787745 100644
--- a/arch/powerpc/kernel/rtas-proc.c
+++ b/arch/powerpc/kernel/rtas-proc.c
@@ -280,7 +280,7 @@ static int __init proc_rtas_init(void)
 
 __initcall(proc_rtas_init);
 
-static int parse_number(const char __user *p, size_t count, unsigned long *val)
+static int parse_number(const char __user *p, size_t count, u64 *val)
 {
 	char buf[40];
 	char *end;
@@ -293,7 +293,7 @@ static int parse_number(const char __user *p, size_t count, unsigned long *val)
 
 	buf[count] = 0;
 
-	*val = simple_strtoul(buf, &end, 10);
+	*val = simple_strtoull(buf, &end, 10);
 	if (*end && *end != '\n')
 		return -EINVAL;
 
@@ -307,17 +307,17 @@ static ssize_t ppc_rtas_poweron_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct rtc_time tm;
-	unsigned long nowtime;
+	time64_t nowtime;
 	int error = parse_number(buf, count, &nowtime);
 	if (error)
 		return error;
 
 	power_on_time = nowtime; /* save the time */
 
-	to_tm(nowtime, &tm);
+	rtc_time64_to_tm(nowtime, 0, &tm);
 
 	error = rtas_call(rtas_token("set-time-for-power-on"), 7, 1, NULL, 
-			tm.tm_year, tm.tm_mon, tm.tm_mday, 
+			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
 			tm.tm_hour, tm.tm_min, tm.tm_sec, 0 /* nano */);
 	if (error)
 		printk(KERN_WARNING "error: setting poweron time returned: %s\n", 
@@ -373,14 +373,14 @@ static ssize_t ppc_rtas_clock_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct rtc_time tm;
-	unsigned long nowtime;
+	time64_t nowtime;
 	int error = parse_number(buf, count, &nowtime);
 	if (error)
 		return error;
 
-	to_tm(nowtime, &tm);
+	rtc_time64_to_tm(nowtime, 0, &tm);
 	error = rtas_call(rtas_token("set-time-of-day"), 7, 1, NULL, 
-			tm.tm_year, tm.tm_mon, tm.tm_mday, 
+			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
 			tm.tm_hour, tm.tm_min, tm.tm_sec, 0);
 	if (error)
 		printk(KERN_WARNING "error: setting the clock returned: %s\n", 
@@ -401,8 +401,8 @@ static int ppc_rtas_clock_show(struct seq_file *m, void *v)
 		unsigned int year, mon, day, hour, min, sec;
 		year = ret[0]; mon  = ret[1]; day  = ret[2];
 		hour = ret[3]; min  = ret[4]; sec  = ret[5];
-		seq_printf(m, "%lu\n",
-				mktime(year, mon, day, hour, min, sec));
+		seq_printf(m, "%lld\n",
+				mktime64(year, mon, day, hour, min, sec));
 	}
 	return 0;
 }
@@ -731,7 +731,7 @@ static void get_location_code(struct seq_file *m, struct individual_sensor *s,
 static ssize_t ppc_rtas_tone_freq_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
-	unsigned long freq;
+	u64 freq;
 	int error = parse_number(buf, count, &freq);
 	if (error)
 		return error;
@@ -756,7 +756,7 @@ static int ppc_rtas_tone_freq_show(struct seq_file *m, void *v)
 static ssize_t ppc_rtas_tone_volume_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
-	unsigned long volume;
+	u64 volume;
 	int error = parse_number(buf, count, &volume);
 	if (error)
 		return error;
-- 
2.9.0
