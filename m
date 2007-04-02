Return-Path: <kryn@in2p3.fr>
Received: from ccimap.in2p3.fr (ccimap.in2p3.fr [134.158.69.6])
	by ozlabs.org (Postfix) with ESMTP id 09405DDF31
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 Apr 2007 19:21:20 +1000 (EST)
Message-ID: <4610CB0C.4070406@in2p3.fr>
Date: Mon, 02 Apr 2007 11:21:16 +0200
From: Didier Kryn <kryn@in2p3.fr>
MIME-Version: 1.0
To: Didier Kryn <kryn@in2p3.fr>
Subject: Re: Reading and writing from/to VME device
References: <821B2170E9E7F04FA38DF7EC21DE4871088C81DA@VCAEXCH01.hq.corp.viasat.com>	<460A3BBC.5060002@in2p3.fr>	<929bf310703290313o234a47f9gbf9c5083fc23e45e@mail.gmail.com>	<460CD765.2060905@in2p3.fr>
	<4610C999.5080405@in2p3.fr>
In-Reply-To: <4610C999.5080405@in2p3.fr>
Content-Type: multipart/mixed; boundary="------------060203020503040900000100"
Cc: Konstantin Boyanov <kkboyanov@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060203020503040900000100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Didier Kryn a =E9crit :
>     Konstantin, I reproduced your ioctl() problem with the attached=20
> program. The conclusion is that the only valid size and base parameters=
=20
> for A16 are windowSizeL=3D0x10000 and xlatedAddrL=3D0. This means the A=
16=20
> space can only be mapped as a whole. What you observed with =20
> xlatedAddrL=3D0x10100000 is that the ioctl(), gently masks the irreleva=
nt=20
> high order bits.
>
>     Best regards.
>     Didier
>  =20
    Oops! I forgot the attachment...

--------------060203020503040900000100
Content-Type: text/x-csrc;
 name="test148.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test148.c"

#include <linux/stddef.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include "vmedrv.h"

#if !defined(offsetof)
/* maybe defined (if <linux/stddef.h> included indirectly) */
# define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
#endif

int main(void)
{
   int vmepd, i;
   char *devname="/dev/vme/vme_out0";
   vmeOutWindowCfg_t a16d16 = {0,1,0,0,0,0x1000000,0,0,0,0,0,0,VME_SSTNONE,
                               VME_A16,VME_D16,VME_SCT,VME_SUPER,VME_DATA,0};
   unsigned size_max=0x10000;
   unsigned base, size;
   unsigned short *vmebus;


   vmepd = open(devname, O_RDWR);
   if(vmepd==-1)
     {
        perror(devname);
        return 1;
     }

   for( base=0 ;   (size = size_max - base) ;   base+=0x100 )
     {
        a16d16.xlatedAddrL = base;
        a16d16.windowSizeL = size;
        if(ioctl(vmepd, VME_IOCTL_SET_OUTBOUND, &a16d16))
          printf("ioctl failed for base %x, size %x: %s\n", base, size, strerror(errno));
        else
          printf("ioctl OK for base %x, size %x\n", base, size);
     }

   for( base=0, size=0x100 ;   size <= size_max ;  size+=0x100 )
     {
        a16d16.xlatedAddrL = base;
        a16d16.windowSizeL = size;
        if(ioctl(vmepd, VME_IOCTL_SET_OUTBOUND, &a16d16))
          printf("ioctl failed for base %x, size %x: %s\n", base, size, strerror(errno));
        else
          printf("ioctl OK for base %x, size %x\n", base, size);
     }

  close(vmepd);
}


--------------060203020503040900000100--
