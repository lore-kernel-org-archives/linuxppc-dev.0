Message-Id: <v03110701b4fd85022a6d@[129.100.29.243]>
In-Reply-To: <v03110700b4fd7d5f5f42@[129.100.29.243]>
References: <Pine.LNX.4.21.0003212100450.1173-100000@idd-01.imbc.gr>
 <20000321112355.A5368@rogue.genunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 21 Mar 2000 15:06:39 -0500
To: Kostas Gewrgiou <gewrgiou@imbc.gr>, anthony tong <atong@uiuc.edu>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: Patches to fix aty128fb and xf400 r128 to work with both
 Rage128  and Rage128Pros
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,


Whoops I am off by a factor of 10 in conmstraints 2 and 3 below

>REF >= 625 * M / min(Nx,Nm)   (from 125MHZ <= PLLCLK <= 250MHZ

Should be REF >= 6250 * M / min(Nx,Nm)


>REF <= 1250 * M / max(Nx,Nm)  (ditto)

Should be REF <= 12500 * M / max(Nx,Nm).

Using the values from my Rage128Pro

X_MPLL_REF_FB_DIV = 0xe88a3a

so
Nm = 0xe8 = 232
Nx = 0x8a = 138
M = 0x3a = 58

So

REF >= (40 * 58) = 2320  (so this rules out the 14.32 MHZ version)

REF >= 6250 * 58 / min(232,138) = 2626

REF <= 12500 * 58 / max(232,138) = 3125


So unfortunately, we still need another constraint to select between the
29.50 MHZ REF value and the 28.63 MHZ REF value.  They may be so close that
we won't be able to ever tell them apart.

I will keep looking.

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
