Return-Path: <cfriesen@nortelnetworks.com>
Received: from zcars04f.nortelnetworks.com (zcars04f.nortelnetworks.com
	[47.129.242.57]) by ozlabs.org (Postfix) with ESMTP id E29332BF12
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Dec 2004 09:08:22 +1100 (EST)
Message-ID: <41B0E18C.2060801@nortelnetworks.com>
Date: Fri, 03 Dec 2004 15:58:36 -0600
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: looking for help, attempting to debug high latency in 2.4 kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi guys,

I'm running 2.4.22 on ppc32.  Embedded system, just 74xx cpu, dual tulip network 
links and fiberchannel card.  Card has 1.5GB of memory, rootfs is tmpfs, system 
has some NFS mounts.

We're seeing userspace delayed for almost a second every so often.  No idea 
what's causing it.

We've got scheduler instrumentation showing a usespace task starting to run, 
then a bunch of tasks being put on the runqueue, and finally we wake up and 
start running normally again almost a full second later.  The timing is not 
exactly the same in each case, but it's usually close to a second of delay.

I'm looking for some tips on how to go about tracking this down.

Where are my delays likely to be coming from? Long-running code paths?  Long 
periods with interrupts off?  I dunno where to start.

Would porting lockmeter be a good idea?  Is there anyone who's already done this 
for ppc?

I appreciate any help.

Thanks,

Chris
