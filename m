Mime-Version: 1.0 (Apple Message framework v618)
Message-Id: <3461F858-E7F6-11D8-B7C4-000A95A0560C@us.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: "'linuxppc-dev@lists.linuxppc.org' Development" <linuxppc-dev@lists.linuxppc.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: PReP bootloader VGA console
Date: Fri, 6 Aug 2004 17:16:03 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is the minimal patch needed to get the bootloader prompt on VGA
for PReP.

--- 1.1/arch/ppc/boot/simple/misc-prep.c        Mon Mar  1 17:34:28 2004
+++ edited/arch/ppc/boot/simple/misc-prep.c     Fri Aug  6 17:21:00 2004
@@ -89,6 +89,7 @@
         }

  #if defined(CONFIG_VGA_CONSOLE)
+       serial_fixups();
         vga_init((unsigned char *)0xC0000000);
  #endif /* CONFIG_VGA_CONSOLE */

Of course that looks funny doesn't it? "serial_fixups()" just sets
ISA_io, so should probably be called something else.

Also it's written in assembly in legacy.S (with matching chrpmap.S),
which could easily become prepmap.c and chrpmap.c.

Even better ISA_io could have a #define that's used in misc.c and
misc-prep.c...

But all of this would require more digging through makefiles and weak
aliases than it's probably worth.

--
Hollis Blanchard
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
