Return-Path: <meador_inge@mentor.com>
Message-ID: <4D24E053.1000808@mentor.com>
Date: Wed, 05 Jan 2011 15:19:15 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] MPIC Bindings and Bindings for AMP Systems
References: <4D12E4F1.2030004@mentor.com>	<20110103142200.738c0b17@udp111988uds.am.freescale.net>	<4D23B2C6.8050607@mentor.com>
	<20110104181346.2a9ab036@udp111988uds.am.freescale.net>
In-Reply-To: <20110104181346.2a9ab036@udp111988uds.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/04/2011 06:13 PM, Scott Wood wrote:
> On Tue, 4 Jan 2011 17:52:38 -0600
> Meador Inge<meador_inge@mentor.com>  wrote:
>
>> Thanks for the feedback Scott.
>>
>> On 01/03/2011 02:22 PM, Scott Wood wrote:
>>> On Wed, 22 Dec 2010 23:58:09 -0600
>>> These nodes cannot go under the mpic node, because interrupt
>>> controllers need #address-cells =<0>.
>>
>> Good point.  Do they actually need it or is that just the way it
>> currently is?  [1] mandates it, I didn't see anything in [2] and I can't
>> access [3].
>
> It's because of the way interrupt maps work -- a full interrupt
> specifier includes the node's reg address as well as the values in the
> interrupts property.  This is useful for things like PCI controllers,
> but normal interrupt controllers won't have any use for it.
>
> In theory, I suppose you could have a non-zero #address-cells in an
> interrupt controller, but then you'd have to pad the parent interrupt
> specifiers in any interrupt map entries that point at the MPIC node with
> that many don't-care cells.
>
> Better to just avoid the issue.

Agreed, it would be nasty to have padding for this.

>> However, AFAIK '#address-cells' is taken directly from the parent node
>> and is not inherited from ancestors higher in the tree.  So another
>> option would be to do something like:
>>
>>       mpic: pic@40000 {
>>          ...
>>          message-registers@0 {
>>             #address-cells =<1>;
>>             #size-cells =<1>;
>>
>>             msgr@1400 {
>>                compatible = "fsl,mpic-v3.0-msgr";
>>                reg =<0x1400 0x200>;
>>                interrupts =<0xb0 0x2 0xb1 0x2 0xb2 0x2 0xb3 0x2>;
>>             };
>>
>>             msgr@2400 {
>>                compatible = "fsl,mpic-v3.0-msgr";
>>                reg =<0x2400 0x200>;
>>                interrupts =<0xb4 0x2 0xb5 0x2 0xb6 0x2 0xb7 0x2>;
>>             };
>>          };
>>       };
>
> Won't work, the reg addresses need to be translatable through ranges all
> the way up to the root.

Ah, I see.  This is because we would have to add 'ranges' on 
'message-registers' and 'pic', but 'pic' needs to have '#address-cells' 
 > 0 to interpret 'ranges'.  Fun :)  I will hoist the message registers 
nodes out of the MPIC node.

>> I like the nesting as it models the physical relationship closer and
>> creates a clean namespace.
>
> Sure, if it weren't for the #address-cells issue I'd agree.
>
>>> It would be nice if the binding provided some way of partitioning
>>> up individual message interrupts within a block.
>>>
>>> Interrupt generation could be exported as a "service", similar to
>>> (inbound) interrupts and gpios.
>>>
>>> Perhaps a something like this, with "doorbell" being a new standard
>>> hw-independent service with its own binding:
>>
>> I need to think about this proposal more, but our original intent was to
>> just have a simple description of the message registers in the device
>> tree and the policy for how those message registers are used is in
>> software (not necessarily an exact API use case, but you get the point):
>
> That may be fine for your use case (just as some people may be happy
> to hardcode device knowledge into their kernel), but in the general case
> inter-partition protocols are effectively a non-probeable part of the
> "hardware" the partition runs on.  It's good to have a standard way of
> labelling what goes where. The details of the protocol would still be
> in software, referenced by the compatible string on the protocol node.
>
>>      /* Core 0 */
>>      mpic_msgr_reserve(0);
>>      mpic_msgr_reserve(1);
>>
>>      /* Send message to Core 1 */
>>      mpic_msgr_write(3, 13);
>>
>>      /* Read a value */
>>      u32 value;
>>      mpic_msgr_read(0,&value);
>>
>>      /* Free the register */
>>      mpic_msgr_release(0);
>>      ...
>>
>>      /* Core 1 */
>>      mpic_msgr_reserve(3);
>>      mpic_msgr_reserve(4);
>>
>>      /* Send message to Core 0 */
>>      mpic_msgr_write(0, 1);
>
> You're hardcoding into software that core 0 gets msg0 and msg1, and
> core 1 gets msg3 and msg4, etc.  Not much different than hardcoding that
> core 0 gets enet0 and core 1 gets enet1 and enet2.
>
>> Note that a "reservation" is still isolated to a particular core, e.g.
>> 'mpic_msgr_reserve(0)' on core 0 will not cause 'mpic_msgr_reserve(0)'
>> to fail on another core.  Where as two invocations of
>> 'mpic_msgr_reserve(0)' on the same core without an interleaved
>> 'mpic_msgr_release(0)' would, of course, fail.
>
> So basically, you're assigning the resource to both partitions, and
> relying on dynamic cooperation.  That's fine, in that case both
> partitions would see the resource in their device tree, hopefully along
> with something to indicate what the situation is.  But dedicated
> ownership is common enough, and similar enough to the question of
> whether the hardware exists at all, that it's nice to be able to express
> it in the device tree.  It also makes it easier to deal with situations
> where you later want to plug in different hardware (or possibly a
> virtualized interface) underneath the protocol.

I agree that it would be nice to have some elements of the protocol 
represented in the device tree.  I would just like to do this in small 
steps.  We are going to need the data in the device tree for the message 
registers no matter what.  We are also going to need a simple API for 
interfacing with the registers.  The bottom layer so to speak.  These 
building blocks can be utilized later by a higher-level protocol if need 
be.  For now I would just like to propose the MPIC bindings, the initial 
message register bindings, and the message registers API.  Sound good?

> I'm not sure how much practical benefit there is to dynamically
> allocating message registers across partitions, though -- you'd have
> to have some way of communicating to the other end the result of the
> allocation, so it knows which one to send a message on.  And if you
> only have 2 cores, and unhypervised AMP, you'll be able to dedicate 4
> message registers to each partition...

Hollis and I discussed that a bit already.  The problem with our use 
case (and presumably others) is that we are using the message registers 
to aid in communicating over shared memory.  If we go into dynamic 
allocation of message registers across partitions, then we need to 
coordinate between the partitions across shared memory.  So you need 
shared memory communication to setup shared memory communication.  Also, 
if we just get the basic pieces in place with the message register API 
('reserve', 'release', 'read', 'write', etc...) we can perhaps figure 
out a way to build a dynamically allocator on top of those services 
later, if need be.

--
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
