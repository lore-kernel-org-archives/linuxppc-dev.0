Date: Mon, 22 Mar 1999 11:36:52 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: swapping shadow screen data
Message-ID: <Pine.LNX.4.03.9903221132420.564-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Now all accesses to the shadow screen are done through scr_{read,write}w(), the
tests for conswitchp in include/asm-ppc/vga.h should be removed. Can someone
with both vgacon and fbcon in his/her kernel please verify that both vgacon and
fbcon keep on working?

Thx!

--- vger.rutgers.edu/include/asm-ppc/vga.h.orig	Wed Mar 10 16:14:59 1999
+++ vger.rutgers.edu/include/asm-ppc/vga.h	Mon Mar 22 11:36:18 1999
@@ -17,29 +17,12 @@
 
 extern inline void scr_writew(u16 val, u16 *addr)
 {
-	/* If using vgacon (not fbcon) byteswap the writes.
-	 * If non-vgacon assume fbcon and don't byteswap
-	 * just like include/linux/vt_buffer.h.
-	 * XXX: this is a performance loss so get rid of it
-	 *      as soon as fbcon works on prep.
-	 * -- Cort
-	 */
-#ifdef CONFIG_FB
-	if ( conswitchp != &vga_con )
-		(*(addr) = (val));
-	else
-#endif /* CONFIG_FB */
-		st_le16(addr, val);
+	st_le16(addr, val);
 }
 
 extern inline u16 scr_readw(const u16 *addr)
 {
-#ifdef CONFIG_FB
-	if ( conswitchp != &vga_con )
-		return (*(addr));
-	else
-#endif /* CONFIG_FB */
-		return ld_le16((unsigned short *)addr);
+	return ld_le16((unsigned short *)addr);
 }
 
 #define VT_BUF_HAVE_MEMCPYF

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
