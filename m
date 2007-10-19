Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 57082DDEEC
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 05:56:30 +1000 (EST)
Date: Fri, 19 Oct 2007 21:56:25 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: FDT bindings for I2C devices
In-Reply-To: <fa686aa40710190738q1211a266lced10ac8767e5071@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0710192150561.8474@axis700.grange>
References: <4718BB40.2050901@grandegger.com>
	<fa686aa40710190738q1211a266lced10ac8767e5071@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(it was suggested to deprecate -embedded in favour of -dev, so, added to 
cc:)

On Fri, 19 Oct 2007, Grant Likely wrote:

> On 10/19/07, Wolfgang Grandegger <wg@grandegger.com> wrote:
> > Hello,
> >
> > is it forseen to define and configure devices like RTC, temperature
> > sensors or EEPROM on the I2C bus with the Flat Device Tree? If yes, how
> > would the DTS entries look like?
> 
> booting-without-of.txt has some information about describing the controller.
> 
> Scott Wood made an attempt at defining a device binding for I2C
> devices, but it has not been merged into booting-without-of.txt yet.
> I've copied what he wrote below.  I would add to his definition the
> following:
> - If compatible is missing, driver should *not* fall back to the device name.
> - 'compatible' list should include the exact device in the form "<mfg>,<part>"

There are also already working examples in powerpc: look at 
arch/powerpc/sysdev/fsl_soc.c at the i2c_devices[] array and how it is 
used below. There are also some .dts examples upstream already, e.g., 
arch/powerpc/boot/dts/kuroboxH[GD].dts. There also have been more patches 
recently to add further devices to the table and further .dts entries. 
Notice however, it would be good to move the generic code out of 
fsl_soc.c, as there seems to be increasing interest in describing i2c 
buses in .dts.

Thanks
Guennadi
---
Guennadi Liakhovetski
