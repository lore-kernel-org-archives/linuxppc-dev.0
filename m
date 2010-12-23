Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Thu, 23 Dec 2010 15:33:25 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Meador Inge <meador_inge@mentor.com>
Subject: Re: [RFC] MPIC Bindings and Bindings for AMP Systems
Message-ID: <20101223223325.GK20384@angua.secretlab.ca>
References: <4D12F171.7010103@mentor.com>
	<20101223185623.GA20384@angua.secretlab.ca>
	<4D13C402.2090209@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D13C402.2090209@mentor.com>
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

On Thu, Dec 23, 2010 at 03:49:54PM -0600, Meador Inge wrote:
> On 12/23/2010 12:56 PM, Grant Likely wrote:
> >Hi Meador.  Comments below.
> >
> >g.
> 
> Thanks a lot for the feedback Grant.
> 
> >You should probably list them here anyway to aid the reader.
> 
> Will do.
> 
> >What is the use case for the protected-sources property?  Wouldn't the
> >irqs simply not be referenced by any device nodes?  Documenting the
> >reason for this property would be useful here.
> 
> One use case is the original [1]:
> 
> 	Some HW platforms, such as the new cell blades, requires some
> 	MPIC sources to be left alone by the operating system. This
> 	implements support for a "protected-sources" property in the
> 	mpic controller node containing a list of source numbers to be
> 	protected against operating system interference.
> 
> Our use case is to reserve certain IRQs for certain OSes in an AMP
> system.  As an example, consider that OS 1 has (simplified for
> discussion):
> 
>     mpic: pic@40000 {
>         ...
>         protected-sources = <0xb1>;
> 
>         msgr@41400 {
>             interrupts = <0xb0 2 0xb1 2 0xb2 2 0xb3 2>;
>         };
>     };
> 
> and OS 2 has:
> 
>     mpic: pic@40000 {
>         ...
>         protected-sources = <0xb0>;
> 
>         msgr@41400 {
>             interrupts = <0xb0 2 0xb1 2 0xb2 2 0xb3 2>;
>         };
>     };
> 
> where OS 1 is sent messages through the message register tied to
> 0xb0 and OS 2 is sent messages through the message register tied to
> 0xb1.
> 
> We can't just remove the IRQ of the _other_ OS from the 'interrupts'
> property in the message node because we need to know the IRQ in
> order to talk to the other OS.  So, we use protected sources to tell
> the OS that an IRQ is not available for its own use, while at the
> same time keeping complete information on all the IRQ mappings for
> the message registers.

If the OS cannot use the IRQ, then it better not be encoded into an
'interrupts' property.  Instead, they should be encoded into a
different property (which could use exactly the same encoding as
'interrupts') that tells the driver that it is the target processor's
irq.  Something like 'target-interrupts-cpu0 = <0xb1 2>' for OS#1 in
the example.

> 
> I will update the documentation.
> 
> >I'd rather see the 'generic' value of mpic-msgr omitted and instead
> >allow new parts to claim compatibility with an older chip.  Generic
> >or wildcard compatible values can be troublesome because the meaning
> >has a tendency to change over time.
> 
> I don't completely see the issue here.  Do you have a specific
> example of how generic values like this cause problems?

For example, both the mpc83xx family and the mpc5xxx family of
processors implement the same i2c core (historically using compatible
"fsl,i2c"), but the behaviour of the two parts is subtly and
incompatibly different.  The actual implementation name has to be
matched to figure out how to drive the core correctly.  So, in that
case which implementation does "fsl,i2c" really describe?

> How do you
> see this working in terms of processing the data?  It seems like we
> are going to have to be aware of N values instead of 1, which seems
> worse.

This argument has been rehashed many times, but it basically comes
down to compatible values should ideally be anchored to a real
implemented device, not to a family of devices, or to an unversioned
specification.

In practise, the implementation doesn't actually look any different
except that the 'reference' version specifies a specific
implementation instead of a generic name.  To use a concrete example,
if there are two parts using this MPIC, like the freescale p2040 and
p4080, and say for argument that the p2040 was implemented first, then
the compatible values would look like:

for the p2040:   compatible = "fsl,p2040-msgr";
for the p4080:   compatible = "fsl,p4080-msgr", "fsl,p2040-msgr";

and the driver could simply bind on "fsl,p2040-msgr" to work with both
chips.  So, instead of an arbitrary "fsl,mpic-msgr" string,
"fsl,p2040-msgr" is used as the baseline value and there is no
ambiguity about which part it describes.

If the p4080 is actually subtly different from the p2040, then
it would not claim compatibility with the former and the driver can
match against either string; adapting its behaviour as necessary.

> 
> >?  This needs some more explanation.  cell-index often gets abused as
> >a way to enumerate devices.  Typically, the address of the device
> >itself is sufficient to identify the device.
> 
> The message registers typically come in blocks of four memory mapped
> registers and may not be in contiguous memory (example [3]).  The
> intent of 'cell-index' is to put an ordering on the blocks (so, yes,
> enumeration).  We could order them by address as well I suppose.
> One less property to worry about :)

:-)  I'd prefer to see a binding that doesn't need to enumerate nodes.
If the nodes *really* need to be enumerated, then I recommend looking
at using properties in the aliases node to assign globally enumerated
names, or at explicitly having an order list in the parent node.

> 
> >Are these registers memory mapped?  If so, then the parent node
> >needs to have a 'ranges' property.
> 
> Yes, they are.  I will look into adding that.

Thanks.
g.

> 
> 
> [1] commit 7fd7218610600b16f6f0af3f9d9353ba0265c09f, http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.36.y.git;a=commit;h=7fd7218610600b16f6f0af3f9d9353ba0265c09f
> 
> [2] Documentation/powerpc/dts-bindings/fsl/msi-pic.txt
> 
> [3] http://cache.freescale.com/files/32bit/doc/ref_manual/MPC8572ERM.pdf?fr=g
> 
> --
> Meador Inge     | meador_inge AT mentor.com
> Mentor Embedded | http://www.mentor.com/embedded-software
