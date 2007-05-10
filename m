Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1D26DDED5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 May 2007 18:45:15 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Hm4Gr-0003Pl-DF
	for linuxppc-embedded@ozlabs.org; Thu, 10 May 2007 01:45:09 -0700
Message-ID: <10409434.post@talk.nabble.com>
Date: Thu, 10 May 2007 01:45:09 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: RE: zImage.elf loads but does not start
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A207@MERCURY.inside.istor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10079346.post@talk.nabble.com> <10142161.post@talk.nabble.com>
	<406A31B117F2734987636D6CCC93EE3C0159BAAE@ehost011-3.exch011.intermedia.net>
	<10165159.post@talk.nabble.com> <10323147.post@talk.nabble.com>
	<463B5422.6030105@ru.mvista.com> <10372619.post@talk.nabble.com>
	<406A31B117F2734987636D6CCC93EE3C017019FD@ehost011-3.exch011.intermedia.net>
	<4640F08E.5040608@nec.com.au>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C06A207@MERCURY.inside.istor.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thank you for all of the advices.
I did more study on that problem but still without the success.

1. I did redd the ELDK manual and I have invoked :
ELDK_FIXOWNER
ELDK_MAKEDEV

in the "dev" directory there were created many nodes like that:

crw-rw-rw-    1 root     root       5,   1 May  8 15:42 console
crw-rw-rw-    1 root     root       4,  64 May  8 15:42 ttyS0

In the kernel command line configuration I have the entry :
CONFIG_CMDLINE="console=ttyUL0,9600 root=/dev/nfs rw nfsroo ...

so I have created by hand the node:
crw-rw-rw-    1 root     root     204, 187 May  8 15:44 ttyUL0

Unfortunately the kernel boots to the point:

[    9.130834] Looking up port of RPC 100003/2 on 129.129.130.106
[    9.207363] Looking up port of RPC 100005/1 on 129.129.130.106
[    9.303794] VFS: Mounted root (nfs filesystem).
[    9.359316] Freeing unused kernel memory: 96k init

and after that it hangs.

I have made some modifications to the kernel init/main.c file. In that file
I have inserted the printk statements to
see how far the kernel goes. It seems to be that the last thing it does it
executes the sbin/init command and it hangs.

Instead of the sbin/init I have tried to execute other commands like
bin/echo this_is_text_string
and bin/echo this_is_test >> /var/log/messages

the modification looks like (init/main.c):
before modification:
        printk("test 3\n");
        run_init_process("/sbin/init");
        printk("test 4\n");
after modification
        printk("test 3\n");
        run_init_process("/bin/echo ala");
        run_init_process("/bin/echo buba >> /var/log/messages");
        printk("test 4\n");



In both cases the last thing which was printed is "test 3"
The /var/log/messages remains empty.

I thought that it might be the uart_lite driver is the source of the
problem. I rebuild the kernel configuring it for the
standard UART driver instead of the uart_lite.
This time my command line looks like:
CONFIG_CMDLINE="console=ttyS0,9600 root=/dev/nfs rw nfsroo ...

When booting the kernel configured with the UART  I see anything printed  
on the screen so it is even worse than before.

Do you have any suggestions.

Best Regards

Mirek



Charles Krinke wrote:
> 
> I find this usually happens when /dev/tty, /dev/console or /dev/ttyS0
> are not setup properly. That is, they are files instead of nodes. This
> menas you have mounted the root filesystem and init is running on that
> root filesystem.
> 
> Charles
> 
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces+ckrinke=istor.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+ckrinke=istor.com@ozlabs.org] On
> Behalf Of Adrian Craine
> Sent: Tuesday, May 08, 2007 2:50 PM
> To: Leonid
> Cc: linuxppc-embedded@ozlabs.org; Mirek23
> Subject: Re: zImage.elf loads but does not start
> 
> Leonid wrote:
>> rootpath=
>> [    9.130834] Looking up port of RPC 100003/2 on 129.129.130.106
>> [    9.207363] Looking up port of RPC 100005/1 on 129.129.130.106
>> [    9.303794] VFS: Mounted root (nfs filesystem).
>> [    9.359316] Freeing unused kernel memory: 96k init
>> [    9.422162] Warning: unable to open an initial console.
>>
>>   
> The exact device node this requires is /dev/console c 5 1
> That should solve your issue.
> 
> Cheers,
>              Adrian.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/zImage.elf-loads-but-not-starts-tf3607582.html#a10409434
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
