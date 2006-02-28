Return-Path: <thagen@slb.com>
Received: from mail.slb.com (eurmta01.london.eur.slb.com [134.32.26.55])
	by ozlabs.org (Postfix) with ESMTP id 5C696679FF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Feb 2006 19:39:55 +1100 (EST)
Received: from pmxchannel_int-daemon.eurmta01.london.eur.slb.com by
	eurmta01.london.eur.slb.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	id <0IVE00G012L33M@eurmta01.london.eur.slb.com> for
	linuxppc-embedded@ozlabs.org; Tue, 28 Feb 2006 08:36:39 +0000 (GMT)
Received: from wgmail3.oslo.eur.slb.com
	(wgmail3.oslo.eur.slb.com [134.32.44.153]) by
	eurmta01.london.eur.slb.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0IVE00MN62L3AO@eurmta01.london.eur.slb.com> for
	linuxppc-embedded@ozlabs.org; Tue, 28 Feb 2006 08:36:39 +0000 (GMT)
Received: from [134.32.140.197] (localhost [127.0.0.1])
	by wgmail3.oslo.eur.slb.com (Switch-2.2.8/8.11.1) with ESMTP id
	k1S8aUV01362 for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Feb 2006 09:36:30 +0100 (MET)
Date: Tue, 28 Feb 2006 09:36:32 +0100
From: Tore Martin Hagen <thagen@slb.com>
Subject: Re: All children killed in /sbin/init
In-reply-to: <43F03632.9060609@slb.com>
To: linuxppc-embedded@ozlabs.org
Message-id: <44040B90.3050708@slb.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <43F03632.9060609@slb.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

For Archive reasons I am posting the solution to my problem.

The problem was a missing patch to the arch/ppc/kernel/cputable.c (got 
it from Montavista)


--- arch/ppc/kernel/cputable.c.orig Tue Jul 6 11:22:03 2004
+++ arch/ppc/kernel/cputable.c Tue Jul 6 11:25:49 2004
@@ -289,6 +289,14 @@
32, 32,
__setup_cpu_603
},
+ { /* 8280 is a G2_LE (603e core, plus some) */
+ 0x7fff0000, 0x00820000, "8280",
+ CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
+ CPU_FTR_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
+ COMMON_PPC,
+ 32, 32,
+ __setup_cpu_603
+ },
{ /* default match, we assume split I/D cache & TB (non-601)... */
0x00000000, 0x00000000, "(generic PPC)",
CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,

/Tore



Tore Martin Hagen wrote:

>Hi,
>
>I have a custom board with MPC8275 and NFS root file system. I use 
>u-boot to load the kernel and it boots up, mounts the file system and 
>starts /sbin/init. Then all the children of init dies, I get the 
>following errors (with Debugging enabled in /sbin/init)
>
>Sending DHCP requests ., 
>OK                                                                              
>
>IP-Config: Got DHCP answer from 10.0.0.1, my address is 
>10.0.0.111                                      
>IP-Config: 
>Complete:                                                                                     
>
>      device=eth0, addr=10.0.0.111, mask=255.255.255.0, 
>gw=10.0.0.1,                                    
>     host=10.0.0.111, domain=, 
>nis-domain=(none),                                                       
>     bootserver=10.0.0.1, rootserver=10.0.0.1, 
>rootpath=/local/Mpc8266ads/Box2/root                     
>NET4: Unix domain sockets 1.0/SMP for Linux 
>NET4.0.                                                     
>Looking up port of RPC 100003/2 on 
>10.0.0.1                                                             
>Looking up port of RPC 100005/1 on 
>10.0.0.1                                                             
>VFS: Mounted root (nfs 
>filesystem).                                                                      
>
>Mounted devfs on 
>/dev                                                                                    
>
>Freeing unused kernel memory: 96k 
>init                                                                   
>                                                               
>INIT: version 2.78 booting
>INIT: Reading 
>inittab                                                                                    
>
>INIT: Checking for children to 
>kill                                                                     
>INIT: Checking for children to 
>start                                                                    
>INIT: Started id si (pid 
>11)                                                                             
>
>INIT: init_main: 
>waiting..                                                                               
>
>INIT: chld_handler: marked 11 as 
>zombie                                                                 
>INIT: got 
>SIGCHLD                                                                                        
>
>INIT: Child died, PID= 
>11                                                                                
>
>INIT: Checking for children to 
>start                                                                    
>INIT: SYSINIT -> 
>BOOT                                                                                    
>
>INIT: init_main: 
>waiting..                                                                               
>
>INIT: Checking for children to 
>start                                                                    
>INIT: BOOT -> 
>NORMAL                                                                                     
>
>INIT: Entering runlevel: 
>3                                                                               
>
>INIT: init_main: 
>waiting..                                                                               
>
>INIT: Checking for children to 
>start                                                                    
>INIT: Started id tmh (pid 
>14)                                                                            
>
>INIT: init_main: 
>waiting..                                                                               
>
>INIT: chld_handler: marked 14 as 
>zombie                                                                 
>INIT: got 
>SIGCHLD                                                                                        
>
>INIT: Child died, PID= 14
>.....
>
>The file system works fine on my MPC8266ADS board.
>
>Do I have a problem with the mounting of the file system, or is there 
>something wrong with my MMU?
>
>The kernel is compiled with     CONFIG_PPC_STD_MMU=y
>
>Any suggestions about where i should start digging would be appreciated.
>
>/Tore Martin Hagen
>                                                                     
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  
>
