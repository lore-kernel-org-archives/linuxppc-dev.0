Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 5AE78DE00C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Jan 2007 00:00:20 +1100 (EST)
Message-ID: <45BDEFDE.9090006@ru.mvista.com>
Date: Mon, 29 Jan 2007 16:00:14 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: sudheer <urwithsudheer@gmail.com>
Subject: Re: regarding kgdb in ppc
References: <12c9fc1a0611280820h748cd520pd5546e2803dbab82@mail.gmail.com>	<d16b1c80611301101n5f9ea44died47d2ff1bac4221@mail.gmail.com>	<12c9fc1a0611302029h36f29943s119f8ad70b95f2c4@mail.gmail.com>	<12c9fc1a0612010331p2c33c048j1af6006deda14abb@mail.gmail.com>	<d16b1c80612010540k7600f0e1n92fadd3d539d75bf@mail.gmail.com>	<12c9fc1a0612040805p64f23a7bj42fd27891294dfc2@mail.gmail.com>	<458E384A.108@gmail.com>	<198592450612281634l3e71834i5915139a73e8f5d1@mail.gmail.com>	<758a2bbf0612281702u3a4f383bi14e418410bd4f912@mail.gmail.com>	<45964D27.6020708@gmail.com>	<758a2bbf0612301753q27727b01w92681214a6296434@mail.gmail.com>	<45B5A499.4060401@gmail.com>	<20070123114917.5668a578@localhost.localdomain>	<45B61FF2.6070706@gmail.com>
	<45B62294.5020900@ru.mvista.com> <45BDDCA8.5020505@gmail.com>
In-Reply-To: <45BDDCA8.5020505@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: kernelnewbies@nl.linux.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

sudheer wrote:

>>> I gave the following bootargs:
>>> console=ttyS0,115200 root=/dev/ram rw 
>>> kgdboe=@192.168.3.80/,@192.168.3.14/00:08:A1:84:EF:CA kgdbwait

>>    You don't have to specify the remote MAC, IIUC.

> When i dont give the mac address, the mac address all FFs(default) is 
> considered. So am giving the mac address too, only then its working 
> properly.

    What, you don't have ARP on host?!

> I have added few lines of code in driver/net/gianfar.c

> void gfar_poll_gianfar(struct net_device *dev )
> {
>    disable_irq(dev->irq);
>    gfar_interrupt(dev->irq, dev,  NULL);
>    enable_irq(dev->irq);
> 
> }

    This isn't complete, please use the community patch.  Gianfar TSEC has 3 
interrupts and all of them must be disabled.

> Now am able to boot the target kernel without any error. kgdb waits for 
> gdb connection.

>>> kgdboe: local port 6443
>>> kgdboe: local IP 192.168.3.80
>>> kgdboe: interface eth0
>>> kgdboe: remote port 6442
>>> kgdboe: remote IP 192.168.3.14
>>> kgdboe: remote ethernet address 00:08:a1:84:ef:ca
>>> kgdboe: eth0 doesn't support polling, aborting.
>>> kgdboe: netpoll_setup failed kgdboe failed

>>    Have you backported the gianfar netpoll patch from 2.6.20-rc1?

> I haven't backported the 2.6.20-rc1. As there are  many patches under 
> that tree , i didnt try for it and could not know which one to add.

    You certainly didn't need to backport the whole 2.6.20-rc1, only a signle 
patch (-:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=f2d71c2d800e68f158a5949e38b23f5140948548

WBR, Sergei
