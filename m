Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3B41F1F8.C88E0460@laposte.net>
Date: Tue, 03 Jul 2001 16:25:28 +0000
From: ibm405gp <ibm405.linux@laposte.net>
MIME-Version: 1.0
To: Scott Anderson <scott_anderson@mvista.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ?Loading and debugging a linux kernel on a walnut board with a
 BDI2000
References: <B25E2E5A003CD311B61E00902778AF2A02637685@SERVER1> <3B409EE3.9CFCD22B@laposte.net> <3B409FE6.783C46A6@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You're right,the "mkevimg" perl script suppressed the ELF header and
replace it by a
specific header for the IBM rom monitor.
I use the temporary file "zImage.tree.out" generated in the Makefile and
the format is now OK
but the boot sequence fails, the zImage is not extracted
In arch/ppc/boot/tree/main.c, i put some debug printf, and i have
"Memcopy Done " instead of "gunzip done"
What means the condition "if (im[0] == 0x1f && im[1] == 0x8b) " ?
It seems the "imageSect_start" is not set but this global variable is
assign by the "mkirimg" perl script in the Makefile :

// Makefile :

../utils/mkirimg -v treeboot.image treeboot.image.out irSectStart.txt
String table section header offset: 0xbf874
Section name strings start at: 0xbf6ea, 74 bytes.
Data section   - Address: 0x00406000, Size: 0x00000404, File Offset
0x00016000
Bss  section   - Address: 0x00406404, Size: 0x000012f4, File Offset
0x00016404
Image section  - Address: 0x00000000, Size: 0x000a6bf9
Initrd section not found in file: treeboot.image
irSectStartOffset Address: 0x004063d4
Updated symbol "imageSect_start" to 0x004076f8
Updated symbol "imageSect_size" to 0x000a6bf9


// arch/ppc/boot/tree/main.c

    /* Linux kernel image section */

    kick_watchdog();

    im = (unsigned char *)(imageSect_start);
    len = imageSect_size;
    dst = (void *)PROG_START;

    /* Check for the gzip archive magic numbers */

    if (im[0] == 0x1f && im[1] == 0x8b) {

        /* The gunzip routine needs everything nice and aligned */

	void *cp = (void *)ALIGN_UP(RAM_FREE, 8);
	avail_ram = (void *)(cp + ALIGN_UP(len, 8));	/* used by zalloc() */
	memcpy(cp, im, len);

	/* I'm not sure what the 0x200000 parameter is for, but it works. */
	/* It tells gzip the size of the area you wish to copy into.
	** The boot image is loaded beyond this point - if you increase this
	** number, then be sure to increase the load address of treeboot.
	*/

	gunzip(dst, 0x400000, cp, (int *)&len);
	printf("\n-----  Gunzip Done     --------\n\n");
    } else {
	memcpy(dst, im, len);
	printf("\n-----  MemCopy Done     --------\n\n");
    }




Scott Anderson a écrit :
>
> ibm405gp wrote:
> > My "vmlinuz-walnut" file generated with "make zImage" (with mvista
> > toolschain) seems invalid for
> > the bdi2000 but it works fine with 1.15 ROM Monitor
>
> It's been a while since I played with it, but as I recall the makefile
> tacks on a header to create an IBM Evaluation Board image.  To figure
> out what it is doing, you might want to look in
> arch/ppc/boot/tree/Makefile for something called mkevimg.
>
>     Scott Anderson
>     scott_anderson@mvista.com   MontaVista Software Inc.
>     (408)328-9214               1237 East Arques Ave.
>     http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
