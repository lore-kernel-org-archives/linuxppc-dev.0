Date: Sat, 20 Mar 1999 23:28:25 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Matroxfb, PReP, and ioremap
In-Reply-To: <v04003a01b319eec4b201@[205.161.35.44]>
Message-ID: <Pine.LNX.4.04.9903202254250.413-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It seems as though ioremap has been partially or completely broken on PReP
for awhile, and I'm thinking now would be a good time to fix it nicely,
with the rework of the machine dependent code. Any suggestions how to do
this without breaking other drivers?

With the following patches to Matroxfb, I now get the dual penguins on my
MTX board on bootup ;)

This only works since the PCI code reports the PCI memory space at
0xC0000000, and this space is mapped to 0xD0000000 on PReP. (thus the
phys+ 0x10000000)

[hozer@kalmia video]$ cvs diff -u matroxfb.c
Index: matroxfb.c
===================================================================
RCS file: /cvsroot/linux/drivers/video/matroxfb.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 matroxfb.c
--- matroxfb.c  1999/03/10 19:38:29     1.1.1.6
+++ matroxfb.c  1999/03/20 22:50:50
@@ -187,7 +187,7 @@
 #if defined(CONFIG_PPC) && defined(CONFIG_PREP) && defined(_ISA_MEM_BASE)
 /* do not tell me that PPC is not broken... if ioremap() oops with
    invalid value written to msr... */
-#define MAP_ISAMEMBASE
+#define MAP_BOGUS
 #else
 #define MAP_IOREMAP
 #endif
@@ -351,11 +351,9 @@
 #ifdef MAP_BUSTOVIRT
        virt->vaddr = bus_to_virt(phys);
 #else
-#ifdef MAP_ISAMEMBASE
-       virt->vaddr = (void*)(phys + _ISA_MEM_BASE);
-#else
-#error "Your architecture does not have neither ioremap nor
bus_to_virt... Givi
ng up"
-#endif
+       virt->vaddr = phys+0x10000000; /* cheap hack */
+#warning "Cheap hack for my MTX and Millenium I"
+/*#error "Your architecture does not have neither ioremap nor
bus_to_virt... Gi
ving up"*/
 #endif
 #endif
        return (virt->vaddr == 0); /* 0, !0... 0, error_code in future */

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
