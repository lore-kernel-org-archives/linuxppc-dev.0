From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-dev@lists.linuxppc.org>,
	<yellowdog-devel@lists.yellowdoglinux.com>,
	"Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: new G4 dual 1 gig is here - how to install?
Date: Sat, 16 Feb 2002 20:19:19 +0100
Message-Id: <20020216191919.12832@smtp.wanadoo.fr>
In-Reply-To: <40041092-2284-11D6-9EE3-0003938E434C@ivey.uwo.ca>
References: <40041092-2284-11D6-9EE3-0003938E434C@ivey.uwo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hi Ani and Ben,
>
>I now have the radeonfb driver working.  I had to make the following
>changes:
>
>1. pass "dfp" as the kernel parameters to force use of the DVI port to
>get around the BIOS Scratch register issue (see my last mail message)

I suppose there must be another property in the device tree telling
us about where the monitor is connected to. Anyway, we should sooner
or later have real working i2c code, Ani ?

>2. Change the code that looks for OF EDID to use the following:
>
>dp =
>find_device_path("/pci@f0000000/ATY,BlueStoneParent@10/ATY,BlueStone_A");
>pedid = get_property(dp,"EDID",0);
>
>This is because the pci_device_to_OF_node had dp pointing to
>/pci@f0000000/ATY,BlueStoneParent@10 node where the ATY,RefClk property
>was and not into ATY,BlueStone_A which is where the OF "EDID" info was
>(i.e. changed node structure with a dual head card).

Yes, that's common to all of Apple/ATI dual head drivers like my pismo's,
however, they don't seem to have a clear way of storing the EDID. On my
tipb, it is in an "EDID1" property in the root ATI node.

I beleive until we have working i2c, you keep the old pci_device_to_OF_node
code, then iterate childs of that node (node->child & node->sibling
pointers). The problem here is that you may well end up with 2 EDIDs if
2 monitors are connected at startup... (well, that depends much on what
the OF driver would do).

>This is obviously a hack.  For dual head cards we need to search the
>node we read ATY,RefClk from and all of its children looking for the
>EDID info (but what if both BlueStone_A and BlueStone_B have EDID blocks
>that differ?  Is BlueStone_A always the DVI port?  If so, if no monitor
>is connected to it no EDID is present.  So we could simply look in both
>and use that info to see which ports have EDID blocks which will tell us
>which ports have monitors attached or not (fixing issue 1)

On my tipb, I have a "display-type" property in the child nodes, aybe
that can help figuring out what is what. Though again, real i2c probing
would probably fix that once for all as I bet not 2 ATI cards will layout
their device tree the same way.
>
>3.  I had to stop writing out TMDS_TRANSMITTER_CNTL values which I
>needed with the old G3 B+W and the Radeom Mac 32 card. Writing anything
>to this register value under the 7500 just seems to make the screen go
>blank.

I'll let Ani look at this one.

>I have no idea how to workaround this.  Perhaps you can make it a
>compile time option to either include or not include the
>TMDS_TRANSMITTER_CNTL setting under radeon_write_mode.  Right now I have
>simply commented them out.
>
>With those changes in place we seem to get a very nice console on the
>7500 that can be ordered as an option on the new PowerMac G4's
>
>I will now build XF 420 and get X11 going and once there I will move to
>SMP to start testing those features.

Well, there are other issues what Ani and I will have to deal with, for
example, I think the DAA_xxx registers (or are they DDA_xxx ?) don't exist
on radeon's, at least not on all of them. Also, I want to change the memory
layout of the card (MC_AGP_LOCATION/MC_FB_LOCATION) in some ways I already
discussed with Ani (basically keeping both AGP and FB out of the region
where system memory is seen to allow clean PCI bus master to main memory),
but I have some trouble when I move them around, sometimes depending on
what OF did to the chip just before. I beleive changing those values requires
some sort of reset of part of the chip, along with adequate change of
other pointers like DISPLAY_BASEADDR, SRC_OFFSET, etc... so that those
end up to the new FB location within card's space.

I haven't fixed my power management issue yet neither.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
