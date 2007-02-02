Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1-in.cisco.com [171.71.176.70])
	by ozlabs.org (Postfix) with ESMTP id 7E168DDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Feb 2007 02:46:00 +1100 (EST)
To: "Andriy Korud" <a.korud@vector.com.pl>
Subject: Re: Anyone success with 440GR Rev.B (1.1)?
References: <60E856FD577CC04BA3727AF4122D3F1601238644@3bit.vector.com.pl>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 02 Feb 2007 07:45:51 -0800
In-Reply-To: <60E856FD577CC04BA3727AF4122D3F1601238644@3bit.vector.com.pl>
	(Andriy Korud's message of "Fri, 2 Feb 2007 12:35:46 +0100")
Message-ID: <adafy9o4l74.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 > I have complete system (U-Boot, Linux, userspace) running on 440GR Rev.A. 
 > However after mounting newer chip revision (Rev.B, 1.1) U-Boot and Linux boots fine, however when trying to execute first userland application (init), I get:
 > 
 > Freeing unused kernel memory: 112k init
 > init has generated signal 4 but has no handler for it
 > Kernel panic - not syncing: Attempted to kill init!

signal 4 is SIGILL.  Just a guess but do you have a cputable entry for
440GR rev B in your arch/powerpc/kernel/cputable.c?  If you don't then
I think the default kernel settings will result in the wrong cacheline
size being used, which leads to userspace often dying with illegal
instruction traps.

(I don't see any 440GR entries in cputable.c, neither rev A nor rev B,
in the upstream kernel so I'm assuming you're patching your kernel
somehow.  So checking that your patch covers rev B would be the first
thing to do)

 - R.
