Message-ID: <3819E280.43C05759@mvista.com>
Date: Fri, 29 Oct 1999 11:08:00 -0700
From: Christian Zankel <chris@mvista.com>
MIME-Version: 1.0
To: Matt Porter <mporter@eng.mcd.mot.com>,
        Simone Piccardi <Simone.Piccardi@fi.infn.it>
CC: linuxppc-dev@lists.linuxppc.org
Subject: BUGboot 0.2 Patch
References: <19990930134513.C25664@fwrsl-11.phx.mcd.mot.com> <3802668E.C5A6BAC6@fi.infn.it> <19991014094024.A568@fwrsl-11.phx.mcd.mot.com>
Content-Type: multipart/mixed;
 boundary="------------8F760555019F12E23FE9E8FC"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------8F760555019F12E23FE9E8FC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Matt,
Hi Simone,

Matt Porter wrote:
> 
> On Tue, Oct 12, 1999 at 12:37:03AM +0200, Simone Piccardi wrote:
> > Hi Matt,
> >
> > I'm trying your bugboot but I have some problem. I went through your
> > readme, and these are the steps that I did.
> >
> 
> Since I posted 0.2 I've been able to produce this problem with certain
> board/zImage combinations.  This fell down my list of priorities a little
> bit for the short term, but I will fix the problems and make a working
> 0.3 version available ASAP.

Enclosed you will find a patch that made bugboot work for me. You can
also use a  little-endian machine to build it if you have the apropriate
cross-compiling tools.

Ups.. I forgot to change the README file:
RESDATA_DEST and RESDATA_SIZE are now in romboot.S and ZIMAGE_SIZE is
now called KERNEL_IMAGE (in Makefile). 

Greetings,
Christian

--
Christian Zankel			MontaVista Software, Inc.
chris@mvista.com			+1 408-328-9211
--------------8F760555019F12E23FE9E8FC
Content-Type: text/plain; charset=us-ascii;
 name="bugboot-0.2.diff"
Content-Disposition: inline;
 filename="bugboot-0.2.diff"
Content-Transfer-Encoding: 7bit

diff -c bugboot-0.2/Makefile bugboot-0.2.1/Makefile
*** bugboot-0.2/Makefile	Thu Sep 30 13:15:17 1999
--- bugboot-0.2.1/Makefile	Fri Oct 29 10:44:49 1999
***************
*** 10,18 ****
  CFLAGS=-c
  OBJCOPY=$(CROSS_COMPILE)objcopy
  
! ZIMAGE_SIZE=602426
! RESDATA_DEST=0x1f78000
! RESDATA_SIZE=0x6a0c
  
  all: bugboot.bin
  
--- 10,16 ----
  CFLAGS=-c
  OBJCOPY=$(CROSS_COMPILE)objcopy
  
! ZIMAGE_SIZE=587399
  
  all: bugboot.bin
  
***************
*** 24,32 ****
  
  romboot.o: romboot.S
  	$(CC) $(CFLAGS) \
! 	-DZIMAGE_SIZE=`wc -c <kernel_image | sed "s: ::g"` \
! 	-DRESDATA_DEST=RESDATA_DEST \
! 	-DRESDATA_SIZE=RESDATA_SIZE \
  	-o romboot.o romboot.S
  
  mkbugboot: mkbugboot.c
--- 22,28 ----
  
  romboot.o: romboot.S
  	$(CC) $(CFLAGS) \
! 	-DKERNEL_IMAGE=`wc -c <kernel_image | sed "s: ::g"` \
  	-o romboot.o romboot.S
  
  mkbugboot: mkbugboot.c
Only in bugboot-0.2.1: kernel_image
diff -c bugboot-0.2/mkbugboot.c bugboot-0.2.1/mkbugboot.c
*** bugboot-0.2/mkbugboot.c	Thu Sep 30 11:44:09 1999
--- bugboot-0.2.1/mkbugboot.c	Fri Oct 29 10:47:48 1999
***************
*** 17,22 ****
--- 17,30 ----
  #include <errno.h>
  #include <fcntl.h>
  
+ // ON LITTLE ENDIAN MACHINES:
+ 
+ #ifdef LITTLE_ENDIAN
+ #define cpu_to_be32(x) le32_to_cpu(x)
+ #else
+ #define cpu_to_be32(x) (x)
+ #endif
+ 
  #define cpu_to_le32(x) le32_to_cpu((x))
  unsigned long le32_to_cpu(unsigned long x)
  {
***************
*** 162,169 ****
  
    /* Fill in the PPCBUG ROM boot header */
    strncpy(bbh->magic_word, "BOOT", 4);			/* PPCBUG magic word */
!   bbh->entry_offset	= header_size;			/* Entry address */
!   bbh->routine_length	= MAX_BOOT_SIZE+boot_size+2;	/* Routine length */
    strncpy(bbh->routine_name, "LINUXROM", 8);		/* Routine name   */
  
    /* Output the header and bootloader to the file */
--- 170,177 ----
  
    /* Fill in the PPCBUG ROM boot header */
    strncpy(bbh->magic_word, "BOOT", 4);			/* PPCBUG magic word */
!   bbh->entry_offset	= cpu_to_be32(header_size);			/* Entry address */
!   bbh->routine_length	= cpu_to_be32(MAX_BOOT_SIZE+boot_size+2);	/* Routine length */
    strncpy(bbh->routine_name, "LINUXROM", 8);		/* Routine name   */
  
    /* Output the header and bootloader to the file */
***************
*** 185,191 ****
      }
  
    /* BUG romboot requires that our size is divisible by 2 */
!   if (image_size % 2)
      {
      image_size++;
      write(out_fd, &zero, 1);
--- 193,200 ----
      }
  
    /* BUG romboot requires that our size is divisible by 2 */
!   /* align image to 4 byte boundary */
!   if (image_size % 4)
      {
      image_size++;
      write(out_fd, &zero, 1);
Only in bugboot-0.2.1: mkbugboot.c.orig
Only in bugboot-0.2.1: res_data
diff -c bugboot-0.2/romboot.S bugboot-0.2.1/romboot.S
*** bugboot-0.2/romboot.S	Thu Sep 30 12:05:14 1999
--- bugboot-0.2.1/romboot.S	Fri Oct 29 10:48:17 1999
***************
*** 5,51 ****
   */
  #include "ppc_asm.tmpl"
  
  #define ZIMAGE_START	0xff000100
  #define ZIMAGE_DEST	0x00005000
- #define BOOT_VECTOR	ZIMAGE_DEST + 0x400
- #define RESDATA_START	ZIMAGE_START + ZIMAGE_SIZE
  
  .text
  
  /*	.globl	main */
  
  kernel:
! 	lis	r9,ZIMAGE_START@h	/* Get pointer to top of zImage */
! 	ori	r9,r9,ZIMAGE_START@l	/* Bootloader starts immediately */
  	
! 	lis	r11,ZIMAGE_SIZE@h	/* Set zImage size */
! 	ori	r11,r11,ZIMAGE_SIZE@l
  
! 	lis	r12,ZIMAGE_DEST@h	/* Setup destination address for */
! 	ori	r12,r12,ZIMAGE_DEST@l	/* zImage in RAM		 */
  
  	mtctr	r11			/* Setup the counter */
- 	li	r13,0
  copy1:	lwzu	r11,4(r9)		/* Load a word in and increment */
  	stwu	r11,4(r12)		/* Store a word out and increment */
- 	xor	r13,r13,r11		/* Decrement and repeat until counter */
  	bdnz	copy1			/* is 0 */
  
  resdata:
!         lis     r9,RESDATA_START@h      /* Set top of resdata */
!         ori     r9,r9,RESDATA_START@l 
   
!         lis     r11,RESDATA_SIZE@h      /* Set resdata size */
!         ori     r11,r11,RESDATA_SIZE@l
   
!         lis     r12,RESDATA_DEST@h      /* Set destination address for */
!         ori     r12,r12,RESDATA_DEST@l  /* resdata in RAM                 */
   
          mtctr   r11                     /* Setup the counter */
-         li      r13,0
  copy2:  lwzu    r11,4(r9)               /* Load a word in and increment */
          stwu    r11,4(r12)              /* Store a word out and increment */
-         xor     r13,r13,r11             /* Decrement and repeat until counter */
          bdnz    copy2                   /* is 0 */
  
          lis     r3,RESDATA_DEST@h       /* Set pointer to resdata in R3 */
--- 5,52 ----
   */
  #include "ppc_asm.tmpl"
  
+ #define RESDATA_DEST    0x7f88000
+ #define RESDATA_SIZE    0x6a0c
+  
  #define ZIMAGE_START	0xff000100
  #define ZIMAGE_DEST	0x00005000
  
+ #define ZIMAGE_SIZE	(KERNEL_IMAGE + 3) & (~3)
+ #define BOOT_VECTOR	ZIMAGE_DEST + 0x400 
+ #define RESDATA_START	ZIMAGE_START + ZIMAGE_SIZE
+  
  .text
  
  /*	.globl	main */
  
  kernel:
! 	lis	r9,(ZIMAGE_START-4)@h	/* Get pointer to top of zImage */
! 	ori	r9,r9,(ZIMAGE_START-4)@l/* Bootloader starts immediately */
  	
! 	lis	r11,(ZIMAGE_SIZE+3)/4@h	/* Set zImage size (number of words) */
! 	ori	r11,r11,(ZIMAGE_SIZE+3)/4@l
  
! 	lis	r12,(ZIMAGE_DEST-4)@h	/* Setup destination address for */
! 	ori	r12,r12,(ZIMAGE_DEST-4)@l	/* zImage in RAM		 */
  
  	mtctr	r11			/* Setup the counter */
  copy1:	lwzu	r11,4(r9)		/* Load a word in and increment */
  	stwu	r11,4(r12)		/* Store a word out and increment */
  	bdnz	copy1			/* is 0 */
  
  resdata:
!         lis     r9,(RESDATA_START-4)@h      /* Set top of resdata */
!         ori     r9,r9,(RESDATA_START-4)@l 
   
!         lis     r11,(RESDATA_SIZE+3)/4@h      /* Set resdata size */
!         ori     r11,r11,(RESDATA_SIZE+3)/4@l
   
!         lis     r12,(RESDATA_DEST-4)@h      /* Set destination address for */
!         ori     r12,r12,(RESDATA_DEST-4)@l  /* resdata in RAM                 */
   
          mtctr   r11                     /* Setup the counter */
  copy2:  lwzu    r11,4(r9)               /* Load a word in and increment */
          stwu    r11,4(r12)              /* Store a word out and increment */
          bdnz    copy2                   /* is 0 */
  
          lis     r3,RESDATA_DEST@h       /* Set pointer to resdata in R3 */

--------------8F760555019F12E23FE9E8FC--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
