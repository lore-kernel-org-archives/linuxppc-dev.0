Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 60DA467ADB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Feb 2005 19:11:00 +1100 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 10 Feb 2005 08:40:38 +0100
References: <20050204192117.4F29CC108D@atlas.denx.de>
	<200502101137.07711.robin@india.tejasnetworks.com>
In-Reply-To: <200502101137.07711.robin@india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502100840.38232.g.jaeger@sysgo.com>
Subject: Re: Memory leak problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 10 February 2005 07:07, robin wrote:
> Hi
> We have an application running on  denx linux kernel 2.4.20.
> 
> Apparently there is a memory leak that we are not able to find.
> The application is giving out of memory error. Even if we restart 
> the application without rebooting the kernel, (killing all application 
> processes and restarting), it gives the same out of memory error. 
> Rebooting the kernel solves the problem.
> 
> It seems that the memory leak is not at the application level
> 'cos restarting the application doesnt solve the problem..
> 
> 1. Any ideas where I should look for the leak??

Check /proc/slabinfo and see if there are some "supicious" buffer,
that only increase and never decrease. From the kind of buffer
showing this behaviour you might find out where to dig...
Check it before running the application and afterwards.

> 2. Is there any known memory leak problems with the kernel??
There are enough places, where a kernel could leak, but in general
such leaks in the main part are detected really fast. Undiscovered
leaks are often found in the drivers itself.

What's your kernel config?
Which HW are you using?
What does this application?

Ciao,
Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                 Embedded and Real-Time Software
www.sysgo.com    |    www.elinos.com    |    www.osek.de
