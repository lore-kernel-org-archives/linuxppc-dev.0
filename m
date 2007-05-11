Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD319DDF09
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 May 2007 21:21:40 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1HmTBo-0000In-M5
	for linuxppc-embedded@ozlabs.org; Fri, 11 May 2007 04:21:36 -0700
Message-ID: <10429898.post@talk.nabble.com>
Date: Fri, 11 May 2007 04:21:36 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: RE: zImage.elf loads but does not start
In-Reply-To: <D1AFFAE2CC4BD54CA4C1543CFF4A4FCC2F391B@exchangemb3.bnl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10079346.post@talk.nabble.com> <10142161.post@talk.nabble.com>
	<406A31B117F2734987636D6CCC93EE3C0159BAAE@ehost011-3.exch011.intermedia.net>
	<10165159.post@talk.nabble.com> <10323147.post@talk.nabble.com>
	<463B5422.6030105@ru.mvista.com> <10372619.post@talk.nabble.com>
	<406A31B117F2734987636D6CCC93EE3C017019FD@ehost011-3.exch011.intermedia.net>
	<4640F08E.5040608@nec.com.au>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C06A207@MERCURY.inside.istor.com>
	<10409434.post@talk.nabble.com>
	<D1AFFAE2CC4BD54CA4C1543CFF4A4FCC2F391B@exchangemb3.bnl.gov>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Joe,

      Thank you very much for your e-mail. I did similar thing as you.
I have prepared simple init program to substitute one in /sbin :

#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
    char myStr[30];

    printf("Enter the string!\n");
    gets(myStr);
    printf("My string is %s\n",myStr);
    sleep(60);
}

When I booted the kernel I have got a prompted "Enter the string!"
I was also able to type from the keyboard the string.
When I pressed ENTER I have got "My string is <the string I have typed>"

It seems to be that the console works fine and the root file system is
mounted properly via NFS.
I do not however understand why eldk4.1 init does not work.

I have reinstalled the eldk4.1 but still kernel boots to the point when it
executes the init.

I have tried to build the busybox and i have it installed in the place of
/opt/eldk41/ppc_4xx .
I have added to the ppc_4xx directory the dev/console.

When I rebooted the kernel it said that init was not found. I made sure that
init was pointing to ../bin/busybox
I have even copied busybox binary in place of init to have init as a regular
file but each time kernel was complaining that init is missing. Strange :(

Would you or somebody else recommend me the way how to build the root file
system which I could use for my ppc board.

Best Regards

Mirek




Mead, Joseph wrote:
> 
> Hi Mirek,
> 
> I am facing the same exact problem.   I am using the ML403 with standard
> UART but using initramfs to generate the root file system.   My root
> file system contains the /dev/console node and a simple init file that
> basically just tries to print out something.   I can tell it is finding
> my /dev/console because I don't get the kernel warning : "Unable to open
> an initial console"   (If I remove the /dev/console node I get the
> warning) 
> 
> My init program is just a simple hello world program (built statically)
> 
> printf("Hello World")
> sleep(10)
> 
> I can tell that the program is running because after exactly 10seconds I
> get a kernel panic, which indicates the end of the program, however I
> can never see any messages from user space.
> 
> 
> I also tried a statically built version of busybox as my init file but
> still get no output.
> 
> 
> my filesystem is built from the following file (using initramfs
> functionality, which creates the root file system from this file)
> 
> dir /dev 755 0 0
> nod /dev/console 644 0 0 c 5 1
> nod /dev/ttyS0   644 0 0 c 4 64
> dir /proc 755 0 0
> dir /sys 755 0 0
> file /init usr/busybox 755 0 0
> 
> 
> I received one bit of information to check my interrrupt lines, but I
> see Grant replied that the serial console is polled, so the interrupt
> line is probably not the problem.
> 
> 
> Please let me know if you make any progress...
> Joe
> 
> 
>  
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces+mead=bnl.gov@ozlabs.org
> [mailto:linuxppc-embedded-bounces+mead=bnl.gov@ozlabs.org] On Behalf Of
> Mirek23
> Sent: Thursday, May 10, 2007 4:45 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: RE: zImage.elf loads but does not start
> 
> 
> Thank you for all of the advices.
> I did more study on that problem but still without the success.
> 
> 1. I did redd the ELDK manual and I have invoked :
> ELDK_FIXOWNER
> ELDK_MAKEDEV
> 
> in the "dev" directory there were created many nodes like that:
> 
> crw-rw-rw-    1 root     root       5,   1 May  8 15:42 console
> crw-rw-rw-    1 root     root       4,  64 May  8 15:42 ttyS0
> 
> In the kernel command line configuration I have the entry :
> CONFIG_CMDLINE="console=ttyUL0,9600 root=/dev/nfs rw nfsroo ...
> 
> so I have created by hand the node:
> crw-rw-rw-    1 root     root     204, 187 May  8 15:44 ttyUL0
> 
> Unfortunately the kernel boots to the point:
> 
> [    9.130834] Looking up port of RPC 100003/2 on 129.129.130.106
> [    9.207363] Looking up port of RPC 100005/1 on 129.129.130.106
> [    9.303794] VFS: Mounted root (nfs filesystem).
> [    9.359316] Freeing unused kernel memory: 96k init
> 
> and after that it hangs.
> 
> I have made some modifications to the kernel init/main.c file. In that
> file I have inserted the printk statements to see how far the kernel
> goes. It seems to be that the last thing it does it executes the
> sbin/init command and it hangs.
> 
> Instead of the sbin/init I have tried to execute other commands like
> bin/echo this_is_text_string and bin/echo this_is_test >>
> /var/log/messages
> 
> the modification looks like (init/main.c):
> before modification:
>         printk("test 3\n");
>         run_init_process("/sbin/init");
>         printk("test 4\n");
> after modification
>         printk("test 3\n");
>         run_init_process("/bin/echo ala");
>         run_init_process("/bin/echo buba >> /var/log/messages");
>         printk("test 4\n");
> 
> 
> 
> In both cases the last thing which was printed is "test 3"
> The /var/log/messages remains empty.
> 
> I thought that it might be the uart_lite driver is the source of the
> problem. I rebuild the kernel configuring it for the standard UART
> driver instead of the uart_lite.
> This time my command line looks like:
> CONFIG_CMDLINE="console=ttyS0,9600 root=/dev/nfs rw nfsroo ...
> 
> When booting the kernel configured with the UART  I see anything printed
> on the screen so it is even worse than before.
> 
> Do you have any suggestions.
> 
> Best Regards
> 
> Mirek
> 
> 
> 
> Charles Krinke wrote:
>> 
>> I find this usually happens when /dev/tty, /dev/console or /dev/ttyS0 
>> are not setup properly. That is, they are files instead of nodes. This
> 
>> menas you have mounted the root filesystem and init is running on that
> 
>> root filesystem.
>> 
>> Charles
>> 
>> 
>> -----Original Message-----
>> From: linuxppc-embedded-bounces+ckrinke=istor.com@ozlabs.org
>> [mailto:linuxppc-embedded-bounces+ckrinke=istor.com@ozlabs.org] On 
>> Behalf Of Adrian Craine
>> Sent: Tuesday, May 08, 2007 2:50 PM
>> To: Leonid
>> Cc: linuxppc-embedded@ozlabs.org; Mirek23
>> Subject: Re: zImage.elf loads but does not start
>> 
>> Leonid wrote:
>>> rootpath=
>>> [    9.130834] Looking up port of RPC 100003/2 on 129.129.130.106
>>> [    9.207363] Looking up port of RPC 100005/1 on 129.129.130.106
>>> [    9.303794] VFS: Mounted root (nfs filesystem).
>>> [    9.359316] Freeing unused kernel memory: 96k init
>>> [    9.422162] Warning: unable to open an initial console.
>>>
>>>   
>> The exact device node this requires is /dev/console c 5 1 That should 
>> solve your issue.
>> 
>> Cheers,
>>              Adrian.
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> 
>> 
> 
> --
> View this message in context:
> http://www.nabble.com/zImage.elf-loads-but-not-starts-tf3607582.html#a10
> 409434
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
> 
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
View this message in context: http://www.nabble.com/zImage.elf-loads-but-not-starts-tf3607582.html#a10429898
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
