Message-Id: <v03110700b4fd7d5f5f42@[129.100.29.243]>
In-Reply-To: <Pine.LNX.4.21.0003212100450.1173-100000@idd-01.imbc.gr>
References: <20000321112355.A5368@rogue.genunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 21 Mar 2000 14:39:31 -0500
To: Kostas Gewrgiou <gewrgiou@imbc.gr>, anthony tong <atong@uiuc.edu>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: Patches to fix aty128fb and xf400 r128 to work with both
 Rage128  and Rage128Pros
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

>> I think that we can assume a 29.50 clock *for now*; lower clocks are
>> probably for future low powered/mobile versions of the chip.
>>
>
>  Well in my x86 machine the ati card uses a lower clock now
>if cards with a clock different than 29.50MHz are used in Macs
>or not is another matter.
>
>(--) r128(0): Chipset: "ATI Rage 128 RF (AGP)" (ChipID = 0x5246)
>(--) r128(0): VideoRAM: 32768 kByte (64-bit SDR SGRAM 2:1)
>(II) r128(0): PLL parameters: rf=1432 rd=31 min=12500 max=25000; xclk=6000

>From reading the Rage 128 register pdf info, there is one interesting
constraint that may help us here.

As it turns out you can read the M, Nx, and Nm values from the
X_MPLL_REF_FB_DIV register and it is used in the following constraints:

REF >= 40 * M    (from REF/M >= 400khz)

REF >= 625 * M / min(Nx,Nm)   (from 125MHZ <= PLLCLK <= 250MHZ
                                 for xpllclk, and mpllclk)

REF <= 1250 * M / max(Nx,Nm)  (ditto)


So we should be able to check each ratio and eliminate and the values of
REF that don't meet this constraint.

There are probably other constraints as well.  I will keep looking.  Maybe
in some combination, we can rule out all but one value for REF  (he said
hopefully...with his fingers crossed).

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
