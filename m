Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 845DB67B54
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 02:43:30 +1000 (EST)
Message-ID: <44D8BF02.6090103@ovro.caltech.edu>
Date: Tue, 08 Aug 2006 09:42:42 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Eric Heim <sheldoninstruments@yahoo.com>
Subject: Re: MPC8349 clocking
References: <20060808155533.33325.qmail@web37803.mail.mud.yahoo.com>
In-Reply-To: <20060808155533.33325.qmail@web37803.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Eric Heim wrote:
> Anyone know of a patch for the MPC8349 clocking scheme.  All my time 
> tests are indicating that the clock is running at half speed though I 
> see no indication in the /proc/cpuinfo.  I run a sleep(5) and it takes 
> ten seconds but gettimeofday( ) and the time base register indicate that 
> 5 seconds passed.
> 

Hi Tim,

Can you let us know the kernel and the u-boot version you are using
(and the origin, eg. Freescale or Denx or ...).

The issue could be in either U-Boot or Linux.

0n my MDS board with the latest U-Boot and Denx Linux kernel,
bdinfo indication 528MHz CPU, 264MHz bus frequency, then
Linux shows these same numbers in /proc/cpuinfo.

date; sleep 10; date

run on the x86 development machine at the same time
as the MDS board (well, as fast as I could move my mouse),
showed a 10s delay on both, and both finished at the
same time.

So, I think its fixed.

grep for csb_clk in the latest U-boot source shows it up
in cpu/mpc83xx/speed.c, lbiu_clk is also in there.
(lbiu_clk is the local-bus interface unit clock).
I'm not sure which clock is used for the timer time-base,
so find out the clock source of the timer the kernel
is using, and then check the clock settings in your
U-Boot versus the latest source (which you can obtain
using the git tool from Denx's repository).

grep in the arch/ppc folder of the Linux source (Denx git
version) didn't show anything for csb_clk or lbiu_clk,
so either their names are different there, or the U-Boot
source is the location of the problem setting.

I believe Kumar posted a csb_clk (or lbiu_clk) patch that fixed
a setting error ... but I can't recall if it was a U-Boot
patch or a kernel patch. I looked in the CHANGELOG for
U-Boot and I didn't see a comment related to the clock
settings (searching based on Kumar, MPC8349, or MPC83xx).

Perhaps someone reading the list has a better recollection
than I :)

Cheers
Dave
