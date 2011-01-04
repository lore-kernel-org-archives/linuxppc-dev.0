Return-Path: <meador_inge@mentor.com>
Message-ID: <4D23B2C6.8050607@mentor.com>
Date: Tue, 04 Jan 2011 17:52:38 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] MPIC Bindings and Bindings for AMP Systems
References: <4D12E4F1.2030004@mentor.com>
	<20110103142200.738c0b17@udp111988uds.am.freescale.net>
In-Reply-To: <20110103142200.738c0b17@udp111988uds.am.freescale.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
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

Thanks for the feedback Scott.

On 01/03/2011 02:22 PM, Scott Wood wrote:
> On Wed, 22 Dec 2010 23:58:09 -0600
> These nodes cannot go under the mpic node, because interrupt
> controllers need #address-cells =<0>.

Good point.  Do they actually need it or is that just the way it 
currently is?  [1] mandates it, I didn't see anything in [2] and I can't 
access [3].

However, AFAIK '#address-cells' is taken directly from the parent node 
and is not inherited from ancestors higher in the tree.  So another 
option would be to do something like:

     mpic: pic@40000 {
        ...
        message-registers@0 {
           #address-cells = <1>;
           #size-cells = <1>;

           msgr@1400 {
              compatible = "fsl,mpic-v3.0-msgr";
              reg = <0x1400 0x200>;
              interrupts = <0xb0 0x2 0xb1 0x2 0xb2 0x2 0xb3 0x2>;
           };

           msgr@2400 {
              compatible = "fsl,mpic-v3.0-msgr";
              reg = <0x2400 0x200>;
              interrupts = <0xb4 0x2 0xb5 0x2 0xb6 0x2 0xb7 0x2>;
           };
        };
     };

I like the nesting as it models the physical relationship closer and 
creates a clean namespace.

> It would be nice if the binding provided some way of partitioning
> up individual message interrupts within a block.
>
> Interrupt generation could be exported as a "service", similar to
> (inbound) interrupts and gpios.
>
> Perhaps a something like this, with "doorbell" being a new standard
> hw-independent service with its own binding:

I need to think about this proposal more, but our original intent was to 
just have a simple description of the message registers in the device 
tree and the policy for how those message registers are used is in 
software (not necessarily an exact API use case, but you get the point):

    /* Core 0 */
    mpic_msgr_reserve(0);
    mpic_msgr_reserve(1);

    /* Send message to Core 1 */
    mpic_msgr_write(3, 13);

    /* Read a value */
    u32 value;
    mpic_msgr_read(0, &value);

    /* Free the register */
    mpic_msgr_release(0);
    ...

    /* Core 1 */
    mpic_msgr_reserve(3);
    mpic_msgr_reserve(4);

    /* Send message to Core 0 */
    mpic_msgr_write(0, 1);

Note that a "reservation" is still isolated to a particular core, e.g. 
'mpic_msgr_reserve(0)' on core 0 will not cause 'mpic_msgr_reserve(0)' 
to fail on another core.  Where as two invocations of 
'mpic_msgr_reserve(0)' on the same core without an interleaved 
'mpic_msgr_release(0)' would, of course, fail.

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


-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software

[1] Power.org™ Standard for Embedded Power Architecture™ Platform 
Requirements (ePAPR) Version 1.0
[2] PowerPC Microprocessor Common Hardware Reference Platform (CHRP) 
Binding, Version 1.8, 1998. Published by the Open Firmware Working Group.
[3] The Open Programmable Interrupt Controller (PIC) Register Interface 
Specification Revision 1.2
