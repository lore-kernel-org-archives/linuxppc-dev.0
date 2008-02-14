Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-108.bluehost.com (outbound-mail-108.bluehost.com
	[69.89.22.8]) by ozlabs.org (Postfix) with SMTP id 524F7DDFD4
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 05:46:06 +1100 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: /proc/bus/pci and domains
Date: Thu, 14 Feb 2008 10:39:11 -0800
References: <mj+md-20080213.154522.9237.albireo@ucw.cz>
	<20080214044323.GB1176@kroah.com>
	<mj+md-20080214.093558.3352.nikam@ucw.cz>
In-Reply-To: <mj+md-20080214.093558.3352.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802141039.12045.jbarnes@virtuousgeek.org>
Cc: Greg KH <greg@kroah.com>, paulus@samba.org, anton@samba.org,
	Martin Mares <mj@ucw.cz>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday, February 14, 2008 1:40 am Martin Mares wrote:
> Hi Greg!
>
> > I have no idea, it sounds like a PPC specific thing, not anything the
> > PCI core does, right?  So I'll add the ppc list to the cc: and ask if
> > anyone there has any ideas?
>
> Unfortunately, this is not PPC specific at all -- proc_attach_device()
> calls pci_proc_domain(bus), which is an arch-specific hook turning on
> the weird behavior I described. This hook can return non-zero even on
> x86 if there are buses outside domain 0.
>
> I think that the hook itself is correct, it only should trigger more
> consistent behavior of the generic code :)
>
> Would it be acceptable for the PPC folks to modify the code to add
> domain numbers to the device numbers in /proc/bus/pci/devices in the
> same format as the bus directories already have?
>
> If so, I will cook up a patch.

I've run into this too, on machines with many domains.  It's unfortunate that 
there's no way to preserve compatibility, but I agree that the brokenness may 
as well be consistent.

Jesse
