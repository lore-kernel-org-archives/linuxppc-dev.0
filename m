Return-Path: <glikely@secretlab.ca>
Date: Thu, 18 Sep 2008 22:04:41 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Device tree configuration for I2C eeprom
Message-ID: <20080919050441.GD25528@secretlab.ca>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F7B6@tanisys-ex2.Tanisys.Local>
	<20080918221335.GA6420@Chamillionaire.breakpoint.cc>
	<9e4733910809181521r3cd74119tfedd36567e3b5394@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910809181521r3cd74119tfedd36567e3b5394@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Ayman El-Khashab <AymanE@tanisys.com>, devicetree-discuss@ozlabs.org,
	Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 18, 2008 at 06:21:36PM -0400, Jon Smirl wrote:
> On Thu, Sep 18, 2008 at 6:13 PM, Sebastian Siewior
> <linuxppc-embedded@ml.breakpoint.cc> wrote:
> >>                                eeprom@50 {
> >>                                        compatible = "?????";
> >>                                                   something
> >>                                        something;
> >>                                };
> >
> > This should look like:
> > |                                eeprom@50 {
> > |                                        compatible = "eeprom";
> 
> 
> The new eeprom driver is at24, eeprom is the old one. at24 has write support.
> 
> EEPROMs from most vendors (AT24)
> 
> Enable this driver to get read/write support to most I2C EEPROMs,
> after you configure the driver to know about each EEPROM on
> your target board. Use these generic chip names, instead of
> vendor-specific ones like at24c64 or 24lc02:
> 
> 24c00, 24c01, 24c02, spd (readonly 24c02), 24c04, 24c08,
> 24c16, 24c32, 24c64, 24c128, 24c256, 24c512, 24c1024

No, don't use the generic chip names.  Device tree convention is to be
specific and prefix the part number with the vendor name.  ie. You should
be using "at,at24c64", not "24c64".

g.
