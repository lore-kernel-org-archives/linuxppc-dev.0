Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 525FF2BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 02:40:51 +1000 (EST)
Date: Fri, 8 Oct 2004 09:40:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Message-ID: <20041008164047.GC14773@smtp.west.cox.net>
References: <Pine.LNX.4.60.0410080704170.6219@dell.enoriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0410080704170.6219@dell.enoriver.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cleaning up the Kconfig menu structure -- the bigger picture
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 08, 2004 at 07:16:18AM -0400, Robert P. J. Day wrote:

>   somewhat related to dan malek's posting, but i think part of the 
> problem with trying to figure out what the menuconfig menus should 
> support is that the relevant options are organized in a confusingly 
> haphazard way.

I suppose it's confusing from how it used to be, but not so much from a
how everyone else chooses stuff way.  For example...
[snip]
>   consider, first, serial port options.  if you choose 8xx, then 
> you'll be presented with the menu choices:
> 
>   Device Drivers -->
>     Character devices -->
>       Serial drivers -->
>         CPM SCC/SMC serial port support --> etc, etc.

Which is where every other serial driver is (that's been updated to use
the new serial core and make life easier).

[snip]
>   in that case, if you wanted to configure "CPM SCC Ethernet", why 
> would you go under "MPC8xx CPM Options" rather than the general 
> networking menu?  this is clearly inconsistent.

Because the CPM1/CPM2 enet drivers are still waiting to be cleaned up a
bit more, and moved there.  The FEC enet driver that Pantelis wrote
lives in drivers/net/ for example.

>   more to the point, i've always found it a bit strange that selecting 
> "8xx" as a processor would suddenly cause the top-level "MPC8xx CPM 
> Options" menu to appear, when other 8xx-related stuff was still 
> scattered elswewhere throughout the kernel source tree.

That's kinda the opposite direction of where I want things to move.
What, IMHO, should happen is that once the real drivers side of 8xx_io
are moved out into drivers/ we'll really be left with commproc and
microcode, both of which can live in arch/ppc/syslib/ as cpm1_common.c
and cpm1_microcode.c respecivley and we can deal with microcode
questions in arch/ppc/Kconfig where we now source the 8xx_io/Kconfig
file (or, if it really does end up making sense to, and I'm not yet
convinced of this, make platforms/8xx, we can put the question in
platforms/8xx/Kconfig).

-- 
Tom Rini
http://gate.crashing.org/~trini/
