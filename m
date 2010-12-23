Return-Path: <meador_inge@mentor.com>
Message-ID: <4D13C402.2090209@mentor.com>
Date: Thu, 23 Dec 2010 15:49:54 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] MPIC Bindings and Bindings for AMP Systems
References: <4D12F171.7010103@mentor.com>
	<20101223185623.GA20384@angua.secretlab.ca>
In-Reply-To: <20101223185623.GA20384@angua.secretlab.ca>
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

On 12/23/2010 12:56 PM, Grant Likely wrote:
> Hi Meador.  Comments below.
>
> g.

Thanks a lot for the feedback Grant.

> You should probably list them here anyway to aid the reader.

Will do.

> What is the use case for the protected-sources property?  Wouldn't the
> irqs simply not be referenced by any device nodes?  Documenting the
> reason for this property would be useful here.

One use case is the original [1]:

	Some HW platforms, such as the new cell blades, requires some
	MPIC sources to be left alone by the operating system. This
	implements support for a "protected-sources" property in the
	mpic controller node containing a list of source numbers to be
	protected against operating system interference.

Our use case is to reserve certain IRQs for certain OSes in an AMP 
system.  As an example, consider that OS 1 has (simplified for discussion):

     mpic: pic@40000 {
         ...
         protected-sources = <0xb1>;

         msgr@41400 {
             interrupts = <0xb0 2 0xb1 2 0xb2 2 0xb3 2>;
         };
     };

and OS 2 has:

     mpic: pic@40000 {
         ...
         protected-sources = <0xb0>;

         msgr@41400 {
             interrupts = <0xb0 2 0xb1 2 0xb2 2 0xb3 2>;
         };
     };

where OS 1 is sent messages through the message register tied to 0xb0 
and OS 2 is sent messages through the message register tied to 0xb1.

We can't just remove the IRQ of the _other_ OS from the 'interrupts' 
property in the message node because we need to know the IRQ in order to 
talk to the other OS.  So, we use protected sources to tell the OS that 
an IRQ is not available for its own use, while at the same time keeping 
complete information on all the IRQ mappings for the message registers.

I will update the documentation.

> I'd rather see the 'generic' value of mpic-msgr omitted and instead
> allow new parts to claim compatibility with an older chip.  Generic
> or wildcard compatible values can be troublesome because the meaning
> has a tendency to change over time.

I don't completely see the issue here.  Do you have a specific example 
of how generic values like this cause problems?  How do you see this 
working in terms of processing the data?  It seems like we are going to 
have to be aware of N values instead of 1, which seems worse.

> ?  This needs some more explanation.  cell-index often gets abused as
> a way to enumerate devices.  Typically, the address of the device
> itself is sufficient to identify the device.

The message registers typically come in blocks of four memory mapped 
registers and may not be in contiguous memory (example [3]).  The intent 
of 'cell-index' is to put an ordering on the blocks (so, yes, 
enumeration).  We could order them by address as well I suppose.  One 
less property to worry about :)

> Are these registers memory mapped?  If so, then the parent node
> needs to have a 'ranges' property.

Yes, they are.  I will look into adding that.


[1] commit 7fd7218610600b16f6f0af3f9d9353ba0265c09f, 
http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.36.y.git;a=commit;h=7fd7218610600b16f6f0af3f9d9353ba0265c09f

[2] Documentation/powerpc/dts-bindings/fsl/msi-pic.txt

[3] 
http://cache.freescale.com/files/32bit/doc/ref_manual/MPC8572ERM.pdf?fr=g

--
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
