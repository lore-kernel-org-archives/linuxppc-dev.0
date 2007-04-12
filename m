Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4898EDDF6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Apr 2007 01:37:02 +1000 (EST)
Date: Thu, 12 Apr 2007 19:36:58 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Bruce_Leonard@selinc.com
Subject: Re: Still trying to get a stable 2.6.20.4 running on 8349ITX eval
	board
Message-ID: <20070412193658.06a958be@vitb.ru.mvista.com>
In-Reply-To: <OFA3732C99.56D7C409-ON882572BA.00702C6D-882572BA.00724020@selinc.com>
References: <OFA3732C99.56D7C409-ON882572BA.00702C6D-882572BA.00724020@selinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 11 Apr 2007 13:47:55 -0700
Bruce_Leonard@selinc.com wrote:

> Hi,
> 
> Posted a cry for help a few days ago on this issue ;)> .  Got a couple of 
> answers that didn't get me any farther so I'm on another fishing 
> expedition.  Basic set up is as follows; MPC8349ITX eval board; 2.6.20.4 
> kernel; a ubuntu/dapper FS via NFS.  The problem seems to be a random 
> lock-up in either a DSI exception (0x300), a program exception (0x700) or 
> a DTLB miss on store exception (0x1200).  I'm sure it's not truly random 
> (I'm sure there's probably only a single underlying problem), but it's 
> random in how it manifests.  When trying to mount the root FS via NFS, it 
> always successfully reaches the point where it runs "/sbin/init" in 
> main.c, but which script it fails in varies and it never gets to a login.
> 
> I've tried passing "init=/bin/sh" on the command line and I can reach a sh 
> prompt, but it doesn't take long before it locks up.  I can do a "find . 
> -name '*gcc*'" about four times before it stops.  I have a BDI2K hooked up 
> so I know where it's stopping (most commonly in the DTLB miss mentioned 
> above), but backtrace from GDB gets me nothing, and SRR0 and SRR1 don't 
> contain any useful information (frequently they're both zero).  I expect 
> it may be an interaction with the BDI, tho I'm not sure.
> 
> I've also tried a couple of other file systems (one right off the CD that 
> ships with the eval board and the latest from ELDK) as well as pulling 
> Kumar's powerpc kernel tree.  All possible combinations of these kernels 
> and file systems fail to run for any period of time.
> 
> Long winded way to get around to my questions (sorry :(  ):
> 1) Can any one point me to good references in using the BDI2K to find my 
> way back from exceptions?
> 2) I assume someone (Kumar?) has gotten some combination of kernel/FS to 
> boot and run on this box.  What combination is that?
> 
> 

It worked for me with both MontaVista and ELDK rfs for 6xx.

Your problem looks very much like odd DDR or memctl misconfiguration early in u-boot.
Please try upgrading your firmware with the latest u-boot from git tree at denx.de. Kernel from Paul Mackerras (powerpc.git) is also a good thing to give a try.

Also, there is Vitesse switch on this target, which should be initialized(Normally with vendor-shipped image you'll figure out how by print thirdp_init. Starting kernel without that may result in some instability too.

Hope it helps.

-- 
Sincerely, 
Vitaly
