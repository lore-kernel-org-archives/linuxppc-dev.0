Return-Path: <xyzzy@speakeasy.org>
Date: Thu, 31 Jul 2008 18:16:49 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
In-Reply-To: <48922BE4.5030507@freescale.com>
Message-ID: <Pine.LNX.4.58.0807311806560.10341@shell4.speakeasy.net>
References: <20080731182810.GB29097@secretlab.ca>
	<48921888.3020900@grandegger.com>
	<48921954.4020103@freescale.com>  <48921DED.6010403@grandegger.com>
	<9e4733910807311332q611b43b3y26f64b5269ccb657@mail.gmail.com>
	<fa686aa40807311335t1dd123d0mc385234ebe55248@mail.gmail.com>
	<48922273.6070801@freescale.com> <20080731204838.GA29834@secretlab.ca>
	<9e4733910807311355q3394b4bfg66c37055384451f7@mail.gmail.com>
	<48922715.2000304@freescale.com>
	<9e4733910807311403o63c37366ldae30e873f33a21e@mail.gmail.com>
	<48922B40.3010808@grandegger.com> <48922BE4.5030507@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>,
	Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 31 Jul 2008, Timur Tabi wrote:
> Wolfgang Grandegger wrote:
>
> > U-Boot does not (yet) use the FDT and it has therefore to use that ugly
> > code to derive the I2C input clock frequency. I think its completely
> > legal to put that hardware specific information into the FDT and get rid
> > of such code.
>
> Huh?  U-Boot initializes several fields and creates several properties in the
> FDT today, so what's wrong with adding another one?  The clock frequencies have
> always been calculated by U-Boot, because putting them in the device tree is a
> bad idea.

I think Wolfgang means u-boot doesn't _read_ information from the device
tree.  Put the I2C source clock into the device tree and have u-boot read it
in.

But that simply doesn't work at all.  The i2c source clock isn't constant.
It's not a constant divider from the core clock either.  Flip a dip switch,
and the divider changes.

But that's irrelevant.  U-boot needs to configure the i2c controller to
read SPD data from the DIMM's EPROM, which is necessary to get DRAM
working.  That happens long long before the FDT is loaded via TFTP,
y-modem, NFS, or from disk or flash.  Might as well have u-boot get the i2c
source clock via Linux's sysfs.
