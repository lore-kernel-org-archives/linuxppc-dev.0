Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09422DDEF1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 01:52:24 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1I8I0j-0003SD-Ka
	for linuxppc-embedded@ozlabs.org; Tue, 10 Jul 2007 08:52:21 -0700
Message-ID: <11523745.post@talk.nabble.com>
Date: Tue, 10 Jul 2007 08:52:20 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: xilinx gpio in kernel 2.6
In-Reply-To: <10285090.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10254948.post@talk.nabble.com> <10285090.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi All,

 After some time I have found the way how to deal with GPIO driver from the
user space:

First you have to mknod xgpio under /dev :
crw-rw-rw-    1 root     root      10, 185 Jun  1 13:59 /dev/xgpio

Example program below shows how to read from the GPIO channel.
To write to the channel change the call:
ioctl(fgpio,XGPIO_IN,&sGpioData); to ioctl(fgpio,XGPIO_OUT,&sGpioData);

#include <stdlib.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <fcntl.h>

#include <linux/xgpio_ioctl.h>


main(){


  int fgpio =0;
  struct xgpio_ioctl_data sGpioData;
    /* {
        __u32 device;
        __u32 mask;
        __u32 data;
        }*/

  sGpioData.device=0; /* N=0,1,2,3-> GPIO DEV NR   2*N   (Lower 32 bit part
)
                                                   2*N+1 (Upper 32 bit part
)*/
  sGpioData.mask=0xffffffff;
  sGpioData.data=0x55555555;

fgpio = open ("/dev/xgpio",O_RDWR);
 if( fgpio != -1){

   ioctl(fgpio,XGPIO_IN,&sGpioData);//pointer here to  xgpio_ioctl_data
   printf("Dip Swich readout 0x%X\n",sGpioData.data);
 }
 else
   printf("Can not open GPIO\n");

 close(fgpio);
}// end main












 



-- 
View this message in context: http://www.nabble.com/xilinx-gpio-in-kernel-2.6-tf3670122.html#a11523745
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
