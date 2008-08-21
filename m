Return-Path: <jonsmirl@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id E70A6DF3C8
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 07:53:04 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so120316pyi.27
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 14:53:02 -0700 (PDT)
Message-ID: <9e4733910808211453t63f0a6f5h2139e027319263f1@mail.gmail.com>
Date: Thu, 21 Aug 2008 17:53:02 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
In-Reply-To: <20080821.001012.265401427.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080821.001012.265401427.davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/21/08, David Miller <davem@davemloft.net> wrote:
>
>  I'm working on some drivers for I2C bus support on some of my sparc64
>  workstations (for lm-sensor and eeprom type devices sitting behind
>  them) so I went back to trying to get of_i2c.c usable on sparc.
>
>  Mostly straightforward stuff _except_ for the I2C address encoding.
>
>  What I2C IEEE1275 device binding was used to write that code in
>  of_i2c.c?  Is it some PowerPC specific thing?  Was it "invented"
>  by the embedded folks (I hope not)?
>
>  On sparc, the encoding is either 1 cell or 2 cell.
>
>  If it's one cell, it's just the device address.
>
>  If it's two cells, it's a bus number (for I2C controllers that
>  can manage multiple I2C bus segments, think PCI domains) in the
>  first cell and the device address in the second cell.
>
>  And, furthermore, the device address is shifted up 1 bit higher
>  than the Linux I2C layer expects.  It includes the low direction
>  bit, bit 0, so we have to shift it down by 1 bit before we give
>  it to the Linux I2C layer.
>
>  Does PowerPC really encode these things differently?  And if so what
>  IEEE1275 I2C device binding specification covers that?
>
>  If PowerPC really does encode the device address in the same format as
>  the Linux I2C layer expects, that's OK and I used some property tests
>  and ifdefs to make it all work out.  What I did in these patches is:
>
>  1) Check the #address-cells property.  If not present, assume the value
>    is "1".  Only accept values of "1" and "2".
>
>  2) When CONFIG_SPARC, shift the device address down by one bit before
>    giving it to the Linux I2C layer.

How do you deal with a 10-bit address i2c device? Is it multiplied by two too?

Here's the i2c spec,
http://www.semiconductors.philips.com/acrobat_download/literature/9398/39340011.pdf
 It says the basic addresses are 7 bit.

>  I haven't added support to the I2C layer for the bus number yet, that
>  will come later.
>
>  The first patch in this series add the powerpc-compat IRQ probing
>  interfaces, mostly straightforward stuff as we precompute these
>  IRQs in of_device objects so we just search for the of_device corresponding
>  to the device node and return the interrupt, if any.  Dispost is a NOP.
>
>  The second patch deals with the addressing issues described above and
>  lets it be compiled on non-ppc systems.
>
>  The third patch adds device modaliases for a couple of I2C chip devices
>  I've seen on my SunBlade2500 workstation.  More will come later as I
>  flesh out my I2C sparc64 drivers which are not being posted here yet.
>  I have a fully functional Sun pcf8584 I2C bus driver.
>
>  Signed-off-by: David S. Miller <davem@davemloft.net>
>


-- 
Jon Smirl
jonsmirl@gmail.com
