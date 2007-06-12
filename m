Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E320CDDE2E
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 04:55:31 +1000 (EST)
Message-ID: <466EE942.8070701@am.sony.com>
Date: Tue, 12 Jun 2007 11:43:14 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 03/30] PS3: Use __maybe_unused
References: <20070612181825.730300780@am.sony.com>>
In-Reply-To: <20070612181825.730300780@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the PS3 debug routines from using the GCC specific
'__attribute__ ((unused))' to the preprocessor macro
__maybe_unused.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/interrupt.c |    4 ++--
 arch/powerpc/platforms/ps3/time.c      |    2 +-
 drivers/ps3/vuart.c                    |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -533,7 +533,7 @@ static void _dump_64_bmp(const char *hea
 		*p & 0xffff);
 }
 
-static void __attribute__ ((unused)) _dump_256_bmp(const char *header,
+static void __maybe_unused _dump_256_bmp(const char *header,
 	const u64 *p, unsigned cpu, const char* func, int line)
 {
 	pr_debug("%s:%d: %s %u {%016lx:%016lx:%016lx:%016lx}\n",
@@ -552,7 +552,7 @@ static void _dump_bmp(struct ps3_private
 }
 
 #define dump_mask(_x) _dump_mask(_x, __func__, __LINE__)
-static void __attribute__ ((unused)) _dump_mask(struct ps3_private* pd,
+static void __maybe_unused _dump_mask(struct ps3_private* pd,
 	const char* func, int line)
 {
 	unsigned long flags;
--- a/arch/powerpc/platforms/ps3/time.c
+++ b/arch/powerpc/platforms/ps3/time.c
@@ -39,7 +39,7 @@ static void _dump_tm(const struct rtc_ti
 }
 
 #define dump_time(_a) _dump_time(_a, __func__, __LINE__)
-static void __attribute__ ((unused)) _dump_time(int time, const char* func,
+static void __maybe_unused _dump_time(int time, const char* func,
 	int line)
 {
 	struct rtc_time tm;
--- a/drivers/ps3/vuart.c
+++ b/drivers/ps3/vuart.c
@@ -83,7 +83,7 @@ struct ports_bmp {
 } __attribute__ ((aligned (32)));
 
 #define dump_ports_bmp(_b) _dump_ports_bmp(_b, __func__, __LINE__)
-static void __attribute__ ((unused)) _dump_ports_bmp(
+static void __maybe_unused _dump_ports_bmp(
 	const struct ports_bmp* bmp, const char* func, int line)
 {
 	pr_debug("%s:%d: ports_bmp: %016lxh\n", func, line, bmp->status);
@@ -107,7 +107,7 @@ static int ps3_vuart_match_id_to_port(en
 }
 
 #define dump_port_params(_b) _dump_port_params(_b, __func__, __LINE__)
-static void __attribute__ ((unused)) _dump_port_params(unsigned int port_number,
+static void __maybe_unused _dump_port_params(unsigned int port_number,
 	const char* func, int line)
 {
 #if defined(DEBUG)

-- 
