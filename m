Message-Id: <l03130300b6ec56671fa7@[24.218.240.205]>
In-Reply-To: 
 <Pine.A41.3.96LJ1.1b7.1010328152002.32200D-100000@unlserve.unl.edu>
References: <20010328070644.8D1F9DB9D3@atlas.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 31 Mar 2001 23:01:44 -0500
To: <linuxppc-dev@lists.linuxppc.org>
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: Sound stoppage
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


First, I've recently discovered that the problem isn't limited to sound.
I've also noticed that my Adaptec SCSI card has bouts of timeouts.
Something I wasn't aware of before.

Ok, so I had a sec this weekend and I wanted to quickly see if the PCI
timing hack that Ben described worked. Now, perhaps I wrote it wrong, but I
noticed that I still get the sound stoppage as well as disk burps. Nothing
seems to have improved :-(

I'm hacking on a 2.2 snapshot at the moment (yes, yes, I'll get 2.4 as soon
as I can!) :-)

Here's a snippet I added to the end of init_bandit() in pmac_pci.c:

#define BANDIT_POWERCENTER_HACK_ADDR	0x58
#define BANDIT_POWERCENTER_HACK_DATA	0x12

#if 1
	/* PowerCenter PCI timing hack */
	out_le32(bp->cfg_addr, (1UL << BANDIT_DEVNUM) +
BANDIT_POWERCENTER_HACK_ADDR);
	udelay(2);
	out_8(bp->cfg_data, BANDIT_POWERCENTER_HACK_DATA) ;
	printk(KERN_INFO "PowerCenter PCI timing hack enabled.\n") ;
#endif

Any thoughts?




____________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
____________________________________________________________________


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
