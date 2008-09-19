Return-Path: <glikely@secretlab.ca>
Date: Fri, 19 Sep 2008 00:44:58 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
Subject: Re: Device tree configuration for I2C eeprom
Message-ID: <20080919074458.GA7602@secretlab.ca>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F7B6@tanisys-ex2.Tanisys.Local>
	<20080918221335.GA6420@Chamillionaire.breakpoint.cc>
	<9e4733910809181521r3cd74119tfedd36567e3b5394@mail.gmail.com>
	<20080919050441.GD25528@secretlab.ca>
	<20080919071238.GA8773@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080919071238.GA8773@Chamillionaire.breakpoint.cc>
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

On Fri, Sep 19, 2008 at 09:12:38AM +0200, Sebastian Siewior wrote:
> * Grant Likely | 2008-09-18 22:04:41 [-0700]:
> 
> >No, don't use the generic chip names.  Device tree convention is to be
> >specific and prefix the part number with the vendor name.  ie. You should
> >be using "at,at24c64", not "24c64".
> 
> What about the i2c drivers which don't have any prefix like the m41t80?
> Prior commit 0d1cde2 aka "powerpc/i2c: Convert i2c-mpc into an
> of_platform driver" the ids were converted.

Important Concept:  If the driver can't match with nodes that conform with
the device tree binding conventions, then it is a *Linux/device driver* bug;
not a device tree bug.  The device tree describes hardware.  It does not
describe the device driver implementation.

Do not fall into the temptation of writing the device tree to reflect
the current implementation of the operating system.  Stick to
established conventions and documented bindings.

That being said, it is a non-issue in this case.  The current Linux OF
support code automagically strips off the manufacturer prefix when
registering I2C devices.  Take a look at of_modalias_node() in
drivers/of/base.c for details.

g.
