Return-Path: <frannk_m1@yahoo.com>
Received: from web32201.mail.mud.yahoo.com (web32201.mail.mud.yahoo.com
	[68.142.207.132]) by ozlabs.org (Postfix) with SMTP id AA20E689FC
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 16:00:25 +1100 (EST)
Message-ID: <20060112045343.14107.qmail@web32201.mail.mud.yahoo.com>
Date: Wed, 11 Jan 2006 20:53:43 -0800 (PST)
From: Frank <frannk_m1@yahoo.com>
To: andrew.l.bomber@maxtek.com, linuxppc-dev@ozlabs.org
In-Reply-To: <7E11C792A1D81242B9BFFC8355D4979387F6F9@us-bv-m23.global.tektronix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: mullenp@pdx.edu
Subject: Re: Linux 2.4.21 Embedded PPC 405 on Xilinx Virtex II pro is
	glacially slow
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



--- andrew.l.bomber@maxtek.com wrote:

> Hello,
> 
> I am running 2.4.21 on an embedded PPC 405 system, 125 MHz
> clock, 32 MB
> SDRAM. It currently only has a UART and ttys00 is its console.
> It is
> running the busy box monolithic binaries.  It is so slow that
> I have to
> be cautious not to overrun the 16 byte UART 16550 input
> buffer. Has
> anyone run into this problem before? Any ideas what might
> cause this or
> how to troubleshoot it. I am kind of new to Linux and PPC.
>  <<hypertermCaptureBBprompt.txt>> 
> Thanks,
> 
> Andrew
> 
> > 
> loaded at:     00400000 005EA1E4                              
>  
> board data at: 005E713C 005E7154                              
>  
> relocated to:  00405624 0040563C                              
>  
> zimage at:     00405B44 00456755                              
>  
> initrd at:     00457000 005E68E3                              
>  
> avail ram:     005EB000 02000000                              
>  
> 
> Linux/PPC load: console=ttyS0,115200 root=/dev/ram0           
>                                        
> Uncompressing Linux...done.                           
> Now booting the kernel                      
> id mach(): done               
> MMU:enter         
> MMU:hw init           
> MMU:mapin         
> MMU:mapin_ram done                  
> MMU:setio         
> MMU:exit        
> Linux version 2.4.26 (pm@mars) (gcc version 3.3.3 (DENX ELDK
> 3.1.1 3.3.3-9)) #9                                            
>                                   
> Sun Jan 8 16:42:35 PST 2006                           
> setup_arch: enter                 
> setup_arch: bootmem                   
> Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc.
> (source@mvista.com)                                           
>                                     
> 
> arch: exit          
> On node 0 totalpages: 8192                          
> zone(0): 8192 pages.                    
> zone(1): 0 pages.                 
> zone(2): 0 pages.                 
> Kernel command line: console=ttyS0,115200 root=/dev/ram0      
>                                                  
> Xilinx INTC #0 at 0x81010000 mapped to 0xFDFFE000             
>                                    
> Calibrating delay loop... 399.76 BogoMIPS                     
>                    
> Memory: 29948k available (596k kernel code, 196k data, 36k
> init, 0k highmem)                                             
>                               
> Dentry cache hash table entries: 4096 (order: 3, 32768 bytes) 
>                                                            
> Inode cache hash table entries: 2048 (order: 2, 16384 bytes)  
>                                                          
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)    
>                                                      
> Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)  
>                                                          
> Page-cache hash table entries: 8192 (order: 3,                
>                               
> POSIX conformance testing by UNIFIX                           
>        
> 
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd
> Serial driver version 5.05c (2001-07-08) with no serial
> options enabled
> ttyS00 at 0xfdfff003 (irq = 31) is a 16550A
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024
> blocksize
> loop: loaded (max 8 devices)
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 1598k freed
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 36k init
> 
> 
> BusyBox v0.60.5 (2005.03.07-10:03+0000) Built-in shell (msh)
> Enter 'help' for a list of built-in commands.
> 
> # killall xinetd
> # ls
> bin   dev   etc   ftp   home  lib   proc  sbin  tmp   usr  
> var
> # ttyS: 1 input overrun(s)
> wch
> # echo "hello worrld"
> hello worrld
> #ps
>   PID TTY     Uid        Size State Command
>     1         root       1832   S   init       
>     2         root          0   S   [keventd]
>     3         root          0   S   [ksoftirqd_CPU0]
>     4         root          0   S   [kswapd]
>     5         root          0   S   [bdflush]
>     6         root          0   S   [kupdated]
>    15 ttyS0   root       1880   S   -sh 
>    19 ttyS0   root       1940   R   ps 
> # top -b -n 1
> top: not found>
_______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

You might try cat'ing /proc/interrupts and see if something else
is sharing your uart interrupt...


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
