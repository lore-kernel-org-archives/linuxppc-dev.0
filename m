Return-Path: <linux@sundmangroup.com>
Received: from proxy3.bredband.net (proxy3.bredband.net [195.54.101.73])
	by ozlabs.org (Postfix) with ESMTP id 2CECEDDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jan 2008 18:01:39 +1100 (EST)
Received: from ironport2.bredband.com (195.54.101.122) by proxy3.bredband.net
	(7.3.127) id 473103E7017E1D73 for linuxppc-embedded@ozlabs.org;
	Thu, 17 Jan 2008 08:01:37 +0100
Message-ID: <478EFD4C.9070706@sundmangroup.com>
Date: Thu, 17 Jan 2008 08:01:32 +0100
From: Matias Sundman <linux@sundmangroup.com>
MIME-Version: 1.0
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: SCHED_FIFO & System()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
I have some strange behavior in one of my systems.

I have a real-time thread under SCHED_FIFO which is running every 10ms. 
It is blocking on a semaphore and released by a timer interrupt every 10ms.
Generally this works really well.

However, there is a module in the system that makes a / system() / call 
from c-code ;

  system("run_my_script");

By calling and running a bash script. Independent of how the actual 
script looks like the real time thread does not get scheduled under 80ms 
-- the time it takes
for the system() call to finish.

I can see when running a LTT session that the wake_up event occurs for 
the real time thread 10ms into the system call but nevertheless the real 
time thread does not get scheduled.

Anybody who recognize this or similar situations?



Cheers // Matias
