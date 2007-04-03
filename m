Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4612C48F.9080805@am.sony.com>
Date: Tue, 03 Apr 2007 14:18:07 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
References: <1175208237.3122.78.camel@pmac.infradead.org>	<26babf7b7398794f08e7417377b3facc@kernel.crashing.org>	<1175473220.3144.1.camel@concordia.ozlabs.ibm.com>	<432af8a0f928491e7d376923829f40a0@kernel.crashing.org>	<1175568133.16182.15.camel@concordia
In-Reply-To: <1175611539.2665.30.camel@shinybook.infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, nhorman@redhat.com,
	cbe-oss-dev <cbe-oss-dev@ozlabs.org>, Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse wrote:
> On Mon, 2007-04-02 at 23:16 -0400, David Woodhouse wrote:
>> > > My question remains: shouldn't Linux get that
>> > > information from the device tree, instead?  The
>> > > bootwrapper or bootloader can put it there.
>> > 
>> > Yes it _should_, but it doesn't.
>> 
>> It _used_ to. The 2.6.16 kernel just used the memory listed in the
>> device tree. That's _why_ we need this hack -- because when we boot
>> from
>> 2.6.16 with the memory listed in the device tree, it ends up getting
>> registered twice by the new kernel. 
> 
> Why _did_ we make this change? It makes /sbin/kexec unhappy too, since
> it doesn't like the apparent lack of _any_ memory.
> 
> It's not as if anyone's going to be expanding the amount of memory in
> their PS3, so it really needs to be dynamically detected.
> 
> If we were to put the memory back in the device-tree, and start with a
> single region up to 0x07c00000 followed by another region with the rest
> of it, then we wouldn't need the rmo_top hack to /sbin/kexec either.

I'm in the middle of implementing the zImage and kexec support for the
2.6.21 kernel, but haven't pushed all of it out to ps3-linux.git yet.
Once that is done, there is little need for a 2.6.16 based bootloader,
since it would be just as well to use a recent kernel.

In the interim, for compatibility with the legacy 2.6.16 based bootloader,
I have the hack ps3-no-bootwrapper-hack.diff.  Ben Collins did his
hack for Ubuntu (follows) which tries to use the DT passed from
the bootloader.  I planed to add it, or similar hack to ps3-linux.git
sometime soon.  As I mentioned in another mail, the proper way is to
just grab the command line passed from the bootloader and use it with
the built-in DT.  Ben's patch does effectively the same thing.

-Geoff


From: Ben Collins <ben.collins@ubuntu.com>
[PATCH]: Use the dt passed from kboot

It's untested, but patched against ps3-linux-dev git.

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -1642,7 +1642,7 @@ _STATIC(__start_initialization_iSeries)
 
 #if defined(CONFIG_PPC_PS3)
 _STATIC(__start_ps3_kexec)
-#if 1 /* override DT passed from bootloader */
+#if 0 /* override DT passed from bootloader */
 	LOAD_REG_IMMEDIATE(r3, dt_blob_start)
 	clrldi	r3, r3, 2 /* convert to physical */
 #endif
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -969,6 +969,8 @@ static void __init early_reserve_mem(void)
 
 void __init early_init_devtree(void *params)
 {
+	unsigned long dt_root;
+
 	DBG(" -> early_init_devtree(%p)\n", params);
 
 	/* Setup flat device-tree pointer */
@@ -988,7 +990,15 @@ void __init early_init_devtree(void *params)
 	/* Scan memory nodes and rebuild LMBs */
 	lmb_init();
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
-	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
+
+	/* 
+	 * For PS3, the values in the dt were set by the boot loader
+	 * (for kexec), and we don't want to use them. Instead, use the
+	 * lv1 callbacks (done later in ps3_setup).
+	 */
+	dt_root = of_get_flat_dt_root();
+	if (!of_flat_dt_is_compatible(dt_root, "PS3"))
+		of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 
 	/* Save command line for /proc/cmdline and then parse parameters */
 	strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
