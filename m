Message-ID: <3CC68229.9020806@cambridgebroadband.com>
Date: Wed, 24 Apr 2002 11:00:09 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: printk in m8xx_cpm_dpalloc() ???
References: <3CC67EA1.79561746@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I had the same problem.  printk() uses the CPM UART driver, and the initialisation of the CPM UART
driver uses m8xx_cpm_dpalloc().  If you make m8xx_cpm_dpalloc() use printk() then you create a
dependency loop.  Don't do it.

Alex

Steven Scholz wrote:

> Hi there,
>
> I thought I put a printk just for debug reasons into the function
> m8xx_cpm_dpalloc (in arch/ppc/8xx_io/commproc.c).
>
> But now the kernel hangs while starting the CPM UART driver!
>
> ...
> Decrementer Frequency = 300000000/60
> m8xx_cpm_dpalloc: 8 bytes @ 0x0808		!!!!!!!!!!!!!
> m8xx_cpm_dpalloc: 16 bytes @ 0x0818		!!!!!!!!!!!!!
> Calibrating delay loop... 79.66 BogoMIPS
> Memory: 14596k available (1056k kernel code, 396k data, 52k init, 0k
> highmem)
> Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
> Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> CPM UART driver version 0.03
> ttyS00 at 0x0280 is a SMC			!!!!!!!!!!!!!
> ...
> And nothing more happens!
>
> Does anyone know why?
>
> Cheers,
>
> Steven
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
