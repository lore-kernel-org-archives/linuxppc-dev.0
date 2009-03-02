Return-Path: <mike@it-loops.com>
Received: from lvps87-230-0-242.dedicated.hosteurope.de
	(lvps87-230-0-242.dedicated.hosteurope.de [87.230.0.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "plesk", Issuer "plesk" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 234DFDDF11
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Mar 2009 22:59:05 +1100 (EST)
MIME-Version: 1.0
Date: Mon, 02 Mar 2009 12:58:56 +0100
From: Michael Guntsche <mike@it-loops.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: PHY not found after migration of gianfar driver to an
	=?UTF-8?Q?of=5Fplatform=5Fdriver?=
In-Reply-To: <fa686aa40903011715u2aed4c23tb8182634fa1220f6@mail.gmail.com>
References: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
	<fa686aa40902280703p5ad8ee73y116d7e2252df21a5@mail.gmail.com>
	<3B1D47A2-329E-491E-B3AC-E76C1CE1762D@it-loops.com>
	<fa686aa40903011353t464b1df3obd553132e5bc2570@mail.gmail.com>
	<CD026D29-687D-4078-960E-108CC94C30E4@it-loops.com>
	<fa686aa40903011715u2aed4c23tb8182634fa1220f6@mail.gmail.com>
Message-ID: <c19541729a7d99548faadbabe5c7646c@localhost>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 1 Mar 2009 18:15:32 -0700, Grant Likely <grant.likely@secretlab.ca>
wrote:
> 
> So, what you need is a new adapter which parses the data passed in by
> routerboot (maybe call it routerImage?) and modifies the .dtb blob to
> match.  You can use simpleImage as a starting point.
I had a look at that. And this is what I understood so-far.
SimpleImage just takes the dtb from the segment and parses it as the new
device tree. 

  _dtb_start = .;
  .kernel:dtb : { *(.kernel:dtb) }
  _dtb_end = .;

No I do understand that dtb_start points to this device tree. I also know
that the standard kernel boot-process
is able to read he device tree out of the firmware/bootloader (it works if
I just put with a standard kernel image) but I cannot figure out, where
exactly (in the code) it is doing that. My problem is now that I have zero
documentation of the existing bootloader. All I know is that the prom code
is able to find and parse it.
So now my question, is there a way to get to the device tree at this stage
of the boot process?


>> Can't I just add them in the rbppc.c specific init stuff
programmatically
>> withouth a DTS file?
> 
> You need a device tree.  You could theoretically generate the entire
> tree programmatically, but that is the long way around.  What you want
> is a base .dts file and a new bootwrapper to fill in the missing bits
> at boot time.
Well the board already provides a device tree so all I would need is the
missing entries so the PHYs are detected correctly. So I would modify an
existing tree.


thanks for your help,
Michael
