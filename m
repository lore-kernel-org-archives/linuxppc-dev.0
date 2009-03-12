Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82B09DE235
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 18:32:19 +1100 (EST)
Subject: Re: Linux boot problem, pc does not point to virtual memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: FISCHER Thierry <thierry@sdl.hitachi.co.jp>
In-Reply-To: <49B8A9A1.4090908@sdl.hitachi.co.jp>
References: <49B8A9A1.4090908@sdl.hitachi.co.jp>
Content-Type: text/plain
Date: Thu, 12 Mar 2009 18:31:29 +1100
Message-Id: <1236843089.7086.82.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-03-12 at 15:20 +0900, FISCHER Thierry wrote:
> Hi,
>    
> I am having some problem booting linux on Powerpc 405 (xilinx virtex4).
> 
> I have the following output on the terminal:
> ******************************************************
> zImage starting: loaded at 0x00400000 (sp: 0x0070feb0)
> Allocating 0x38a79c bytes for kernel ...
> gunzipping (0x00000000 <- 0x0040d000:0x0059ee42)...done 0x367f58 bytes
> Attached initrd image at 0x0059f000-0x0070ef20
> initrd head: 0x1f8b0808
>  
> Linux/PowerPC load: console=ttyUL0 root=/dev/ram
> Finalizing device tree... flat tree at 0x71c300
> *******************************************************
>  
> The strange thing is that when I check the value of pc register, it does 
> not return values of the virtual memory but values like:
> pc :0x0000ebd4
> pc :0x00002148
> pc :0x00002194
> pc :0x00002150 ...
> Instead of values like 0xcXXXXXXX

If it's a 405 it has a real mode (for example when it takes an
exception) so it may just be running in real mode when you sample it.

Cheers
Ben.

> It looks like there is a problem with the MMU or something like that ?
> I have seen similar problems on the xilinx forum but it did not helped 
> me so much:
> http://forums.xilinx.com/xlnx/board/message?board.id=ELINUX&message.id=595&query.id=371581#M595 
> 
> http://forums.xilinx.com/xlnx/board/message?board.id=EDK&message.id=6235&query.id=367949#M6235 
> 
> 
> If anyone has experienced similar problem please let me know.
> Any suggestion is welcomed.
>  
> Thanks,
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
