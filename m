Return-Path: <martin@egholm-nielsen.dk>
Received: from softscan.infopaq.dk (softscan.infopaq.dk [213.150.59.22])
	by ozlabs.org (Postfix) with SMTP id 4812167A46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 05:37:44 +1000 (EST)
Received: from unknown (HELO [192.168.0.3]) ([212.242.189.63])
	(envelope-sender <martin@egholm-nielsen.dk>)
	by mail.freepaq.dk (qmail-ldap-1.03) with SMTP
	for <linuxppc-embedded@ozlabs.org>; 29 Mar 2005 19:31:07 -0000
Message-ID: <4249ACF1.60305@egholm-nielsen.dk>
Date: Tue, 29 Mar 2005 21:30:57 +0200
From: Martin Egholm Nielsen <martin@egholm-nielsen.dk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Overcommit (OOM) problem on embedded device (PPChameleon)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi there,

I hope this is the place to go...

I have a some problems figuring out the OOM-killer and configuring the
overcommit_memory parameter. Hope someone here can guide me in the right
directions...

Specs:
I'm having an embedded Linux system running on a PPC405EP (PPChameleon)
with 64 megs of RAM, some flash, but (ofcourse) no swap space. It runs a
2.4.20 kernel patched with drivers for my device.

Problem:
I have an application that is killed by the OOM (I guess) when it tries
to "use" more memory than present on the system.
Bolied down, memory is allocated with "sbrk" and then touch'ed (see
test-application below).

With "/proc/sys/vm/overcommit_memory" set to 2, I expected that "sbrk"
would return "-1L" (0xFFFFFFFF), but it doesn't, hence is
terminated/killed by the kernel.

However, both my desktop Linux (RH 7.3)/2.4.18-10/i386 and Linux
(FC2)/2.6.5/i386 did what I expected:

# ./exhaust_mem
...
ffffffff

Out of memory
# #Yeaaaah!

Having searched the web, I see that this may be related with the fact
that there is no swap enabled on the embedded device.
However, I tried disabling the swap (commented in fstab), but the
desktop linux still behaves "correct".

Can I do anything in order to get it the way I expected?

Best regards,
  Martin Egholm

=== exhaust_mem.c ===

#include <unistd.h>
#include <stdio.h>
#define SIZE 1000000

int main( int i )
{
   while ( 1 ) {
     char *v = sbrk( SIZE );
     char *p;

     printf( "%x\n\n", v );

     if ((long)v < 0) {
       fprintf(stderr, "Out of memory\n");
       exit(1);
     } // if

     for (p = v; p < v + SIZE; ++p) {
       *p = 42;
     } // for

   } // while
} // main
