Message-ID: <3B37189D7A56D511B404000629EE15D8437730@4rf_nz.local.4rf.com>
From: Richard Laing <Richard.Laing@4rf.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: bi_record and initrd
Date: Thu, 28 Nov 2002 10:00:41 +1300
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The following is a diff context patch for misc-embedded.c, it fixes a
problem where the initrd ramdisk image is corrupted during the boot process.
It is based on the untested patch from Tom Rini for misc-simple.c. The patch
corrects a bug in the Tom's original patch. The patch is against the current
linuxppc_2_4_devel branch. The only change from the original patch the
memcpy line

memcpy((void *)initrd_loc, &__ramdisk_begin, initrd_size);

I have tested this patch with my build and it works fine...

Cheers
Richard


*** arch/ppc/boot/simple/old.c	2002-11-28 09:00:08.000000000 +1300
--- arch/ppc/boot/simple/misc-embedded.c	2002-11-28
09:50:21.000000000 +1300
***************
*** 83,88 ****
--- 83,89 ----
  	char *cp, ch;
  	int timer = 0, zimage_size;
  	unsigned long initrd_size;
+ 	unsigned long initrd_loc;

  	/* First, capture the embedded board information.  Then
  	 * initialize the serial console port.
***************
*** 145,150 ****
--- 146,162 ----
  		puts("initrd at:     ");
  		puthex((unsigned long)(&__ramdisk_begin));
  		puts(" "); puthex((unsigned
long)(&__ramdisk_end));puts("\n");
+
+ 		if ((_ALIGN((unsigned long)(zimage_size) + (1 << 20) - 1,
+ 			(1 << 20))) <= (unsigned long)(&__ramdisk_end)) {
+ 			initrd_loc = _ALIGN((unsigned long)(initrd_size) +(2
<< 20) - 1, (2 << 20));
+ 			 memcpy((void *)initrd_loc, &__ramdisk_begin,
initrd_size);
+ 			 puts("relocated to:  "); puthex(initrd_loc);
+ 			 puts(" "); puthex(initrd_loc + initrd_size);
+ 			 puts("\n");
+ 		} else {
+ 			initrd_loc = (unsigned long)(&__ramdisk_begin);
+ 	        }
  	}

  	/*
***************
*** 225,231 ****

  		if ( initrd_size ) {
  			rec->tag = BI_INITRD;
! 			rec->data[0] = (unsigned long)(&__ramdisk_begin);
  			rec->data[1] = initrd_size;
  			rec->size = sizeof(struct bi_record) + 2 *
  				sizeof(unsigned long);
--- 237,243 ----

  		if ( initrd_size ) {
  			rec->tag = BI_INITRD;
! 			rec->data[0] = initrd_loc;
  			rec->data[1] = initrd_size;
  			rec->size = sizeof(struct bi_record) + 2 *
  				sizeof(unsigned long);


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
