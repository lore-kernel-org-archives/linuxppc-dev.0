Return-Path: <per.hallsmark@t2data.se>
Received: from t2data.se (unknown [212.247.174.226])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7938167A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 20:42:30 +1000 (EST)
Received: from webmail ([192.168.1.7])
	by t2data.se (mail.t2data.se [172.16.0.3])
	(Cipher SSLv3:RC4-MD5:128) (MDaemon.PRO.v7.2.3.R)
	with ESMTP id md50000122449.msg
	for <linuxppc-embedded@ozlabs.org>; Wed, 30 Mar 2005 12:30:46 +0200
Date: Wed, 30 Mar 2005 12:30:43 +0200
Sender: Per Hallsmark <per.hallsmark@t2data.se>
From: Per Hallsmark <per.hallsmark@t2data.se>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	Martin Egholm Nielsen <martin@egholm-nielsen.dk>
Message-ID: <42416091@webmail>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Subject: RE: Overcommit (OOM) problem on embedded device (PPChameleon)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I think your main problem is that the stock 2.4.x kernel doesn't support
ovecommit_memory type 2 (i believe)...
Look in mm/mmap.c and search for overcommit_memory, then do same
in the sources for your redhat kernels.

Perhaps there's a patch for it floating around somewhere? ;-)

>===== Original Message From Martin Egholm Nielsen <martin@egholm-nielsen.dk> 
=====
>Hi there,
>
>I hope this is the place to go...
>
>I have a some problems figuring out the OOM-killer and configuring the
>overcommit_memory parameter. Hope someone here can guide me in the right
>directions...
>
>Specs:
>I'm having an embedded Linux system running on a PPC405EP (PPChameleon)
>with 64 megs of RAM, some flash, but (ofcourse) no swap space. It runs a
>2.4.20 kernel patched with drivers for my device.
>
>Problem:
>I have an application that is killed by the OOM (I guess) when it tries
>to "use" more memory than present on the system.
>Bolied down, memory is allocated with "sbrk" and then touch'ed (see
>test-application below).
>
>With "/proc/sys/vm/overcommit_memory" set to 2, I expected that "sbrk"
>would return "-1L" (0xFFFFFFFF), but it doesn't, hence is
>terminated/killed by the kernel.
>
>However, both my desktop Linux (RH 7.3)/2.4.18-10/i386 and Linux
>(FC2)/2.6.5/i386 did what I expected:
>
># ./exhaust_mem
>...
>ffffffff
>
>Out of memory
># #Yeaaaah!
>
>Having searched the web, I see that this may be related with the fact
>that there is no swap enabled on the embedded device.
>However, I tried disabling the swap (commented in fstab), but the
>desktop linux still behaves "correct".
>
>Can I do anything in order to get it the way I expected?
>
>Best regards,
>  Martin Egholm
>
>=== exhaust_mem.c ===
>
>#include <unistd.h>
>#include <stdio.h>
>#define SIZE 1000000
>
>int main( int i )
>{
>   while ( 1 ) {
>     char *v = sbrk( SIZE );
>     char *p;
>
>     printf( "%x\n\n", v );
>
>     if ((long)v < 0) {
>       fprintf(stderr, "Out of memory\n");
>       exit(1);
>     } // if
>
>     for (p = v; p < v + SIZE; ++p) {
>       *p = 42;
>     } // for
>
>   } // while
>} // main
>
>
>
>
>
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
