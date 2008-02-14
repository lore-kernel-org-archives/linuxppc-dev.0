Return-Path: <mj+f-140208+linuxppc-dev=ozlabs.org@ucw.cz>
Received: from nikam.ms.mff.cuni.cz (nikam-dmz.ms.mff.cuni.cz [195.113.20.16])
	by ozlabs.org (Postfix) with ESMTP id 4A537DDF44
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 21:13:22 +1100 (EST)
Date: Thu, 14 Feb 2008 10:40:22 +0100
From: Martin Mares <mj@ucw.cz>
To: Greg KH <greg@kroah.com>
Subject: Re: /proc/bus/pci and domains
Message-ID: <mj+md-20080214.093558.3352.nikam@ucw.cz>
References: <mj+md-20080213.154522.9237.albireo@ucw.cz>
	<20080214044323.GB1176@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080214044323.GB1176@kroah.com>
Cc: linuxppc-dev@ozlabs.org,
	Linux-PCI Mailing List <linux-pci@atrey.karlin.mff.cuni.cz>,
	paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Greg!

> I have no idea, it sounds like a PPC specific thing, not anything the
> PCI core does, right?  So I'll add the ppc list to the cc: and ask if
> anyone there has any ideas?

Unfortunately, this is not PPC specific at all -- proc_attach_device()
calls pci_proc_domain(bus), which is an arch-specific hook turning on
the weird behavior I described. This hook can return non-zero even on
x86 if there are buses outside domain 0.

I think that the hook itself is correct, it only should trigger more
consistent behavior of the generic code :)

Would it be acceptable for the PPC folks to modify the code to add
domain numbers to the device numbers in /proc/bus/pci/devices in the
same format as the bus directories already have?

If so, I will cook up a patch.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Dijkstra probably hates me." -- /usr/src/linux/kernel/sched.c
