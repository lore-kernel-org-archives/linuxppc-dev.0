Message-ID: <3C63AE1A.7000907@pacbell.net>
Date: Fri, 08 Feb 2002 10:53:14 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: Stefan Roese <stefan.roese@esd-electronics.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC405gp enet Soft Reset
References: <20020207191741.A26185@ecam.san.rr.com> <EFEAIMDCOOOHIEPHDNFJOEJBDKAA.stefan.roese@esd-electronics.com> <20020208103557.A27732@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


andrew may wrote:

> On Fri, Feb 08, 2002 at 11:03:59AM +0100, Stefan Roese wrote:
>
>>Andrew
>>
>>
>>>I seem to be having a problem with the soft reset of EMAC
>>>mode register when I have no ethernet connection to by phy.
>>>
>>We have the same problem (CPCI-405 with Intel LXT971 PHY).
>>
>
> It is good to see that the problem is known.
>
>
>>>After this code in init_ppc405_enet(void) the SRST bit does
>>>not clear until after I stick in a cable.
>>>
>>See Chapter 19.7.1 in PPC405GP User Manual (EMAC0_MR0):
>>
>
> The prelim hard copies I have been looking at failed to mention
> the clocks need to be active, but I did check the pdf and it is
> in there, so I guees I will try to look more at the soft copy these
> days.
>
>
>>It seems that we can't reset and setup the EMAC correctly without cable
>>connected (no cable == no PHY clock!). So what do we do when this occurs?
>>Disable the driver?
>>
>
> Your joking right? To do that is less than a 10 line hack, that I had to do
> to stop the driver from doing a panic or crashing, but I would not feel
> good about sending that as a patch. The driver needs to be able to handle
> this, but it will take some rework and it would be nice to know if there
> is really a reason to do the SoftReset before probing the phy.
>
>
>
>

Andrew & Stefan,

The softrest could probably be removed from the _init.  its dup'd in _open.



--armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
