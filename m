From: Wulf Hofbauer <wh@echo.chem.tu-berlin.de>
Subject: yet another bug in atyfb.c
To: linuxppc-dev@lists.linuxppc.org
Date: Tue, 3 Aug 99 12:21:54 MESZ
Message-Id: <E11BbjL-0004vi-00@mail.zrz.tu-berlin.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


ABSTRACT: atyfb.c doesn't work when compiled with gcc-2.95 due to incorrect
inline assembly code.

EXPLANATION: atyfb.c - as of Kernel 2.2.10 - uses the following constructs
for accessing little-endian words in Mach32 controller space:

    asm("lwbrx %0,%1,%2" : "=r"(val) : "r" (regindex), "r" (temp));

and

    asm("stwbrx %0,%1,%2" : : "r" (val), "r" (regindex), "r" (temp) :
        "memory");

This is meant to access a word at address regindex+temp. If regindex
happens to be held in register r0, the address calculation is off as
r0 is defined as a null operand. This problem shows up with gcc-2.95 which
seems to use better register allocation code and _does_ keep regindex in
r0 at times.

The way of how the respective functions aty_ld_le32 and aty_st_le32
seems also strange to me, and I suspect it is incorrect.

Here's a proposed fix that works for me. I also changed the sparc code
to honour volatility of IO space, but couldn't check if this affects
the kernel. It would be nice if someone familiar with sparc could have a
look at this.

Here's the fix:

--- atyfb.c.orig        Wed Jul 21 00:04:40 1999
+++ atyfb.c     Tue Aug  3 12:13:42 1999
@@ -466,18 +466,18 @@
 };
 
 
-static inline u32 aty_ld_le32(volatile unsigned int regindex,
+static inline u32 aty_ld_le32(unsigned int regindex,
                              const struct fb_info_aty *info)
 {
     unsigned long temp;
     u32 val;
 
 #if defined(__powerpc__)
-    temp = info->ati_regbase;
-    asm("lwbrx %0,%1,%2" : "=r"(val) : "r" (regindex), "r" (temp));
+    temp = info->ati_regbase+regindex;
+    asm("lwbrx %0,0,%1" : "=r" (val) : "r" ((volatile u32*)temp), "m" (*(volatile u32*)temp));
 #elif defined(__sparc_v9__)
     temp = info->ati_regbase + regindex;
-    asm("lduwa [%1] %2, %0" : "=r" (val) : "r" (temp), "i" (ASI_PL));
+    asm("lduwa [%1] %2, %0" : "=r" (val) : "r" ((volatile u32*)temp), "i" (ASI_PL));
 #else
     temp = info->ati_regbase+regindex;
     val = le32_to_cpu(*((volatile u32 *)(temp)));
@@ -485,18 +485,17 @@
     return val;
 }
 
-static inline void aty_st_le32(volatile unsigned int regindex, u32 val,
+static inline void aty_st_le32(unsigned int regindex, u32 val,
                               const struct fb_info_aty *info)
 {
     unsigned long temp;
 
 #if defined(__powerpc__)
-    temp = info->ati_regbase;
-    asm("stwbrx %0,%1,%2" : : "r" (val), "r" (regindex), "r" (temp) :
-       "memory");
+    temp = info->ati_regbase+regindex;
+    asm("stwbrx %1,0,%2" : "=m" (*(volatile u32*)temp) : "r" (val) , "r" ((volatile u32*)temp));
 #elif defined(__sparc_v9__)
     temp = info->ati_regbase + regindex;
-    asm("stwa %0, [%1] %2" : : "r" (val), "r" (temp), "i" (ASI_PL) : "memory");
+    asm("stwa %0, [%1] %2" : : "r" (val), "r" ((volatile u32*)temp), "i" (ASI_PL) : "memory");
 #else
     temp = info->ati_regbase+regindex;
     *((volatile u32 *)(temp)) = cpu_to_le32(val);


- Wulf

--
 ________________________________________________________
! Dipl. Phys. Wulf Hofbauer  (wh@echo.chem.tu-berlin.de) !
! Max-Volmer-Institut     Technische Universitaet Berlin !
! Strasse des 17. Juni 135     10623 Berlin      Germany !
!________________________________________________________!

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
