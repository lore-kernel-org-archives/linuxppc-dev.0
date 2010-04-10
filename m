Return-Path: <bgat@billgatliff.com>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
	[209.85.211.196]) by ozlabs.org (Postfix) with ESMTP id 2C958B7CF7
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 13:53:12 +1000 (EST)
Received: by ywh34 with SMTP id 34so2068939ywh.17
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Apr 2010 20:53:10 -0700 (PDT)
Message-ID: <4BBFF66D.7020206@billgatliff.com>
Date: Fri, 09 Apr 2010 22:54:21 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-embedded <linux-embedded@vger.kernel.org>
Subject: Re: A better way to sequence driver initialization?
References: <4BBF7E9C.80604@billgatliff.com>
In-Reply-To: <4BBF7E9C.80604@billgatliff.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bill Gatliff wrote:
> If someone doesn't tell me this is a stupid idea, I might post it to
> lkml.  Now's your chance!  :)
>   

So I went ahead and tried it anyway:


$ git diff init/main.c
diff --git a/init/main.c b/init/main.c
index dac44a9..1461d09 100644
--- a/init/main.c
+++ b/init/main.c
@@ -753,7 +753,11 @@ static void __init do_initcalls(void)
        initcall_t *fn;

        for (fn = __early_initcall_end; fn < __initcall_end; fn++)
+#if 1
+               kthread_run(do_one_initcall, *fn, "do_initcalls");
+#else
                do_one_initcall(*fn);
+#endif

        /* Make sure there is no pending stuff from the initcall sequence */
        flush_scheduled_work();

Interestingly, things didn't blow up as quickly as I had expected they
would.  :)

Booting with initcall_debug=1 both with and without the kthread_run()
mod has proven insightful.  The first OOPS I get with the mod looks like
this:

...
calling  ch_init+0x0/0x18 @ 325
Unable to handle kernel NULL pointer dereference at virtual address
00000000
pgd = c0004000
[00000000] *pgd=00000000 
Internal error: Oops: 5 [#4] PREEMPT 
last sysfs file:
Modules linked in: 
CPU: 0 Tainted: GD  (2.6.33-rc5-csb737-00010-gaba040a-dirty #59)
PC is at kset_find_obj+0x18/0x98
LR is at kset_find_obj+0x18/0x98
pc : [<c018156c>] lr : [<c018156c>] psr: 20000013
sp : c3937f68  ip : c3937f68  fp : 00000000
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : c0396a6f  r6 : 00000000  r5 : 00000005  r4 : c03f03b0
r3 : 00000003  r2 : c3936000  r1 : 00000000  r0 : 00000001
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: 20004000  DAC: 00000017
Process do_initcalls (pid: 325, stack limit = 0xc3936270) 
Stack: (0xc3937f68 to 0xc3938000) 
7f60: c03fc050 c03f03b0 00000005 c03f03b0 00000000 c01c471c
7f80: c03f03b0 00000005 c001e62c 00000000 00000000 c024007c 00000000
1b58d32c
7fa0: 00000005 c002c39c c381bfac c001e62c 1b58d32c 00000005 00000000
c3937fd4
7fc0: c381bfac c001e62c c002c340 c005cb3c 00000000 00000000 c3937fd8
c3937fd8
7fe0: 00000000 00000000 00000000 00000000 00000000 c002df78 00000000
00000000
[<c018156c>] (kset_find_obj+0x18/0x98) from [<c01c471c>]
(driver_register+0x88/0x150)
[<c01c471c>] (driver_register+0x88/0x150) from [<c024007c>]
(__hid_register_driver+0x38/0x70) 
[<c024007c>] (__hid_register_driver+0x38/0x70) from [<c002c39c>]
(do_one_initcall+0x5c/0x1c4) 
[<c002c39c>] (do_one_initcall+0x5c/0x1c4) from [<c005cb3c>]
(kthread+0x78/0x80)
[<c005cb3c>] (kthread+0x78/0x80) from [<c002df78>]
(kernel_thread_exit+0x0/0x8)
Code: e24dd004 e3a00001 e1a07001 ebfaf76c (e5963000)
---[ end trace f9bb68fd55862436 ]--- 
note: do_initcalls[325] exited with preempt_count 1
...

There is a ch_init() function in drivers/hid/hid-cherry.c.  I think that
function is calling hid_register_driver() before hid_init() has set up
hid_bus_type.  That causes kset_find_obj() to die because the kset
structure it gets passed in ch_init() refers to a bus that doesn't exist
yet.  It's a plain 'ole initialization race.

Maybe there are fewer places that would need wait queues than I
originally thought!  At least for drivers that use the device API,
kset_find_obj() might be the only place that needs to wait until a
device or bus appears.  If I get a second next week, I might hack one in
there and see how much farther I get...


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
