Message-ID: <39F91ED6.CD2AEF23@wanadoo.fr>
Date: Fri, 27 Oct 2000 08:21:10 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18pre17 again
References: <14839.53124.753011.489351@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> If anyone gets compile errors with my 2.2.18pre17 tree, or the current
> bk tree, please send me your .config.  I'm making a collection. :)

I am sorry, but it still doesn't compile with CONFIG_MAGIC_SYSRQ=y. You
would need to patch

--- mac_hid.c   Mon Oct 23 13:13:08 2000
+++ drivers/macintosh/mac_hid.c Thu Oct 26 23:24:13 2000
@@ -295,11 +295,11 @@
 #ifdef CONFIG_MAGIC_SYSRQ
-                       ppc_md.ppc_kbd_sysrq_xlate   =
mac_hid_kbd_sysrq_xlate;
+                       kbd_sysrq_xlate   = mac_hid_kbd_sysrq_xlate;
                        SYSRQ_KEY                = 0x69;
 #endif
                        memcpy(pc_key_maps_save, key_maps,
sizeof(key_maps));
                        memcpy(key_maps, mac_key_maps_save,
sizeof(key_maps));
                } else {
 #ifdef CONFIG_MAGIC_SYSRQ
-                       ppc_md.ppc_kbd_sysrq_xlate   =
pckbd_sysrq_xlate;
+                       kbd_sysrq_xlate   = pckbd_sysrq_xlate;
                        SYSRQ_KEY                = 0x54;
 #endif

BTW, why didn't you adopt the names from the bk-linuxppc_2_3 tree for
the kbd_sysrq_xlate stuff? IMHO the circular macro definitions

#define kbd_sysrq_xlate (ppc_md.kbd_sysrq_xlate)
#define SYSRQ_KEY (ppc_md.SYSRQ_KEY)

in include/asm-ppc/keyboard.h are asking for trouble. They give you an
error  (" parse error before `(' ") if you want to say

ppc_md.kbd_sysrq_xlate   = pckbd_sysrq_xlate;

for example. If one day you should decide to #include <asm/keyboard.h>
into arch/ppc/kernel/pmac_setup.c, it won't compile any more.

Another problem I am having must be due to some bug in the screen
blanking code: The X server (Franz's XF-4.0.1) kills itself (and
everything that is running in an X window) after 10 minutes of idling.
This does not happen with 2.4.0-test kernels. It bit me hard, because it
happened while netscape was updating itself inside MOL inside an X
window. Now the MacOS boot partition is severely damaged.

If only MOL would run on 2.4.0 kernels on 603 machines, I would never go
back to 2.2.x kernels.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
