Return-Path: <dgibson@ozlabs.org>
Date: Wed, 3 Sep 2008 09:42:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: DTS question
Message-ID: <20080902234207.GB9681@yookeroo.seuss>
References: <48BDB68E.8040806@mlbassoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48BDB68E.8040806@mlbassoc.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 02, 2008 at 03:56:30PM -0600, Gary Thomas wrote:
> Following on with my RTC problem, I cut&pasted this from
> the TQM5200 dts file:
>                 i2c@3d40 {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         compatible = "fsl,mpc5200-i2c","fsl-i2c";
>                         reg = <0x3d40 0x40>;
>                         interrupts = <2 16 0>;
>                         interrupt-parent = <&mpc5200_pic>;
>                         fsl5200-clocking;
>
>                          rtc@68 {
>                                 device_type = "rtc";
>                                 compatible = "dallas,ds1307";
>                                 reg = <0x68>;
>                         };
>                 };
>
> However, the dts file I started with had this (*mine*):
> 		i2c@3d40 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			compatible = "fsl,mpc5200-i2c","fsl-i2c";
> 			cell-index = <1>;
> 			reg = <3d40 40>;
> 			interrupts = <2 10 0>;
> 			interrupt-parent = <&mpc5200_pic>;
> 			fsl5200-clocking;
> 		};
>
> Notice the different mix of hex (0xNNN) and implied hex values.
> This is really confusing to me.  Even more so when I added the
> RTC snippet cut directly from the TQM5200 file:
>
>                          rtc@68 {
>                                 device_type = "rtc";
>                                 compatible = "dallas,ds1307";
>                                 reg = <0x68>;
>                         };
>
> This yielded a syntax error when merged with my platform dts.
> When I changed the 'reg=<0x68>' to 'reg=<68>', the syntax error
> went away & it worked perfectly.
>
> What gives?  Why is explicit hex sometimes an error and sometimes not?

Because we changed the format at one point.  Originally (the "dts-v0"
format) it was implicitly hex everywhere, which turned out to be a
mistake.  So we introduced the new dts-v1 format which uses C-style
literals.  New-style files are marked with a /dts-v1/; token at the
top of the file.

> Is the format of this file documented anywhere (I've not found it)?

It's in Documentation/dts-format.txt in the dtc tree.  I don't think
that's been included in the version of dtc in the kernel tree, though,
so you'll need to download the standalone dtc.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
