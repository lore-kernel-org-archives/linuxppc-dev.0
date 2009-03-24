Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: physmap_of and partitions (mtd concat support)
Date: Tue, 24 Mar 2009 10:07:51 +0100
References: <200903231151.10373.sr@denx.de>
	<fa686aa40903230837w52a9f764n29b3f9cf4c95cc57@mail.gmail.com>
In-Reply-To: <fa686aa40903230837w52a9f764n29b3f9cf4c95cc57@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903241007.51321.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 23 March 2009, Grant Likely wrote:
> On Mon, Mar 23, 2009 at 4:51 AM, Stefan Roese <sr@denx.de> wrote:
> > I just noticed that physmap_of can't handle multiple devices of different
> > type described in one device node. For example the Intel P30 48F4400
> > (64MByte) consists internally of 2 non-identical NOR chips. So a "simple"
>
> [...]
>
> > Now the real problem: How should I describe a partition in the device
> > tree spanning over both devices (concat)?. The current physmap_of driver
> > doesn't handle concat at all (physmap.c does). I already have some ideas
> > on how to implement this concat support in physmap_of. But ideas about a
> > device-tree syntax for such partitions are very welcome.
>
> Sounds to me like a physmap_of driver bug.  I don't think there is any
> advantage in changing the partition syntax since concatenated flash
> will always be used as a single device.  It doesn't make any sense to
> try and span partitions over two nodes.

Yes, I would really love to make this possible with only one flash node. But 
just think about the following system configuration:

One Intel Strataflash (compatible = "cfi-flash") and one non-cfi compatible 
flash (e.g. compatible = "jedec-flash"). And the user wants to define a 
partition that spans over both flash chips. How could this be described in 
one flash node?

> Do additional properties need to be added to describe the concat layout?

Not sure. If we have multiple identical devices they can currently be 
described in one flash node. So with some changes to the physmap_of driver 
this configuration will work with concat as well. But more complex is a 
system configuration as described above. Meaning two or more non-identical 
chips. I don't see how this could be described in a sane way in one flash 
node.

Best regards,
Stefan
