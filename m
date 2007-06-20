Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id E095CDDE43
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 13:13:33 +1000 (EST)
Date: Wed, 20 Jun 2007 13:13:33 +1000
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH/RFC] Make certain timekeeping variables __read_mostly
Message-ID: <20070620031333.GP9768@bakeyournoodle.com>
References: <20070619063557.GK9768@bakeyournoodle.com>
	<20070619145356.GA20382@lixom.net>
	<20070620020211.GO9768@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070620020211.GO9768@bakeyournoodle.com>
From: tony@bakeyournoodle.com (Tony Breeds)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2007 at 12:02:11PM +1000, Tony Breeds wrote:
 
> Also this patch makes tb_to_ns_scale and tb_to_ns_shift static for good
> measure.

While we're ate it these 3 variables can be marked __read_mostly.

Depends on previous patch.

From: Tony Breeds <tony@bakeyournoodle.com>

These really are read mostly as they're only written to in time_init()

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---
There looks to be other variables that can be made read_mostly, I think
that's a job for another day though (perhaps while doing the static cleanup).

 arch/powerpc/kernel/time.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
Index: working/arch/powerpc/kernel/time.c
===================================================================
--- working.orig/arch/powerpc/kernel/time.c	2007-06-20 12:08:27.000000000 +1000
+++ working/arch/powerpc/kernel/time.c	2007-06-20 12:08:32.000000000 +1000
@@ -113,9 +113,9 @@ u64 ticklen_to_xs;	/* 0.64 fraction */
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL_GPL(rtc_lock);
 
-static u64 tb_to_ns_scale;
-static unsigned tb_to_ns_shift;
-static unsigned long boot_tb;
+static u64 tb_to_ns_scale __read_mostly;
+static unsigned tb_to_ns_shift __read_mostly;
+static unsigned long boot_tb __read_mostly;
 
 struct gettimeofday_struct do_gtod;
 

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
