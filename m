Date: Fri, 15 Feb 2002 21:24:05 -0500
Subject: Re: new G4 dual 1 gig is here - how to install?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
In-Reply-To: <416D9C76-201E-11D6-BE69-0003938E434C@ivey.uwo.ca>
Message-Id: <40041092-2284-11D6-9EE3-0003938E434C@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ani and Ben,

I now have the radeonfb driver working.  I had to make the following
changes:

1. pass "dfp" as the kernel parameters to force use of the DVI port to
get around the BIOS Scratch register issue (see my last mail message)

2. Change the code that looks for OF EDID to use the following:

dp =
find_device_path("/pci@f0000000/ATY,BlueStoneParent@10/ATY,BlueStone_A");
pedid = get_property(dp,"EDID",0);

This is because the pci_device_to_OF_node had dp pointing to
/pci@f0000000/ATY,BlueStoneParent@10 node where the ATY,RefClk property
was and not into ATY,BlueStone_A which is where the OF "EDID" info was
(i.e. changed node structure with a dual head card).

This is obviously a hack.  For dual head cards we need to search the
node we read ATY,RefClk from and all of its children looking for the
EDID info (but what if both BlueStone_A and BlueStone_B have EDID blocks
that differ?  Is BlueStone_A always the DVI port?  If so, if no monitor
is connected to it no EDID is present.  So we could simply look in both
and use that info to see which ports have EDID blocks which will tell us
which ports have monitors attached or not (fixing issue 1)

3.  I had to stop writing out TMDS_TRANSMITTER_CNTL values which I
needed with the old G3 B+W and the Radeom Mac 32 card. Writing anything
to this register value under the 7500 just seems to make the screen go
blank.

I have no idea how to workaround this.  Perhaps you can make it a
compile time option to either include or not include the
TMDS_TRANSMITTER_CNTL setting under radeon_write_mode.  Right now I have
simply commented them out.

With those changes in place we seem to get a very nice console on the
7500 that can be ordered as an option on the new PowerMac G4's

I will now build XF 420 and get X11 going and once there I will move to
SMP to start testing those features.

Hope this info helps,

Kevin


On Tuesday, February 12, 2002, at 08:08 PM, Kevin B. Hendricks wrote:

>
> Hi,
>
> Okay my new G4 1 gig box has finally arrived after sitting in Canadian
> customs for close to 5 days for no real good reason.
>
> So I made the kernel changes Ben indicated and built a kernel (up not
> smp to start) and since everything is installed on a external scsi drive
> I tried the following:
>
> I simply unplugged the scsi chain and installed it on the new machine.
> I then held down the option key to get the menu and sure enough the nice
> linux disk icon showed in the of menu.
>
> When I select it I immediately get the prompt for linux, mac, or cdrom
> boot but as soon as I hit l for linux it recycles.
>
> Obviously it can find the script partion and show it to me but it can
> not seem to find yaboot or the root linux partition (on that same drive)
> so perhaps some internal of path is set somehow that differs from my old
> machine to my new machine.
>
> So what is the best way to get linux working on this thing.  Since
> kernel changes are needed to recognize the new 7455 chip, none of the
> canned installers from SuSE, or YellowDog will work, will they?
>
> Do I have to roll my own installer with the fixed kernel just to get
> linux going?  If so, how  do I go about rolling my own installer image
> from the kernel I have built with the 7455 code changes in place?
>
> Ideas anyone.   I really thought since my current installation in on
> external scsi that the option startup trick would work (and it does run
> the script but yaboot does not seem to get properly launched.
>
> Hope someone can help since I have to give my old machine to my wife
> soon (or she will lynch me) so I really want to get linux up on my new
> machine before my old machine goes to her.
>
> Any helpful hints would be greatly appreciated.
>
> Thanks,
>
> Kevin
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
