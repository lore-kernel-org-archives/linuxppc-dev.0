Message-ID: <3F1C8F42.2080703@stinkfoot.org>
Date: Mon, 21 Jul 2003 21:11:30 -0400
From: Ethan Weinstein <e-d0uble@stinkfoot.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: aic7xxx panics (long)
References: <3EFFD86B.7060007@stinkfoot.org>	 <1056957083.32576.112.camel@gaston>  <3F00E86B.1000309@stinkfoot.org>	 <1057053589.32576.310.camel@gaston>  <3F02537C.1090801@stinkfoot.org>	 <1057148769.32104.422.camel@gaston>  <3F04D1EA.6060906@stinkfoot.org>	 <1057590248.11707.62.camel@gaston>  <3F140C6E.2080609@stinkfoot.org>	 <1058278673.515.2.camel@gaston>  <3F140F1E.1050303@stinkfoot.org>	 <1058279423.502.7.camel@gaston>  <3F19C4B2.4030803@stinkfoot.org> <1058830966.11024.10.camel@gaston>
In-Reply-To: <1058830966.11024.10.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> That's weird, things appear to be mapped the same way. The only
> difference I see that could be significant (though it should not)
> is that 2.4.21 actually doesn't enable the IO access (the driver
> is supposed to do only MMIO here). Can you try this patch ? If
> it works, then we might be facing a HW bug...
>
> In drivers/scsi/aix7xxx/aix7xxx_osm_pci.c, line 313, replace:
>
> 	command &= ~(PCIM_CMD_PORTEN|PCIM_CMD_MEMEN);
>
> with
> 	command |= PCIM_CMD_PORTEN|PCIM_CMD_MEMEN;
>
> And tell me if that makes any difference,
>
> Ben.

Ben,

_Exact_ same crash with that patch applied.  I suppose that's good as
it's probably not a HW bug?  What next?


-Ethan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
