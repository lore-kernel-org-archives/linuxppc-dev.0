Return-Path: <meador_inge@mentor.com>
Message-ID: <4D252FDC.4090404@mentor.com>
Date: Wed, 05 Jan 2011 20:58:36 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] MPIC Bindings and Bindings for AMP Systems
References: <4D12E4F1.2030004@mentor.com>
	<20110103142200.738c0b17@udp111988uds.am.freescale.net>
In-Reply-To: <20110103142200.738c0b17@udp111988uds.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 01/03/2011 02:22 PM, Scott Wood wrote:
> On Wed, 22 Dec 2010 23:58:09 -0600
> Perhaps a something like this, with "doorbell" being a new standard
> hw-independent service with its own binding:
>
> msg1: mpic-msg@1400 {
> 	compatible = "fsl,mpic-v3.0-msg";
> 	reg =<0x1400 0x200>;
> 	interrupts<176 2 178 2>;
>
> 	// We have message registers 0 and 2 for sending,
> 	// and 1 and 3 for receiving.
> 	// If absent, we own all message registers in this block.
> 	fsl,mpic-msg-send-mask =<0x5>;
> 	fsl,mpic-msg-receive-mask =<0xa>;
>
> 	doorbell-controller;
>
> 	// split into #doorbell-send-cells and #doorbell-receive-cells?
> 	#doorbell-cells =<1>;
> };
>
> some-amp-protocol-thingy {
> 	send-doorbells =<&msg1 0>; // generate messages on MSGR0
> 	receive-doorbells =<&msg1 0>; // receive messages on MSGR1
> };
>
> some-other-amp-protocol-thingy {
> 	send-doorbells =<&msg1 1>; // generate messages on MSGR2
> 	receive-doorbells =<&msg1 1>; // receive messages on MSGR3
> };
>
> Doorbell capabilities such as passing a 32-bit message can be negotiated
> between the drivers for the doorbell controller and the doorbell client.

After thinking about it a little more, I like the idea of having a 
'receive-mask' to further partition the message register blocks.  This 
would also allow us to remove IRQs from the 'interrupts' property that 
are not being used on a given node.  As for the 'send-mask', why would 
we want to block sending messages?  It seems to me that it would be 
reasonable to allow a node to send a message to any other node.

As an example, consider a four core system.  Then we might have 
something like (only relevant DTS bits shown):

Core 0:
    mpic-msgr-block@1400 {
       // Receives messages on registers 1 and 3.
       interrupts = <0xb1 2 0xb3 2>;
       receive-mask = <0xa>;
    };
Core 1:
    mpic-msgr-block@1400 {
       // Receives messages on register 2.
       interrupts = <0xb2 2>;
       receive-mask = <0x4>;
    };
Core 2:
    mpic-msgr-block@1400 {
       // Receives messages on register 0.
       interrupts = <0xb0 2>;
       receive-mask = <0x1>;
    };
Core 3:
    mpic-msgr-block@1400 {
       // Receives no messages.
       interrupts = <>;
    };

Then the API usage, for say core 0, might look something like:

    /* Core 0 */
    mpic_msgr *reg0 = mpic_get(0);
    mpic_msgr *reg1 = mpic_get(1);
    assert(mpic_msgr_get(100) == NULL);
    u32 value;

    /* Send a message on register 0. */
    assert(mpic_msgr_write(reg0, 12) == 0);
    /* Send a message on register 1. */
    assert(mpic_msgr_write(reg1, 12) == 0);

    /* Attempt to read a message on register 0, but can't
       since it is not owned. */
    assert(mpic_msgr_read(reg0, &value) == -ENODEV);

    /* Successfully read a message on register 1. */
    assert(mpic_msgr_read(reg1, &value) == 0);

The API usage for other cores would look similar.  As mentioned in 
another thread, this will provide us with the low-level building blocks 
and we can layer other protocols, such as the doorbell protocol, on top 
later (if needed).

Hollis, how do you feel about this?

-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
