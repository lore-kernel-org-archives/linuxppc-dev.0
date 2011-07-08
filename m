Return-Path: <mikey@neuling.org>
Received: from localhost.localdomain (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id CEE39B6F76
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 11:51:09 +1000 (EST)
To: divya <dipraksh@linux.vnet.ibm.com>
Subject: Re: {PATCH] Firmware update using the update_flash -f <filename>
	results to soft lockup BUG
In-reply-to: <4E155F15.1030805@linux.vnet.ibm.com>
References: <4E1543B6.9060800@linux.vnet.ibm.com> <6426.1310019149@neuling.org>
	<4E155F15.1030805@linux.vnet.ibm.com>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 08 Jul 2011 11:51:09 +1000
Message-ID: <10345.1310089869@neuling.org>
Cc: antonb@au1.ibm.com, naveedaus@in.ibm.com, suzukikp@in.ibm.com,
	chavez@us.ibm.com, arunbal@in.ibm.com, srikar@linux.vnet.ibm.com,
	linuxppc-dev@ozlabs.org, jlarrew@us.ibm.com, lxie@us.ibm.com,
	mahesh.salgaonkar@in.ibm.com,
	Subrata Modak <subrata@linux.vnet.ibm.com>, kenistoj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <4E155F15.1030805@linux.vnet.ibm.com> you wrote:
> This is a multi-part message in MIME format.
> --===============3790206687486290502==
> Content-Type: multipart/alternative;
>  boundary="------------080309090408040507080807"
> 
> This is a multi-part message in MIME format.
> --------------080309090408040507080807
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> Content-Transfer-Encoding: 7bit
> 
> On Thursday 07 July 2011 11:42 AM, Michael Neuling wrote:
> > In message<4E1543B6.9060800@linux.vnet.ibm.com>  you wrote:
> >    
> >> Hi ,
> >>
> >> Problem Description:
> >> Firmware update using the update_flash -f<filename>   results to soft lock
up
> >> BUG
> >> FLASH: preparing saved firmware image for flash
> >> FLASH: flash image is 50141296 bytes
> >> FLASH: performing flash and reboot
> >> FLASH: this will take several minutes.  Do not power off!
> >> BUG: soft lockup - CPU#1 stuck for 67s! [events/1:36]
> >>
> >> Steps to reproduce:
> >> 1. Check the firmware information on the machine (using ASM or lsmcode)
> >> 2. Update the system firmware with the update_flash command
> >> update_flash -f 01FL350_039_038.img
> >> info: Temporary side will be updated with a newer or
> >> identical image
> >>
> >> Projected Flash Update Results:
> >> Current T Image: FL350_039
> >> Current P Image: FL350_039
> >> New T Image:     FL350_039
> >> New P Image:     FL350_039
> >> Flash image ready...rebooting the system...
> >>
> >> Broadcast message from root@abc
> >> (/dev/hvc0) at 5:25 ...
> >>
> >> The system is going down for reboot NOW!
> >> [root@abc /]# Stopping rhsmcertd[  OK  ]
> >> Stopping atd: [  OK  ]
> >> Stopping cups: [  OK  ]
> >> Stopping abrt daemon: [  OK  ]
> >> Stopping sshd: [  OK  ]
> >> Shutting down postfix: [  OK  ]
> >> Stopping rtas_errd (platform error handling) daemon: [  OK  ]
> >> Stopping crond: [  OK  ]
> >> Stopping automount: [  OK  ]
> >> Stopping HAL daemon: [  OK  ]
> >> Stopping iprdump: [  OK  ]
> >> Killing mdmonitor: [  OK  ]]
> >> Stopping system message bus: [  OK  ]
> >> Stopping rpcbind: [  OK  ]
> >> Stopping auditd: [  OK  ]
> >> Shutting down interface eth0:  [  OK  ]
> >> Shutting down loopback interface:  [  OK  ]
> >> ip6tables: Flushing firewall rules: [  OK  ]
> >> ip6tables: Setting chains to policy ACCEPT: filter [  OK  ]
> >> ip6tables: Unloading modules: [  OK  ]
> >> iptables: Flushing firewall rules: [  OK  ]
> >> iptables: Setting chains to policy ACCEPT: filter [  OK  ]
> >> iptables: Unloading modules: [  OK  ]
> >> Sending all processes the TERM signal... [  OK  ]
> >> Sending all processes the KILL signal... [  OK  ]
> >> Saving random seed:  [  OK  ]
> >> Turning off swap:  [  OK  ]
> >> Turning off quotas:  [  OK  ]
> >> Unmounting pipe file systems:  [  OK  ]
> >> Unmounting file systems:  [  OK  ]
> >> init: Re-executing /sbin/init
> >> Please stand by while rebooting the system...
> >> Restarting system.
> >> FLASH: preparing saved firmware image for flash
> >> FLASH: flash image is 50141296 bytes
> >> FLASH: performing flash and reboot
> >> FLASH: this will take several minutes.  Do not power off!
> >> BUG: soft lockup - CPU#1 stuck for 67s! [events/1:36]
> >>
> >> This is solved by the following patch
> >>      
> > Can you please explain how it fixes it?
> >    
> The flash update is conducted with an RTAS call. The RTAS calls are
> serialized by lock_rtas() which uses a spin_lock.
> 
> Now there is rtasd which keeps scanning for the RTAS events generated
> on the machine. This is performed via workqueue mechanism. The
> rtas_event_scan() also uses an RTAS call to scan the events,
> eventually taking the lock_rtas() before it issues the request.
>
> The flash update is an operation which takes long time, and hence
> while we are at it, anyboy else who wants to make an RTAS call will
> have to wait until the update is completed. Now in this case, the
> rtas_event_scan() is being kicked in to check for events and it waits
> a long time on the spin_lock, getting us a SOFT Lockup.

What other RTAS calls are going on at this point?  It worries me we are
stopping a CPU that's doing RTAS calls.  Your solution would seem to be
papering over a more serious problem.

> Before the rtas firmware update starts, all other CPUs should be
> stopped. Which means no other CPU should be in lock_rtas(). We do not
> want other CPUs execute while FW update is in progress and the system
> will be rebooted anyway after the update.

Mikey
