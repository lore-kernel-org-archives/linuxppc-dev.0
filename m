Date: Thu, 21 Mar 2002 14:15:25 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] Re: EV-64260-BP & GT64260 bi_recs
Message-ID: <20020321141524.U6003@altus.drgw.net>
References: <0203200102.AA08371@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0203200102.AA08371@ivan.Harhan.ORG>; from msokolov@ivan.Harhan.ORG on Tue, Mar 19, 2002 at 05:02:56PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Point well taken and you're right, perhaps the cmd_line is a better way to
> > pass in hdx/fdx & speed, phy addr & is_rmii.
>
> The PHY address and MII vs. RMII are things fixed by board circuitry and would
> normally be hard-coded. The only reason I added them to BI_GT64260_ETH_CFG was
> because I imagined the #ifdef maze that would otherwise eventually grow in the
> gt64260_eth driver as people add ports to different boards with these things
> wired differently.

If we get an #ifdef maze, this is an indication we need to re-think how
gt64260 is done. My suggestion is a struct that the platform/*_setup.c
file can give to the eth driver somehow that specifies all this stuff.

I would really like the gt64260 eth and serial drivers to be useable on
mips also.. so we need to find someone with a mips 64240 board..

FYI, the gt eth driver is completely busticated for SMP. I managed to get
zuma's mpsc driver working on SMP by turning on snooping. (this may be the
'wrong' thing to do , but it works for now)

> As for speed, etc. no other driver I know of requires the bootloader to pass
> this info. It's normally set by ethconfig, miitool, etc. Please don't add that
> in there, I have no slightest idea what to put in those fields if they were in
> the bi_rec.

I agree 100% on this.

The only thing we *HAVE* to find out from the firmware is the MAC address.



--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
