From: Chas Williams <chas@cmf.nrl.navy.mil>
Date: Thu, 8 Apr 1999 07:13:51 -0400 (EDT)
Message-Id: <199904081113.HAA12863@borg.cmf.nrl.navy.mil>
To: linuxppc-dev@lists.linuxppc.org
Subject: readl() macro on ppc missing ()'s
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



i had to make the following change to include/asm-ppc/io.h in order
to avoid side effects (btw, the CONFIG_APU version has it right!):

--- io.h.000    Thu Apr  8 07:10:36 1999
+++ io.h        Thu Apr  8 07:10:47 1999
@@ -49,7 +49,7 @@
 #define writel(b,addr) ((*(volatile unsigned int *) (addr)) = (b))
 #else
 #define readw(addr) in_le16((volatile unsigned short *)(addr))
-#define readl(addr) in_le32((volatile unsigned *)addr)
+#define readl(addr) in_le32((volatile unsigned *)(addr))
 #define writew(b,addr) out_le16((volatile unsigned short *)(addr),(b))
 #define writel(b,addr) out_le32((volatile unsigned *)(addr),(b))
 #endif

this seems to still be 'broken' in the 2.2.5 sources.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
