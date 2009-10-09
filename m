Return-Path: <ncase@xes-inc.com>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
From: Nate Case <ncase@xes-inc.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40910082240w7fb2a194tcc80e7afe182e781@mail.gmail.com>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<20091008143301.GA6084@oksana.dev.rtsoft.ru>
	<fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
	<20091008151007.GA21328@oksana.dev.rtsoft.ru>
	<fa686aa40910080848r459c47baob73fc70a95a08604@mail.gmail.com>
	<20091008202723.GA8116@pengutronix.de>
	<20091009051409.GA2361@pengutronix.de>
	<fa686aa40910082240w7fb2a194tcc80e7afe182e781@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 09 Oct 2009 09:01:11 -0500
Message-Id: <1255096871.16018.49.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: devicetree-discuss@ozlabs.org, linux-embedded@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-10-08 at 23:40 -0600, Grant Likely wrote:
> For your future reference, patches that look at the device tree should
> also cc: devicetree-discuss@lists.ozlabs.org so that new bindings can
> be reviewed and common mistakes can be avoided.  It is expected that
> new device tree bindings are accompanied with documentation describing
> what the binding is for and how it should be used (see
> Documentation/powerpc/dts-bindings).
> 
> I know this change is already in mainline, but can you please post the
> device tree fragment that you're using to describe this chip?  I want
> to make sure we don't get stuck with things in the kernel that will be
> hard to maintain in the long term.

Hi Grant,

Sorry for neglecting to include devicetree-discuss on that one.  I was
in fact aware of this list, and subscribe to it.  I really just forgot
in this case.

I also have a documentation patch for it that went along with it, but it
wasn't ready in time and so it's been sitting in our local patch queue.
I can submit that soon,  but it probably makes sense for Wolfram to
voice whatever his concerns were about "questionable" properties before
I document what's there.

Here's an example device tree node for this case:

               gpio1: gpio@18 {
                        compatible = "nxp,pca9557";
                        reg = <0x18>;
                        #gpio-cells = <2>;
                        gpio-controller;
                        polarity = <0x00>;
               };

In this case, the linux,gpio-base property wasn't specified.  But, the
use case is identical to the pdata->gpio_base field.  "polarity" is used
for specifying polarity inversion for each line, and is in the same
format of the 'polarity inversion' register on the chip.  My reasoning
in the property naming was as follows:

    linux,gpio-base: Linux-specific as it relates to internal GPIO
                     numbering.  So, it's prefixed with "linux,"
    polarity: Dictated by how hardware is wired up, so it's needed
              regardless of the OS.

- Nate
