Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tB3l50FHLzDvQb
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Nov 2016 03:17:36 +1100 (AEDT)
Subject: Problem with the commit "console: don't prefer first registered if DT
 specifies stdout-path"
References: <86E27593-C6C2-4BBA-995E-95A97BB8CB12@xenosoft.de>
 <b0c2cd4e-5046-4114-ef1f-88ee3f40e150@xenosoft.de>
 <14903BF2-A5B9-430B-B63E-AAEC3FC454F2@xenosoft.de>
 <a956a42b-7a1e-f4d9-4998-6e0012ded5c9@xenosoft.de>
 <f0f6d5ac-d39d-0a42-f7ba-3f8211085b06@xenosoft.de> <398c3cc1-80c5-30
 ce-c05a-4280290e54d0@xenosoft.de>
 <75F756E5-E8B8-4382-9632-15C3DE572A75@xenosoft.de>
 <F8187632-04F5-4976-A151-9D234AF1AD0A@xenosoft.de>
 <a3a9d5b0-701c-4181-da03-659913d75adc@candw.ms>
 <d38a9e3b-00df-c879-18bb-d053c0c7d6a1@xenosoft.de>
 <b90923cc-a346-717f-fef0-807c91552d09@xenosoft.de>
 <23567bc3-f9e9-3a77-3def-6820ce3285df@candw.ms> <5a77bef0-50ac-801e-e4
 86-08b524abaf0f@xenosoft.de>
 <19E9D3FF-6FD3-49D7-8E9B-2660DBBFBD6E@xenosoft.de>
 <9da8c949-c1a2-3032-a31f-61bafff270f9@candw.ms>
 <7ea85187-cc4b-b3fb-77c5-57f6c63b3aeb@xenosoft.de>
 <0f04fb38-a0d3-3fb4-6232-2951e0e9b666@xenosoft.de>
 <e102f3b9-9a3d-ac5b-193a-9b1073192e93@xenosoft.de>
 <0ff108f9-4112-7f13-2c9d-8881e5416431@xenosoft.de>
To: paul.burton@imgtec.com, linuxppc-dev@lists.ozlabs.org
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <d71d79fa-ebe8-4f6f-f04f-ce3583b59019@xenosoft.de>
Date: Sat, 5 Nov 2016 16:11:11 +0100
MIME-Version: 1.0
In-Reply-To: <0ff108f9-4112-7f13-2c9d-8881e5416431@xenosoft.de>
Content-Type: multipart/mixed; boundary="------------9E3D413BB79CDD9A60DCE79A"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------9E3D413BB79CDD9A60DCE79A
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hello Paul,

After your commit "console: don't prefer first registered if DT 
specifies stdout-path" [1] we couldn't see any kernel boot messages 
anymore. I restored the old code and after that I was able to see the 
messages again.

System: Nemo board with P.A. Semi PA6T PowerPC CPU

I understand your idea of this patch but unfortunately it doesn't work 
with our system. There isn't a possibility to modify the DT.

We have created a patch for removing your commit but I hope you have a 
better idea.

Cheers,
Christian

[1] 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=05fd007e46296afb24d15c7d589d535e5a5b9d5c

--------------9E3D413BB79CDD9A60DCE79A
Content-Type: text/x-patch;
 name="console.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="console.patch"

diff -rupN a/drivers/of/base.c b/drivers/of/base.c
--- a/drivers/of/base.c	2016-10-29 22:52:02.000000000 +0200
+++ b/drivers/of/base.c	2016-11-04 11:59:07.049568281 +0100
@@ -2077,8 +2077,6 @@ void of_alias_scan(void * (*dt_alloc)(u6
 			name = of_get_property(of_aliases, "stdout", NULL);
 		if (name)
 			of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
-		if (of_stdout)
-			console_set_by_of();
 	}
 
 	if (!of_aliases)
diff -rupN a/include/linux/console.h b/include/linux/console.h
--- a/include/linux/console.h	2016-10-29 22:52:02.000000000 +0200
+++ b/include/linux/console.h	2016-11-04 12:00:22.808701652 +0100
@@ -173,12 +173,6 @@ static inline void console_sysfs_notify(
 #endif
 extern bool console_suspend_enabled;
 
-#ifdef CONFIG_OF
-extern void console_set_by_of(void);
-#else
-static inline void console_set_by_of(void) {}
-#endif
-
 /* Suspend and resume console messages over PM events */
 extern void suspend_console(void);
 extern void resume_console(void);
diff -rupN a/kernel/printk/printk.c b/kernel/printk/printk.c
--- a/kernel/printk/printk.c	2016-10-29 22:52:02.000000000 +0200
+++ b/kernel/printk/printk.c	2016-11-04 12:04:36.083094450 +0100
@@ -253,17 +253,6 @@ static int preferred_console = -1;
 int console_set_on_cmdline;
 EXPORT_SYMBOL(console_set_on_cmdline);
 
-#ifdef CONFIG_OF
-static bool of_specified_console;
-
-void console_set_by_of(void)
-{
-	of_specified_console = true;
-}
-#else
-# define of_specified_console false
-#endif
-
 /* Flag: console code may call schedule() */
 static int console_may_schedule;
 
@@ -2657,7 +2646,7 @@ void register_console(struct console *ne
 	 *	didn't select a console we take the first one
 	 *	that registers here.
 	 */
-	if (preferred_console < 0 && !of_specified_console) {
+	if (preferred_console < 0) {
 		if (newcon->index < 0)
 			newcon->index = 0;
 		if (newcon->setup == NULL ||

--------------9E3D413BB79CDD9A60DCE79A--
