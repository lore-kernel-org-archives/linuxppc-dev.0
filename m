Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id A6F542BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 21:23:14 +1000 (EST)
Received: from [10.1.1.102] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-embedded@ozlabs.org; 8 Oct 2004 07:23:07 -0400
Date: Fri, 8 Oct 2004 07:16:18 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.LNX.4.60.0410080704170.6219@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: cleaning up the Kconfig menu structure -- the bigger picture
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


   somewhat related to dan malek's posting, but i think part of the 
problem with trying to figure out what the menuconfig menus should 
support is that the relevant options are organized in a confusingly 
haphazard way.

   if you're building a kernel for an 8xx system, obviously you'll 
choose the 8xx processor, at which point naturally a number of other 
kernel config menu entries (dependent on the "8xx" config variable and 
falling off of that) suddenly become visible.  unfortunately, in 
really badly-chosen places.

   consider, first, serial port options.  if you choose 8xx, then 
you'll be presented with the menu choices:

   Device Drivers -->
     Character devices -->
       Serial drivers -->
         CPM SCC/SMC serial port support --> etc, etc.

now, is this the right place for configuring CPM SCC/SMC serial port 
support?  sure, some people might say.  after all, it's serial port 
stuff, it should be under "Serial drivers".  makes perfect sense, 
right?

   in that case, if you wanted to configure "CPM SCC Ethernet", why 
would you go under "MPC8xx CPM Options" rather than the general 
networking menu?  this is clearly inconsistent.

   more to the point, i've always found it a bit strange that selecting 
"8xx" as a processor would suddenly cause the top-level "MPC8xx CPM 
Options" menu to appear, when other 8xx-related stuff was still 
scattered elswewhere throughout the kernel source tree.

   it might make more sense, if you choose "8xx", to have *all* 
8xx-related stuff to suddenly appear under a single top-level menu: 
serial ports, networking, patches, etc.  at least, you'd get to see 
everything in one place, and calculating interdependencies would be 
simpler (no, you can't choose SMC1 to be both a serial port and an 
ethernet, that sort of thing).

   i don't know if this suggestion is feasible but, really, it seems 
clear that the current menu structure is pretty ad hoc and 
disorganized.

   thoughts?

rday
