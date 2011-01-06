Return-Path: <scottwood@freescale.com>
Date: Thu, 6 Jan 2011 14:10:23 -0600
From: Scott Wood <scottwood@freescale.com>
To: Meador Inge <meador_inge@mentor.com>
Subject: Re: [RFC] MPIC Bindings and Bindings for AMP Systems
Message-ID: <20110106141023.43a0d35f@udp111988uds.am.freescale.net>
In-Reply-To: <4D252FDC.4090404@mentor.com>
References: <4D12E4F1.2030004@mentor.com>
	<20110103142200.738c0b17@udp111988uds.am.freescale.net>
	<4D252FDC.4090404@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	"Blanchard, Hollis" <Hollis_Blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 5 Jan 2011 20:58:36 -0600
Meador Inge <meador_inge@mentor.com> wrote:

> On 01/03/2011 02:22 PM, Scott Wood wrote:
> > On Wed, 22 Dec 2010 23:58:09 -0600
> > Perhaps a something like this, with "doorbell" being a new standard
> > hw-independent service with its own binding:
> >
> > msg1: mpic-msg@1400 {
> > 	compatible = "fsl,mpic-v3.0-msg";
> > 	reg =<0x1400 0x200>;
> > 	interrupts<176 2 178 2>;
> >
> > 	// We have message registers 0 and 2 for sending,
> > 	// and 1 and 3 for receiving.
> > 	// If absent, we own all message registers in this block.
> > 	fsl,mpic-msg-send-mask =<0x5>;
> > 	fsl,mpic-msg-receive-mask =<0xa>;

Alternatively, we could describe available ranges similarly to the
existing MSI binding.

> After thinking about it a little more, I like the idea of having a 
> 'receive-mask' to further partition the message register blocks.  This 
> would also allow us to remove IRQs from the 'interrupts' property that 
> are not being used on a given node.  As for the 'send-mask', why would 
> we want to block sending messages?  It seems to me that it would be 
> reasonable to allow a node to send a message to any other node.

The send-mask, like the receive-mask, is optional.  If for your
application it makes sense to give all partitions send access to all
doorbells, then you can do that.

You might want to provide a send-mask if you are not specifying to the
partition how to use the message registers, just splitting them up for
their own internal use (especially if you have a larger multicore system
where each partition has multiple CPUs).

Or, you may want to add a layer of robustness against one partition
interfering with a message register that is only supposed to be used by
another partition, even if there are instructions elsewhere about which
message register to use for what purpose.

Plus, it provides symmetry between send and receive -- otherwise, you'd
have a numberspace that is limited to your own resources on receive,
but a global numberspace on send.

> As an example, consider a four core system.  Then we might have 
> something like (only relevant DTS bits shown):
> 
> Core 0:
>     mpic-msgr-block@1400 {
>        // Receives messages on registers 1 and 3.
>        interrupts = <0xb1 2 0xb3 2>;
>        receive-mask = <0xa>;
>     };
> Core 1:
>     mpic-msgr-block@1400 {
>        // Receives messages on register 2.
>        interrupts = <0xb2 2>;
>        receive-mask = <0x4>;
>     };
> Core 2:
>     mpic-msgr-block@1400 {
>        // Receives messages on register 0.
>        interrupts = <0xb0 2>;
>        receive-mask = <0x1>;
>     };
> Core 3:
>     mpic-msgr-block@1400 {
>        // Receives no messages.
>        interrupts = <>;
>     };

For core 3 I'd just leave out the node entirely.  Note that the absence
of a receive-mask indicates that all the registers are available (i.e.
normal unpartitioned case), not none.

-Scott
