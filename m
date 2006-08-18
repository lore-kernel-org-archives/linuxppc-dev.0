Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 1737867A3D
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 06:48:45 +1000 (EST)
In-Reply-To: <44E608F3.4060505@ru.mvista.com>
References: <Pine.LNX.4.61.0608172019390.420@ld0175-tx32.am.freescale.net>
	<44E608F3.4060505@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F4287729-0383-4916-A36E-96A19508CD9C@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Fix IRQ handling on MPC8540 ADS
Date: Fri, 18 Aug 2006 15:48:40 -0500
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 18, 2006, at 13:37, Sergei Shtylyov wrote:

> Hello.
>
> Andy Fleming wrote:
>> * Fixed IRQ handling for the 85xx ADS boards so it uses the new
>>   generic irq stuff
>> * Fixed PCI IRQ mapping so it comes from the device tree
>
>    NAK. The kernel doesn't build with this patch. I'm getting this:
>
>   CC      arch/powerpc/platforms/85xx/mpc85xx_ads.o
> arch/powerpc/platforms/85xx/mpc85xx_ads.c: In function  
> `mpc85xx_ads_pic_init':
> arch/powerpc/platforms/85xx/mpc85xx_ads.c:76: warning: implicit  
> declaration of
> function `of_put_node'
>
>   and then finally:

Argh.  In my rush to get these patches out, I neglected to test the  
8540 ADS, and forgot that I added a few lines for "robustness".  I  
will fix and resubmit after testing.

>
>   LD      .tmp_vmlinux1
> arch/powerpc/platforms/built-in.o(.init.text+0x26c): In function  
> `mpc85xx_ads_pic_init':
> arch/powerpc/platforms/85xx/mpc85xx_ads.c:84: undefined reference  
> to `of_put_node'
> arch/powerpc/platforms/built-in.o(.init.text+0x404):arch/powerpc/ 
> platforms/85xx/mpc85xx_ads.c:76: undefined reference to `of_put_node'
> make: *** [.tmp_vmlinux1] Error 1
>
>    There's no such function in the kernel -- it actually aclled  
> of_node_put(). I can post an updated patch after testing (if it  
> succeeds) if you like...
>
>> This patch *really* needs to go in before 2.6.18 is final, else  
>> 2.6.18 doesn't build for 85xx.
>
>    Looks like it's a bit crude yet to be committed...

Agreed, though it's actually no worse than the current mainline!

>
>> Thanks,
>> Andy
>
> WBR, Sergei
