Return-Path: <johnsoncheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.25])
	by ozlabs.org (Postfix) with SMTP id CD3FD67E3F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 13:11:26 +1000 (EST)
From: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
To: "'Daniel Ann'" <ktdann@gmail.com>
Date: Wed, 3 Aug 2005 11:11:16 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <9b7ca6570508021721773d06f0@mail.gmail.com>
Message-Id: <20050803031126.CD3FD67E3F@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: A PPC kernel issue with UART ??
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Actually, I had reviews all article about "serial console", just know I have
to use LEVEL for interrupt, not EDGE. Unfortunately the default interrupt
setting for kernel is with LEVEL, IRQ_SENSE_LEVEL, I think I don't need to
modify it.
But I found I add ASYNC_SKIP_TEST flag to UART in sandpoint.h can fix my
problem.

Thanks,
Johnson Cheng

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Daniel Ann
Sent: Wednesday, August 03, 2005 8:22 AM
To: JohnsonCheng
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: A PPC kernel issue with UART ??

Johnson,

You know what? I've had the exact same problem only day or two ago. I
think the mail subject was "serial console" or something similar. Have
a read at it.

BTW, My problem was with interrupt setting.
Daniel.

On 8/2/05, JohnsonCheng <johnsoncheng@qnap.com.tw> wrote:
> 
> 
> Dear All,
> 
>  
> 
> I meet a wired UART problem on linux-2.6 with MPC8241 chip.
> 
>  
> 
> My Environment is as following: 
> 
> CPU: MPC8241
> 
> Linux: 2.6.12.3
> 
> COM1 offset: 0x4500, COM2 offset: 0x4600
> 
>  
> 
> When I booting my rootfs, it hangs at following message:
> 
> RAMDISK: Compressed image found at block 0
> 
> VFS: Mounted root (ext2 filesystem) readonly.
> 
> Freeing unused kernel memory: 104k init
> 
> EXT2-fs warning: checktime reached, running e2fsck is recommended
> 
>  
> 
> I had add printk in tty_write() of drivers/char/tty_io.c, the message from
> rootfs have printed.
> 
> The conclusion is that message can be printed by printk() in linux kernel,
> but can't be printed by printf() in user mode. I think it must be
something
> wrong for my UART configurations, does anybody know it??
> 
>  
> 
>  
> 
> Best Regards,
> 
> Johnson Cheng
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Daniel
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
