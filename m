Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3491DDF69
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 20:01:04 +1000 (EST)
Subject: Re: starting with 2.6.26-rc1 cell_defconfig fails on QS22
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Reber <adrian@lisas.de>
In-Reply-To: <20080623094539.GA16685@lisas.de>
References: <20080623094539.GA16685@lisas.de>
Content-Type: text/plain
Date: Mon, 23 Jun 2008 20:00:55 +1000
Message-Id: <1214215255.8011.257.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-06-23 at 11:45 +0200, Adrian Reber wrote:
> I have a custom config to build a kernel which runs on JS21/QS21/QS22.
> Starting with 2.6.26-rc1 that fails on JS21 (with SLOF). Bisecting lead
> me to the following commit:
> 
>  commit 366234f657879aeb7a1e2ca582f2f24f3fae9269
>  Author: Kumar Gala <galak@kernel.crashing.org>
>  Date:   Wed Apr 16 05:52:28 2008 +1000
> 
>      [POWERPC] Update linker script to properly set physical addresses
> 
> I then tried it with cell_defconfig and it fails with almost the same
> error on QS22. I have not restared the bisecting on QS22 because the
> error is so similar:
> 
> zImage starting: loaded at 0x00400000 (sp: 0x0e16aea0)
> Allocating 0x6790c8 bytes for kernel ...
> OF version = 'IBM,SLOF,HEAD'
> gunzipping (0x01400000 <- 0x00407000:0x0062ce4a)...done 0x60405a bytes
> 
> Linux/PowerPC load: 
> Finalizing device tree... using OF tree (promptr=0e1004c4)
>  
> 
> ( 700 ) Program Exception [ e1004c4 ]

The program check exception happens at 0xe1004c4 ? That looks like the
OF entry point (promptr)... could it be possible that it got corrupted
somewhat ? The only thing I see above there would be the stack but
I fail to see how it would use that much... 

>     R0 .. R7           R8 .. R15         R16 .. R23         R24 .. R31
> 00000000014073b0   000000000e974200   0000000000000000 0000000000000000   
> 000000000e16aea0   0000000000638c04   0000000000000000 0000000000000000   
> 00000000019e2b98   000000000e974200   0000000000000000 0000000001400000   
> 0000000000000000   b000000000003000   0000000000000000 0000000000638804   
> 0000000000000000   2000000000000000   0000000000000000 000000000e96f3c0   
> 000000000e1004c4   0000000000000000   0000000000000000 000000000e1004c4   
> 000000000e96f3c0   0000000000000000   0000000000000000 0000000000000000   
> 0000000000638804   0000000000000000   000000000eac5d70 0000000000000000   
> 
>     CR / XER           LR / CTR          SRR0 / SRR1        DAR / DSISR
>         80000022   00000000014073e8   000000000189e99c 0000000000000000   
> 0000000020000000   0000000001400000   9000000000083000 00000000   
> 
> I have tried it with gcc-3.4.2, gcc-4.1.1 and gcc-4.2.4.
> 
> Somehow I expect that I am doing something wrong, because nobody else
> has reported something like this yet.
> 
> It looks like 2.6.25 was the last version which worked on SLOF based
> systems.
> 
> 		Adrian
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
