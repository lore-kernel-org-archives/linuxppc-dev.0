Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40806081628s2632bcb3he21b26e49873a65f@mail.gmail.com>
Date: Sun, 8 Jun 2008 17:28:59 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Comments on device tree for pcm030
In-Reply-To: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 8, 2008 at 1:08 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Why not a compatible field in the top of the tree? Then you wouldn't
> need to list the boards in mpc5200_simple.c.
>        compatible = "phytec,pcm030","simple-mpc5200";

Here's the problem; what does compatible really mean at the board
level?  Does it mean the board has 100% of the same capabilities?
Does it mean that it uses the same chip?  Does it mean that the chip
is configured in a particular way?  It is really hard to define what a
compatible value means at the board level.  The meaning of compatible
at the device level is very well defined, but that meaning does not
extend well to the board level.

Therefore, it is best to be conservative here and require a specific
list of supported boards in platform code.

Besides, it is really a Linux specific thing that is trying to be
described.  In Linux, we've decided to support as many 5200 boards as
possible using the same platform code, but that may not be true, or it
may be a different set of boards, when a different OS is used.  To
attempt to encode those decisions is overreaching the intent of using
the device tree.

>
> Device tree has an entry for AC97 on PSC1. I don't think the Phytec
> module or carrier board has AC97 hardware.

Might be a bug

> The RTC chip says pcf8563, phytec doc says it is a pcf8564.

Sounds like a bug

>
> There should be an i2c entry for the eeprom but I don't know the part
> number for it.

Yes, i2c devices should be described.

> What about the flash on the local bus?  Could we use something like
> this, or the same without the partition data?

Yes, I believe there is code in place to support this.
>
>        lpb@ff000000 {
>                compatible = "fsl,lpb";
>                ranges = <0 ff000000 01000000>;
>
>                flash@00000000 {
>                        compatible = "cfi-flash";
>                        reg = <00000000 01000000>;
>                        bank-width = <2>;
>                        #size-cells = <1>;
>                        #address-cells = <1>;
>                        partition@0 {
>                                label = "ubootl";
>                                reg = <00000000 00040000>;
>                        };
>                        partition@40000 {
>                                label = "kernel";
>                                reg = <00040000 001c0000>;
>                        };
>                        partition@200000 {
>                                label = "jffs2";
>                                reg = <00200000 00D00000>;
>                        };
>                        partition@f00000 {
>                                label = "uboot";
>                                reg = <00f00000 00040000>;
>                        };
>                        partition@f40000 {
>                                label = "oftree";
>                                reg = <00f40000 00040000>;
>                        };
>                        partition@f80000 {
>                                label = "space";
>                                reg = <00f80000 00080000>;
>                        };
>                };
>        };

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
