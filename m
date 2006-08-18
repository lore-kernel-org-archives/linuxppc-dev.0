Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 3623767B76
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 05:32:33 +1000 (EST)
Message-ID: <44E61612.6070405@ru.mvista.com>
Date: Fri, 18 Aug 2006 23:33:38 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Fix IRQ handling on MPC8540 ADS
References: <Pine.LNX.4.61.0608172019390.420@ld0175-tx32.am.freescale.net>
	<44E608F3.4060505@ru.mvista.com>
In-Reply-To: <44E608F3.4060505@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Sergei Shtylyov wrote:

>>* Fixed IRQ handling for the 85xx ADS boards so it uses the new
>>  generic irq stuff
>>* Fixed PCI IRQ mapping so it comes from the device tree

>     NAK. The kernel doesn't build with this patch. I'm getting this:

>    CC      arch/powerpc/platforms/85xx/mpc85xx_ads.o
> arch/powerpc/platforms/85xx/mpc85xx_ads.c: In function `mpc85xx_ads_pic_init':
> arch/powerpc/platforms/85xx/mpc85xx_ads.c:76: warning: implicit declaration of
> function `of_put_node'

>    and then finally:

>    LD      .tmp_vmlinux1
> arch/powerpc/platforms/built-in.o(.init.text+0x26c): In function 
> `mpc85xx_ads_pic_init':
> arch/powerpc/platforms/85xx/mpc85xx_ads.c:84: undefined reference to `of_put_node'
> arch/powerpc/platforms/built-in.o(.init.text+0x404):arch/powerpc/platforms/85xx/mpc85xx_ads.c:76: 
> undefined reference to `of_put_node'
> make: *** [.tmp_vmlinux1] Error 1
> 
>     There's no such function in the kernel -- it actually aclled 
> of_node_put(). I can post an updated patch after testing (if it succeeds) if 
> you like...

    Alas, the patched kernel didn't boot further than the early startup 
messages (after I've updated U-Boot with the correct PIC device type).

>>This patch *really* needs to go in before 2.6.18 is final, else 2.6.18 
>>doesn't build for 85xx.

>     Looks like it's a bit crude yet to be committed...

    Not even compile tested. :-/

WBR, Sergei
