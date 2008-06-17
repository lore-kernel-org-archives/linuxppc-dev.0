Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from IE1EHSOBE004.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id B541CDDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 07:31:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Loading drivers based on board identification
Date: Tue, 17 Jun 2008 14:31:03 -0700
In-Reply-To: <20080617202656.GA10957@sirena.org.uk>
References: <20080617202656.GA10957@sirena.org.uk>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Mark Brown" <broonie@opensource.wolfsonmicro.com>,
	<linuxppc-dev@ozlabs.org>
Message-ID: <20080617213105.4F96911D8063@mail23-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Mark,

I'm very interested in trying to factor out board data from the device
tree, but for slightly different reasons, I think.  (Although I don't
exactly understand what you're proposing...)

In FPGA-based designs, it would be nice to be able to describe a device
tree fragment for the board, which includes things like PCI interrupt
maps, ethernet phy information and i2c bus information and orthogonalize
it from the information in the FPGA (which should only be dependent on
the IP in the FPGA).  This should allow the generation of the FPGA
device tree to be independent of the board.

I don't yet have a proposal, but I'd be curious to hear your thoughts.

Steve

> -----Original Message-----
> From: linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of Mark
Brown
> Sent: Tuesday, June 17, 2008 1:27 PM
> To: linuxppc-dev@ozlabs.org
> Subject: Loading drivers based on board identification
> =

> Recently there's been quite a bit of discussion surrounding how to set
> up machine specific hardware that can't readily be represented in the
> device tree.  I was wondering if one way of solving these problems
might
> be to provide a mechanism for drivers to load based on board type
rather
> than by binding to nodes in the device tree, similar to DMI on x86
> systems?
> =

> The particular case that this has been cropping up for is ASoC machine
> drivers - these are drivers which specify how the components of an
> embedded audio subsystem (each of which has its own driver) should be
> used together to make a functional ALSA device.  Broadly, it will say
> something along the lines of "The audio codec at this I2C address is
> connected to one or more SSI ports on the SoC and these are clocked in
> the following way", though it can get much more complex.
> =

> This isn't a property of any of the component devices - it's all about
> the relationships between these devices - and it gets sufficiently
> complex in many systems that it's not realistic to try to encode it in
> the device tree.  There is normally no specific hardware associated
with
> this that isn't controlled by one of the component drivers which makes
> it difficult to fit into the device tree - in hardware terms this
> roughly corresponds to the physical board the system is on.
> =

> Since this is difficult to represent in an idiomatic way in the device
> tree probing based on the board type seems like reasonable solution.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
