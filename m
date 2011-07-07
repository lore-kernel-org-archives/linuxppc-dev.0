Return-Path: <mikey@neuling.org>
Received: from localhost.localdomain (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id 1340D1007D7
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jul 2011 16:12:30 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: divya <dipraksh@linux.vnet.ibm.com>
Subject: Re: {PATCH] Firmware update using the update_flash -f <filename>
	results to soft lockup BUG
In-reply-to: <4E1543B6.9060800@linux.vnet.ibm.com>
References: <4E1543B6.9060800@linux.vnet.ibm.com>
Date: Thu, 07 Jul 2011 16:12:29 +1000
Message-ID: <6426.1310019149@neuling.org>
Cc: suzukikp@in.ibm.com, antonb@au1.ibm.com, naveedaus@in.ibm.com,
	kenistoj@us.ibm.com, chavez@us.ibm.com, arunbal@in.ibm.com,
	linuxppc-dev@ozlabs.org, jlarrew@us.ibm.com, lxie@us.ibm.com,
	mahesh.salgaonkar@in.ibm.com, Subrata Modak <subrata@linux.vnet.ibm.com>,
	srikar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <4E1543B6.9060800@linux.vnet.ibm.com> you wrote:
> Hi ,
> 
> Problem Description:
> Firmware update using the update_flash -f<filename>  results to soft lockup
> BUG
> FLASH: preparing saved firmware image for flash
> FLASH: flash image is 50141296 bytes
> FLASH: performing flash and reboot
> FLASH: this will take several minutes.  Do not power off!
> BUG: soft lockup - CPU#1 stuck for 67s! [events/1:36]
> 
> Steps to reproduce:
> 1. Check the firmware information on the machine (using ASM or lsmcode)
> 2. Update the system firmware with the update_flash command
> update_flash -f 01FL350_039_038.img
> info: Temporary side will be updated with a newer or
> identical image
> 
> Projected Flash Update Results:
> Current T Image: FL350_039
> Current P Image: FL350_039
> New T Image:     FL350_039
> New P Image:     FL350_039
> Flash image ready...rebooting the system...
> 
> Broadcast message from root@abc
> (/dev/hvc0) at 5:25 ...
> 
> The system is going down for reboot NOW!
> [root@abc /]# Stopping rhsmcertd[  OK  ]
> Stopping atd: [  OK  ]
> Stopping cups: [  OK  ]
> Stopping abrt daemon: [  OK  ]
> Stopping sshd: [  OK  ]
> Shutting down postfix: [  OK  ]
> Stopping rtas_errd (platform error handling) daemon: [  OK  ]
> Stopping crond: [  OK  ]
> Stopping automount: [  OK  ]
> Stopping HAL daemon: [  OK  ]
> Stopping iprdump: [  OK  ]
> Killing mdmonitor: [  OK  ]]
> Stopping system message bus: [  OK  ]
> Stopping rpcbind: [  OK  ]
> Stopping auditd: [  OK  ]
> Shutting down interface eth0:  [  OK  ]
> Shutting down loopback interface:  [  OK  ]
> ip6tables: Flushing firewall rules: [  OK  ]
> ip6tables: Setting chains to policy ACCEPT: filter [  OK  ]
> ip6tables: Unloading modules: [  OK  ]
> iptables: Flushing firewall rules: [  OK  ]
> iptables: Setting chains to policy ACCEPT: filter [  OK  ]
> iptables: Unloading modules: [  OK  ]
> Sending all processes the TERM signal... [  OK  ]
> Sending all processes the KILL signal... [  OK  ]
> Saving random seed:  [  OK  ]
> Turning off swap:  [  OK  ]
> Turning off quotas:  [  OK  ]
> Unmounting pipe file systems:  [  OK  ]
> Unmounting file systems:  [  OK  ]
> init: Re-executing /sbin/init
> Please stand by while rebooting the system...
> Restarting system.
> FLASH: preparing saved firmware image for flash
> FLASH: flash image is 50141296 bytes
> FLASH: performing flash and reboot
> FLASH: this will take several minutes.  Do not power off!
> BUG: soft lockup - CPU#1 stuck for 67s! [events/1:36]
> 
> This is solved by the following patch

Can you please explain how it fixes it?

Also you need a signed off by.

> 
> --- arch/powerpc/kernel/setup-common.c.orig	2011-07-01 22:41:12.952507971 -
0400
> +++ arch/powerpc/kernel/setup-common.c	2011-07-01 22:48:31.182507915 -
0400
> @@ -109,11 +109,12 @@ void machine_shutdown(void)
>   void machine_restart(char *cmd)
>   {
>   	machine_shutdown();
> -	if (ppc_md.restart)
> -		ppc_md.restart(cmd);
>   #ifdef CONFIG_SMP
> -	smp_send_stop();
> +        smp_send_stop();

Random white space change here.

>   #endif
> +	if (ppc_md.restart)
> +		ppc_md.restart(cmd);
> +	
>   	printk(KERN_EMERG "System Halted, OK to turn off power\n");
>   	local_irq_disable();
>   	while (1) ;
> 
> Thanks
> Divya
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
