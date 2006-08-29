Return-Path: <jrocnuck@hotmail.com>
Received: from bay0-omc2-s28.bay0.hotmail.com (bay0-omc2-s28.bay0.hotmail.com
	[65.54.246.164]) by ozlabs.org (Postfix) with ESMTP id 8DB2367A3F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 06:25:33 +1000 (EST)
Message-ID: <BAY117-F295EDC708218BBF2801DDAC8390@phx.gbl>
From: "Eric Nuckols" <jrocnuck@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: LinuxThreads && MontaVista Pro 3.1 
Date: Tue, 29 Aug 2006 16:13:24 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

LinuxThreads && MontaVista Pro 3.1

our setup:

HW:
   PrPMC800 MCP7410 board

SW:
  MontaVista Pro 3.1
  host - i686
  target ppc_74xx-
  kernel: 2.4.20_mvl31
  glibc 2.3.2
  LinuxThreads 0.10
  GCC 3.3.1


After all the research, it seems the problem is LinuxThreads just has all 
sorts of bugs between mishandling signals and deadlocking.
I'm dealing with a tight schedule and lots of code that works great until a 
LinuxThreads threadmanager barfs.
I'm in one of those classic positions where I inherited a lot of code that 
assumed pthreads worked as described, but have found otherwise.
There's no time or budget to rewrite the entire project to circumvent 
threading.


I've built a newer cross-compiler using NPTL, and when compiling with it 
(statically of course), I have the __libc_fork assertion problem due to some 
botched syscalls.
Likewise, I can't easily modify my kernel for that workaround, because I 
will continue to have to use the precompiled userland binaries in my system 
that rely on the old glibc libs with LinuxThreads,
compiled in. When it comes to the userland apps that MontaVista supplies, 
they don't provide the source and configuration for all the packages (at 
least not with the CDs I have), and even if they did, I would probably
require more time than I have to get them all built as needed.


So, my questions to the helpful people on this list are:

1.  Does anybody know if MontaVista has fixed these issues in their newer 
releases/patches of Pro 3.1 or Pro 4.0?  in other words,
   would I be spending the company's money wisely to go back to MontaVista 
for upgrades and service?

2.  If the answer to #1 is NO, has anybody else out there come across this 
same type of issue and found a decent solution?


// as for workarounds,  I've blocked basically all signals in all threads, 
created separate threads to wait on blocked signals, removed all the 
pthread_mutex_lock()
calls, and when I debug, I find that ususally I'm deadlocked in some form of 
timed_wait() or some other pthread related lockable/blockable call deep 
inside another system call
such as syslog for example.


Thanks,
Eric Nuckols
