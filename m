Return-Path: <arrigo@vision.caltech.edu>
Received: from kla-tencor.com (smtp.kla-tencor.com [192.146.1.134])
	by ozlabs.org (Postfix) with ESMTP id 02B282BF0C
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Nov 2004 06:27:11 +1100 (EST)
Message-ID: <418A827C.9090802@vision.caltech.edu>
Date: Thu, 04 Nov 2004 11:26:52 -0800
From: Arrigo Benedetti <arrigo@vision.caltech.edu>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
References: <4189888E.5070906@vision.caltech.edu> <418A35ED.3090400@gmx.net>
In-Reply-To: <418A35ED.3090400@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: Re: problem with insmod
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

evilninja wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Arrigo Benedetti schrieb:
>  
>
>>After some research I found that to load a module on the 2.6 kernel one
>>    
>>
>
>yes, http://www.linux.org.uk/~davej/docs/post-halloween-2.6.txt is a good
>start for 2.4 -> 2.6 upgrades.
>
>  
>
>>So I compile and install module-init-tools, but I get the same error.
>>Does anyone know what's going on?
>>    
>>
>
>hm, are you sure the new "insmod" and "modprobe" are the *right* ones?
>the PATH  variable will help here or try to specify the exact path on the
>cmd line. here i have:
>
>evil@prinz:~$ /sbin/modprobe -V
>module-init-tools version 3.1-pre6
>vil@prinz:~$ file /sbin/modprobe*
>/sbin/modprobe:           ELF 32-bit LSB executable, Intel 80386, [...]
>/sbin/modprobe.Lmodutils: symbolic link to `insmod'
>/sbin/modprobe.modutils:  symbolic link to `insmod.modutils'
>
>  
>

Yes, I have verified that. Someone has also suggested to check that the 
compiler used to build the module
is the same compiler that build the kernel. The Makefile is below and it 
seems that this is also ok.

-Arrigo

ifndef KERNELRELEASE
   
     LINUX ?= /usr/src/linux-2.6
     PWD := $(shell pwd)
     all:
	     $(MAKE) -C $(LINUX) SUBDIRS=$(PWD) modules
     clean:
	     rm -f *.o *.ko *~ core .depend *.mod.c *.cmd    
   
   else
     obj-m := empty.o

   endif
