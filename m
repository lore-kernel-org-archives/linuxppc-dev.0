Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (scrye.com [75.148.32.185])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E17C2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 09:35:46 +1000 (EST)
Message-ID: <5181A6CA.9090903@scrye.com>
Date: Wed, 01 May 2013 17:35:38 -0600
From: Anthony Foiani <tkil@scrye.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
References: <1367431525.29231.6@snotra>
In-Reply-To: <1367431525.29231.6@snotra>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott --

Thanks again for the quick reply.

On 05/01/2013 12:05 PM, Scott Wood wrote:
> On 04/30/2013 09:06:56 PM, Anthony Foiani wrote:
>> Instead of a new property name, I would instead check for my specific 
>> board type (let's call it a foo-8315) in the top-level compatible 
>> list?  So I'd change my devtree to have this top-level compatible:
>>
>> / {
>>     compatible = "example,foo-8315", "fsl,mpc8315erdb";
>
> It should really only have compatible = "example,foo-8315", since it's 
> not 100% compatible with fsl,mpc8315erdb (at least due to this bug, 
> but probably there are other differences as well).

Then I guess I don't understand the proper use of "compatible" (or is 
the root node special?)

E.g., the DTS for the "parent" board (MPC8315ERDB) has multiple entries 
for the crypto "compatible" value:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/boot/dts/mpc8315erdb.dts?id=refs/tags/v3.9#n286
(or: *http://preview.tinyurl.com/btlqxgo* )

|		crypto@30000 {
			compatible = "fsl,sec3.3", "fsl,sec3.1", "fsl,sec3.0",
				     "fsl,sec2.4", "fsl,sec2.2", "fsl,sec2.1",
				     "fsl,sec2.0";
			reg = <0x30000 0x10000>;|

I read this as meaning: "if you have to ask if a certain feature is 
compatible with some 'foo', then this board provides that 
compatibility".  Not as "if a value is in the compatibility flag, then 
it is 100% compatible with that value".  (Although maybe that's true in 
the case of the SEC, so perhaps that a bad example.)

For what it's worth, the upstream vendor did have a separate root-node 
"compatible" value -- which called a board-specific function in a 
board-specific C file, both of which were direct cut & paste copies from 
the MPC8315ERDB function / file.  My gut instinct is that this degree of 
duplication is unhealthy and incorrect, but if my solution is considered 
abuse of the device tree, then I can try to do it a different way next 
time.

To clarify what I mean by "cut and paste", here are the differences 
between the 2.6.36 MPC8315ERDB dts, and the one the vendor sent us 
(based on that kernel rev):

$ diff -u arch/powerpc/boot/dts/mpc8315erdb.dts ~/foo.dts
[tony@hum linux-stable]$ --- arch/powerpc/boot/dts/mpc8315erdb.dts    
2013-05-01 17:23:36.803167646 -0600
+++ /home/tony/foo.dts    2013-05-01 17:18:55.009632505 -0600
@@ -1,4 +1,10 @@
  /*
+ * Foo 8315 Device Tree Source
+ *
+ * Copyright 2010 FooCorp
+ *
+ * Based on:
+ *
   * MPC8315E RDB Device Tree Source
   *
   * Copyright 2007 Freescale Semiconductor Inc.
@@ -12,7 +18,7 @@
  /dts-v1/;

  / {
-    compatible = "fsl,mpc8315erdb";
+    compatible = "fsl,foo-8315";
      #address-cells = <1>;
      #size-cells = <1>;

That's it.  And for the copy from mpc831x_rdb.c to foo8315.c?

--- mpc831x_rdb.c    2013-05-01 17:23:36.860167147 -0600
+++ foo8315.c    2013-05-01 17:27:04.310352475 -0600
@@ -1,5 +1,5 @@
  /*
- * arch/powerpc/platforms/83xx/mpc831x_rdb.c
+ * arch/powerpc/platforms/83xx/foo8315.c
   *
   * Description: MPC831x RDB board specific routines.
   * This file is based on mpc834x_sys.c
@@ -26,14 +26,14 @@
  /*
   * Setup the architecture
   */
-static void __init mpc831x_rdb_setup_arch(void)
+static void __init foo8315_setup_arch(void)
  {
  #ifdef CONFIG_PCI
      struct device_node *np;
  #endif

      if (ppc_md.progress)
-        ppc_md.progress("mpc831x_rdb_setup_arch()", 0);
+        ppc_md.progress("foo8315_setup_arch()", 0);

  #ifdef CONFIG_PCI
      for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
@@ -44,7 +44,7 @@
      mpc831x_usb_cfg();
  }

-static void __init mpc831x_rdb_init_IRQ(void)
+static void __init foo8315_init_IRQ(void)
  {
      struct device_node *np;

@@ -63,12 +63,12 @@
  /*
   * Called very early, MMU is off, device-tree isn't unflattened
   */
-static int __init mpc831x_rdb_probe(void)
+static int __init foo8315_probe(void)
  {
      unsigned long root = of_get_flat_dt_root();

      return of_flat_dt_is_compatible(root, "MPC8313ERDB") ||
-           of_flat_dt_is_compatible(root, "fsl,mpc8315erdb");
+           of_flat_dt_is_compatible(root, "fsl,foo8315");
  }

  static struct of_device_id __initdata of_bus_ids[] = {
@@ -83,13 +83,13 @@
      of_platform_bus_probe(NULL, of_bus_ids, NULL);
      return 0;
  }
-machine_device_initcall(mpc831x_rdb, declare_of_platform_devices);
+machine_device_initcall(foo8315, declare_of_platform_devices);

-define_machine(mpc831x_rdb) {
-    .name            = "MPC831x RDB",
-    .probe            = mpc831x_rdb_probe,
-    .setup_arch        = mpc831x_rdb_setup_arch,
-    .init_IRQ        = mpc831x_rdb_init_IRQ,
+define_machine(foo8315) {
+    .name            = "foo-8315",
+    .probe            = foo8315_probe,
+    .setup_arch        = foo8315_setup_arch,
+    .init_IRQ        = foo8315_init_IRQ,
      .get_irq        = ipic_get_irq,
      .restart        = mpc83xx_restart,
      .time_init        = mpc83xx_time_init,

Given those diffs, it didn't seem much of a stretch to use compatible = 
"fsl,mpc8315erdb"

> Well, if this is only seen on your board so far (or rather, your 
> vendor's board which isn't upstream), and you're OK with updating the 
> device tree, then I have no objection.
Well, so far as I know, this project is the only consumer of these 
boards.  I've fed all my fixes/changes back to our vendor, but they're 
not interested in upstreaming it.

I have been trying to at least get the patches into the public arena, 
but I don't have the bandwidth to move to tip-of-tree and do testing 
there, as well as moving project along the actual release path (which is 
based on long-term releases, hence my patch being against 3.4.y).

For my use, this is a good compromise: I've documented the errata (even 
if we don't know the root cause), and it is now set up so that I can't 
lose the setting just by doing a config update (which was the problem 
with the orphan config setting).

> > It would also be nice if we could unravel exactly why that 
> CONFIG_8315_DS ever showed up in the first place.
>
> It would be nice, but I doubt that particular information is ever 
> going to surface...  IIRC I asked internally back when this first came 
> up, and didn't get an answer.
Right, that's my recollection as well.

I end up feeling a bit put-upon, though, when I'm asked for a 
comprehensive patch to cover something that the original authors can't 
explain.

>
>>> Or do you mean that you would not set this on any board's device 
>>> tree by default, and instead have users set it if they encounter 
>>> problems?
>>
>> No, I would expect to set it on all the boards, so using the 
>> compatibility hack above would work.
>
> You mean all the boards that have the bug, which doesn't include any 
> upstream device tree, right?
As mentioned above, my primary concern is the use of these cards in the 
project/product I'm working on.  My answer has been to apply this fix 
(and the matching change to the device tree I supply as a part of the 
boot image).  I feel that I'm trying to do the right thing by getting 
some of these changes publicly visible, but I fear that I'll also have 
to go down the route of "not enough time or money to properly upstream it".

"doesn't include upstream device tree" ... no, the device tree was 
supplied with the original set of patches from the vendor.

And it seems like it's a bit of a corner case -- even on other MPC8315 
boards, it seems that only 2-3 of us have ever run into this.  Maybe not 
many people use the SATA features, or they use them with older/slower 
drives that never try to negotiate above 1.5Gbps (given that it's a 6yo 
design or so).

Anyway.  Thanks for all the feedback, but at this point, I'm going to go 
with the patch I already supplied.  Hopefully it will make someone 
else's life easier at some later date.

Thanks again!

Take care,
Anthony
