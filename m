Subject: Re: aic7xxx panics (long)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan Weinstein <e-d0uble@stinkfoot.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3F19C4B2.4030803@stinkfoot.org>
References: <3EFFD86B.7060007@stinkfoot.org>
	 <1056957083.32576.112.camel@gaston>  <3F00E86B.1000309@stinkfoot.org>
	 <1057053589.32576.310.camel@gaston>  <3F02537C.1090801@stinkfoot.org>
	 <1057148769.32104.422.camel@gaston>  <3F04D1EA.6060906@stinkfoot.org>
	 <1057590248.11707.62.camel@gaston>  <3F140C6E.2080609@stinkfoot.org>
	 <1058278673.515.2.camel@gaston>  <3F140F1E.1050303@stinkfoot.org>
	 <1058279423.502.7.camel@gaston>  <3F19C4B2.4030803@stinkfoot.org>
Content-Type: text/plain
Message-Id: <1058830966.11024.10.camel@gaston>
Mime-Version: 1.0
Date: 22 Jul 2003 01:42:48 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-07-20 at 00:22, Ethan Weinstein wrote:

> I was able to get my hands on an IDE drive to boot from.
> The lspci -vvv + dmesg's + /proc/device-tree's fom each kernel,
> (2.4.20-ben10 vs. 2.4.21-ben2) is located here:
>
> ftp://stinkfoot.org/for.benh_stinkfoot.org.tar.bz2
>
> Again, I appreciate your help.

That's weird, things appear to be mapped the same way. The only
difference I see that could be significant (though it should not)
is that 2.4.21 actually doesn't enable the IO access (the driver
is supposed to do only MMIO here). Can you try this patch ? If
it works, then we might be facing a HW bug...

In drivers/scsi/aix7xxx/aix7xxx_osm_pci.c, line 313, replace:

	command &= ~(PCIM_CMD_PORTEN|PCIM_CMD_MEMEN);

with
	command |= PCIM_CMD_PORTEN|PCIM_CMD_MEMEN;

And tell me if that makes any difference,

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
