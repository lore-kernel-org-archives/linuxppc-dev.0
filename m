Return-Path: <babu.pci81@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by ozlabs.org (Postfix) with ESMTP id EFF95DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 14:31:43 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so261121rvf
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 21:31:40 -0700 (PDT)
Message-ID: <a38e30640709122131g14642e9pa599681551ed9c23@mail.gmail.com>
Date: Thu, 13 Sep 2007 10:01:36 +0530
From: "lakshminarayana babu" <babu.pci81@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Linuxppc-dev Digest, Vol 37, Issue 84
In-Reply-To: <mailman.2011.1189652741.2970.linuxppc-dev@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7202_30755943.1189657896784"
References: <mailman.2011.1189652741.2970.linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_7202_30755943.1189657896784
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

i am new to the linux.....can you tell me how to access the pci
configuration space using ioremap function...but  it is implicit function
declaration...

On 9/13/07, linuxppc-dev-request@ozlabs.org <linuxppc-dev-request@ozlabs.org>
wrote:
>
> Send Linuxppc-dev mailing list submissions to
>         linuxppc-dev@ozlabs.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://ozlabs.org/mailman/listinfo/linuxppc-dev
> or, via email, send a message with subject or body 'help' to
>         linuxppc-dev-request@ozlabs.org
>
> You can reach the person managing the list at
>         linuxppc-dev-owner@ozlabs.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linuxppc-dev digest..."
>
>
> Today's Topics:
>
>    1. Re: [PATCH 15/15] Add DEFINE_SPUFS_ATTRIBUTE() (Michael Ellerman)
>    2. Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572
>       DS port (Segher Boessenkool)
>    3. Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572
>       DS port (Segher Boessenkool)
>    4. Re: [PATCH 1/5] Add Freescale DMA and DMA channel to
>       Documentation/powerpc/booting-without-of.txt file.
>       (Segher Boessenkool)
>    5. Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572
>       DS port (Segher Boessenkool)
>    6. Re: [PATCH v4] [POWERPC] 85xx: Add basic Uniprocessor MPC8572
>       DS port (Segher Boessenkool)
>    7. Re: [PATCH] [POWERPC] DTS cleanup (Segher Boessenkool)
>    8. Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS
>       port (Segher Boessenkool)
>    9. Re: [PATCH] [RFC][POWERPC] Merge 32 and 64 bit
>       pci_process_bridge_OF_ranges() instances (Segher Boessenkool)
>   10. Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS
>       port (Segher Boessenkool)
>   11. Re: [PATCH] [POWERPC] DTS cleanup (Kumar Gala)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Thu, 13 Sep 2007 12:05:41 +1000
> From: Michael Ellerman <michael@ellerman.id.au>
> Subject: Re: [PATCH 15/15] Add DEFINE_SPUFS_ATTRIBUTE()
> To: Arnd Bergmann <arnd@arndb.de>
> Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
>         linux-kernel@vger.kernel.org
> Message-ID: <1189649141.19087.13.camel@concordia.ozlabs.ibm.com>
> Content-Type: text/plain; charset="us-ascii"
>
> On Wed, 2007-09-12 at 10:47 +0200, Arnd Bergmann wrote:
> > On Wednesday 12 September 2007, Michael Ellerman wrote:
> > > On Wed, 2007-09-12 at 17:43 +1000, Michael Ellerman wrote:
> > > > This patch adds DEFINE_SPUFS_ATTRIBUTE(), a wraper around
> > > > DEFINE_SIMPLE_ATTRIBUTE which does the specified locking for the get
> > > > routine for us.
> > > >
> > > > Unfortunately we need two get routines (a locked and unlocked
> version) to
> > > > support the coredump code. This patch hides one of those (the locked
> version)
> > > > inside the macro foo.
> >
> > >
> > > jk said:
> > > > "Good god man!"
> > >
> > > Yeah, I'm a bit lukewarm on this one. But the diffstat is nice, 50%
> code
> > > reduction ain't bad :)
> >
> > Have you looked at the change in object code size? I would expect the
> > object code to actually become bigger. I also think that it hurts
> > readability rather than help it.
>
> Yeah I did, it's smaller actually:
>
>    text    data     bss     dec     hex filename
>   44898   17804     120   62822    f566 spufs-before.o
>   44886   17804     120   62810    f55a spufs-after.o
>
> > Maybe a better solution is to change the core dump code to not
> > require the mutex to be held in the first place. By the time
> > we get to call the get functions, it should already be in
> > saved state and no longer be able to get scheduled, so we might
> > not actually need all the extra tricks with avoiding the
> > mutex to be taken again.
>
> Well that'd be nice, but I don't see anywhere that that happens. AFAICT
> the acquire we do in the first coredump callback is the first the SPU
> contexts know about their PPE process dying. And spufs is still live, so
> I think we definitely need to grab the mutex, or we might race with
> userspace accessing spufs files.
>
> cheers
>
> --
> Michael Ellerman
> OzLabs, IBM Australia Development Lab
>
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
>
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: not available
> Type: application/pgp-signature
> Size: 189 bytes
> Desc: This is a digitally signed message part
> Url :
> http://ozlabs.org/pipermail/linuxppc-dev/attachments/20070913/d7914b17/attachment-0001.pgp
>
> ------------------------------
>
> Message: 2
> Date: Wed, 12 Sep 2007 15:36:55 +0200
> From: Segher Boessenkool <segher@kernel.crashing.org>
> Subject: Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572
>         DS port
> To: Kumar Gala <galak@kernel.crashing.org>
> Cc: linuxppc-dev@ozlabs.org
> Message-ID: <a58bb9a05680c3befc4d3588992caed0@kernel.crashing.org>
> Content-Type: text/plain; charset=US-ASCII; format=flowed
>
> Looks a lot better, thanks!
>
> Some minor nits and suggestions...
>
> > +/ {
> > +     model = "fsl,MPC8572DS";
> > +     compatible = "fsl,MPC8572DS", "fsl,MPC85xxDS";
>
> We don't want "xx" compatible entries; especially here it makes
> no sense at all.  If the board is compatible to some other (older)
> board, just name that board explicitly.
>
> > +             PowerPC,8572@0 {
>
> Maybe it would be good to use "PowerPC,e500" instead -- it would
> make it easier to probe for the actual CPU type, that way.  Not
> that Linux uses the name/compatible here at all ;-)
>
> > +     soc8572@ffe00000 {
>
> You should put an interrupt-parent in here, so you can get rid of
> it in all the children.
>
>
> And then there's the pci_bridge thing we're discussing on IRC, of
> course -- basically, get rid of the pci_bridge pseudo-node, and
> move the interrupt-map for the south-bridge devices into the
> south-bridge node.
>
>
> Segher
>
>
>
> ------------------------------
>
> Message: 3
> Date: Wed, 12 Sep 2007 16:00:38 +0200
> From: Segher Boessenkool <segher@kernel.crashing.org>
> Subject: Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572
>         DS port
> To: David Gibson <david@gibson.dropbear.id.au>
> Cc: linuxppc-dev@ozlabs.org
> Message-ID: <44b4b3a133980aeb6c596aad71612e6c@kernel.crashing.org>
> Content-Type: text/plain; charset=US-ASCII; format=flowed
>
> >>>> +          uli1575@0 {
> >>>> +                  reg = <0 0 0 0 0>;
> >>>
> >>> This looks kind of bogus...
> >>
> >> Its a PCIe to PCI bridge that is transparent.
> >
> > Right.... if it has no control registers, I think it should just lack
> > 'reg', not define a zero-length register block.
>
> "reg" for PCI config registers has length 0 always, it's defined that
> way in the PCI binding.
>
> But if this thing is transparent, it doesn't have PCI config regs.
>
> >>>> +                  #size-cells = <2>;
> >>>> +                  #address-cells = <3>;
> >>>> +                  ranges = <02000000 0 80000000
> >>>> +                            02000000 0 80000000
> >>>> +                            0 20000000
> >>>> +                            01000000 0 00000000
> >>>> +                            01000000 0 00000000
> >>>> +                            0 00100000>;
> >
> > And if truly transparent, it should perhaps have just ranges;
> > indicating that child addresses are identity mapped to parent
> > addresses.
>
> If truly transparent, the node should just not be there at all!
>
> >>>> +                  pci_bridge@0 {
> >>>
> >>> Ok.. why is pci_bridge nested within uli1575 - with the matching reg
> >>> and ranges, it looks like they ought to be one device.  Also if this
> >>> is a PCI<->PCI bridge, I believe it shold have device_type = "pci".
> >>
> >> We've been using this as it stands for a while.  If there are some
> >> changes here that make sense I'm willing to make them.
> >
> > Right, at present I don't see why you couldn't just ditch the
> > pci_bridge node, and drop its contents straight into the uli1575 node.
>
> Yeah.  The preferred name for PCI-to-PCI bridge nodes is simply "pci",
> btw.
>
>
> Segher
>
>
>
> ------------------------------
>
> Message: 4
> Date: Thu, 13 Sep 2007 04:09:29 +0200
> From: Segher Boessenkool <segher@kernel.crashing.org>
> Subject: Re: [PATCH 1/5] Add Freescale DMA and DMA channel to
>         Documentation/powerpc/booting-without-of.txt file.
> To: Scott Wood <scottwood@freescale.com>
> Cc: linuxppc-dev@ozlabs.org, Zhang Wei-r63237
>         <Wei.Zhang@freescale.com>,      paulus@samba.org, David Gibson
>         <david@gibson.dropbear.id.au>
> Message-ID: <fd81b53021e39a13ea65c0a0319aab77@kernel.crashing.org>
> Content-Type: text/plain; charset=US-ASCII; format=flowed
>
> >> I have a strange issue here. If I rename 'fsl,dma' to
> >> 'fsl,mpc8540-dma',
> >> the 'fsl,mpc8540-dma-channel' will be also regarded as DMA device not
> >> DMA channel.
> >
> > What tree are you using?  Commit
> > 804ace8881d211ac448082e871dd312132393049
> > in Paul's git tree should have fixed that.
>
> Strange, I don't see that commit -- maybe gitweb is broken, or
> maybe the patch was superseded, or maybe it just disappeared?
> It's still shown in patchworks with this commit id fwiw.
>
>
> Segher
>
>
>
> ------------------------------
>
> Message: 5
> Date: Wed, 12 Sep 2007 16:10:09 +0200
> From: Segher Boessenkool <segher@kernel.crashing.org>
> Subject: Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572
>         DS port
> To: Kumar Gala <galak@kernel.crashing.org>
> Cc: linuxppc-dev@ozlabs.org, David Gibson
>         <david@gibson.dropbear.id.au>
> Message-ID: <cbff3b332b53f61721a8e14472347b98@kernel.crashing.org>
> Content-Type: text/plain; charset=US-ASCII; format=flowed
>
> >>> +                                   i8259: interrupt-controller@20 {
> >>> +                                           reg = <1 20 2
> >>> +                                                  1 a0 2
> >>> +                                                  1 4d0 2>;
> >>> +                                           clock-frequency = <0>;
> >>
> >> Hrm.. what is clock-frequency for on an i8259?  I see that other 8259
> >> descriptions have this as well, so it's not a problem with this patch
> >> specifically.
> >
> > Its a copy-paste thing so I don't know.
>
> If your bootwrapper doesn't fill in this value, you should get rid
> of this property -- better to have no value than to have the wrong
> value, esp. since it's probably unused anyway.
>
>
> Segher
>
>
>
> ------------------------------
>
> Message: 6
> Date: Thu, 13 Sep 2007 00:22:58 +0200
> From: Segher Boessenkool <segher@kernel.crashing.org>
> Subject: Re: [PATCH v4] [POWERPC] 85xx: Add basic Uniprocessor MPC8572
>         DS port
> To: Kumar Gala <galak@kernel.crashing.org>
> Cc: linuxppc-dev@ozlabs.org
> Message-ID: <13038b1ac10f19f2e1fdbd0c1323c1e7@kernel.crashing.org>
> Content-Type: text/plain; charset=US-ASCII; format=flowed
>
> > +     soc8572@ffe00000 {
> > +             #address-cells = <1>;
> > +             #size-cells = <1>;
> > +             device_type = "soc";
> > +             ranges = <00000000 ffe00000 00100000>;
> > +             reg = <ffe00000 00001000>;      // CCSRBAR & soc regs,
> remove once parse
> > code for immrbase fixed
>
> Hrm, if you remove it here, where else are you going to describe
> the SoC control register block (whatever it is called -- is that
> IMMR?)
>
>
> Segher
>
>
>
> ------------------------------
>
> Message: 7
> Date: Thu, 13 Sep 2007 00:10:38 +0200
> From: Segher Boessenkool <segher@kernel.crashing.org>
> Subject: Re: [PATCH] [POWERPC] DTS cleanup
> To: Kumar Gala <galak@kernel.crashing.org>
> Cc: linuxppc-dev@ozlabs.org
> Message-ID: <919c9b76c3e6e45af6e3fb887611a681@kernel.crashing.org>
> Content-Type: text/plain; charset=US-ASCII; format=flowed
>
> > * 32-bit in cpu node -- doesn't exist in any spec and not used by
> > kernel
>
> Yeah.
>
> > * built-in for non-standard buses (ISA, PCI)
>
> "built-in" is some weird CHRP property, so yes we don't need it
> or want it.
>
> > * Removed #interrupt-cells in places they don't need to be set
>
> Great :-)
>
> > * Fixed ranges on lite5200*
>
> This has a problem still:
>
> >               model = "fsl,mpc5200";
> >               compatible = "mpc5200";
> >               revision = "";                  // from bootloader
> > -             #interrupt-cells = <3>;
> >               device_type = "soc";
> > -             ranges = <0 f0000000 f0010000>;
> > -             reg = <f0000000 00010000>;
> > +             ranges = <0 f0000000 0000c000>;
> > +             reg = <f0000000 0000c000>;
>
> That makes "reg" and "ranges" identify an identical address range,
> which means no subnode can claim any address in that range, so the
> "ranges" property should go.  Alternatively, the "reg" might be
> claiming too big a space.
>
> Which is it?
>
>
> Segher
>
>
>
> ------------------------------
>
> Message: 8
> Date: Wed, 12 Sep 2007 15:20:14 +0200
> From: Segher Boessenkool <segher@kernel.crashing.org>
> Subject: Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS
>         port
> To: Scott Wood <scottwood@freescale.com>
> Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
> Message-ID: <41e2e527c0f0dfceedf2ffe6cdf34816@kernel.crashing.org>
> Content-Type: text/plain; charset=US-ASCII; format=flowed
>
> >>> well the ifdefs are orthogonal.  We don't have a way of knowing
> >>> primary from the device tree today.
> >>
> >> How about something like "fsl,primary-phb" in the bus device node? I
> >> don't
> >> know, maybe it's already been discussed and turned down for some
> >> reason.
> >
> > It's more of a Linux issue than anything to do with the hardware.
>
> Yeah, many machines actually have multiple "primary PHBs", and
> Linux cannot really deal with that.  It's probably best to handle
> this from platform code.
>
> >> Or would it be sufficient to check children of that device node to see
> >> if the ULi is on that bus?
> >
> > Or more generally, see if an isa node is somewhere in that subtree.
>
> And if there is no ISA node, find any other legacy device (non-native
> ATA controllers, ...), etc.
>
>
> Segher
>
>
>
> ------------------------------
>
> Message: 9
> Date: Wed, 12 Sep 2007 16:51:25 +0200
> From: Segher Boessenkool <segher@kernel.crashing.org>
> Subject: Re: [PATCH] [RFC][POWERPC] Merge 32 and 64 bit
>         pci_process_bridge_OF_ranges() instances
> To: Arnd Bergmann <arnd@arndb.de>
> Cc: linuxppc-dev@ozlabs.org
> Message-ID: <4cd6407b936b2ce65c11092883e7b8d5@kernel.crashing.org>
> Content-Type: text/plain; charset=US-ASCII; format=flowed
>
> >>>> +struct ranges_pci {
> >>>> +  unsigned int pci_space;
> >>>> +  u64 pci_addr;
> >>>> +  phys_addr_t phys_addr;
> >>>> +  u64 size;
> >>>> +} __attribute__((packed));
> >>>> +
> >>>
> >>> This structure definition uses unaligned members because of the
> >>> 'packed' attribute. Is that really what you intended?
> >>>
> >> yes, exactly, because I'm mapping this struct on ranges extracted from
> >> the dts instead of juggling with ranges[foo] offsets.
> >
> > I see. It does however look wrong to me, because you are using a
> > hardcoded
> > phys_addr_t type. This breaks when phys_addr has a different size from
> > what
> > you expect, e.g. when booting a pure 32 bit kernel on a machine that
> > has
> > a 64 bit physical address space.
>
> More generally, you can even have a different size for the "phys_addr"
> for different nodes in the same device tree.
>
> You really should look at the #address-cells in this node's parent,
> and translate that all the way up to the root node to get a CPU
> address.
>
>
> Segher
>
>
>
> ------------------------------
>
> Message: 10
> Date: Wed, 12 Sep 2007 15:20:25 +0200
> From: Segher Boessenkool <segher@kernel.crashing.org>
> Subject: Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS
>         port
> To: Kumar Gala <galak@kernel.crashing.org>
> Cc: linuxppc-dev@ozlabs.org
> Message-ID: <6b92503d73565f8add983e64ad5d5d39@kernel.crashing.org>
> Content-Type: text/plain; charset=US-ASCII; format=flowed
>
> >>> +           l2-cache-controller@20000 {
> >>> +                   compatible = "fsl,8572-l2-cache-controller";
> >>> +                   reg = <20000 1000>;
> >>> +                   cache-line-size = <20>; // 32 bytes
> >>> +                   cache-size = <80000>;   // L2, 512K
> >>> +                   interrupt-parent = <&mpic>;
> >>> +                   interrupts = <10 2>;
> >>> +           };
> >>
> >> Should this node be referenced by an l2-cache property in the cpu
> >> node?
> >
> > No, its a front side cache.
>
> What is a "front side cache"?  What exactly does it cache?  If it's
> a cache for one CPU only, that fact should be shown in the device
> tree somehow.
>
> >>> +                   device_type = "pci";
> >>> +                   #interrupt-cells = <1>;
> >>> +                   #size-cells = <2>;
> >>> +                   #address-cells = <3>;
> >>> +                   reg = <8000 1000>;
> >>> +                   bus-range = <0 ff>;
> >>> +                   ranges = <02000000 0 80000000 80000000 0 20000000
> >>> +                             01000000 0 00000000 ffc00000 0
> 00010000>;
> >>
> >> No prefetchable mem space?
> >
> > we haven't normally provided prefetch on 85xx/86xx.. will deal with
> > this later.
>
> If you don't set up prefetchable memory regions on the PCI from
> the firmware, this code is fine, sure.  It would be a good plan
> to do map all BARs that say they are prefetchable in some
> prefetchable PCI window, it gives a nice speed boost, even when
> the kernel accesses it as simple non-cacheable space: the PCI
> bridges in between can streamline loads from these areas.
>
> In any case, the device tree should be in synch with how the
> firmware set up the PCI hardware, and it seems that's what you
> have now, so all is fine.
>
>
> Segher
>
>
>
> ------------------------------
>
> Message: 11
> Date: Wed, 12 Sep 2007 22:08:33 -0500
> From: Kumar Gala <galak@kernel.crashing.org>
> Subject: Re: [PATCH] [POWERPC] DTS cleanup
> To: Segher Boessenkool <segher@kernel.crashing.org>
> Cc: linuxppc-dev@ozlabs.org
> Message-ID: <8FFFBF2E-8255-40FB-836D-AB5B19222DD9@kernel.crashing.org>
> Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
>
>
> On Sep 12, 2007, at 5:10 PM, Segher Boessenkool wrote:
>
> >> * 32-bit in cpu node -- doesn't exist in any spec and not used by
> >> kernel
> >
> > Yeah.
> >
> >> * built-in for non-standard buses (ISA, PCI)
> >
> > "built-in" is some weird CHRP property, so yes we don't need it
> > or want it.
>
> Do you suggest we get ride of it from ISA nodes as well?
>
> >
> >> * Removed #interrupt-cells in places they don't need to be set
> >
> > Great :-)
> >
> >> * Fixed ranges on lite5200*
> >
> > This has a problem still:
> >
> >>              model = "fsl,mpc5200";
> >>              compatible = "mpc5200";
> >>              revision = "";                  // from bootloader
> >> -            #interrupt-cells = <3>;
> >>              device_type = "soc";
> >> -            ranges = <0 f0000000 f0010000>;
> >> -            reg = <f0000000 00010000>;
> >> +            ranges = <0 f0000000 0000c000>;
> >> +            reg = <f0000000 0000c000>;
> >
> > That makes "reg" and "ranges" identify an identical address range,
> > which means no subnode can claim any address in that range, so the
> > "ranges" property should go.  Alternatively, the "reg" might be
> > claiming too big a space.
> >
> > Which is it?
>
> Yeah, I think it should be 0x100 for the 'soc' regs on 52xx so I'll
> set regs to that.
>
> - k
>
>
> ------------------------------
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
> End of Linuxppc-dev Digest, Vol 37, Issue 84
> ********************************************
>

------=_Part_7202_30755943.1189657896784
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

i am new to the linux.....can you tell me how to access the pci configuration space using ioremap function...but&nbsp; it is implicit function declaration...<br><br><div><span class="gmail_quote">On 9/13/07, <b class="gmail_sendername">
<a href="mailto:linuxppc-dev-request@ozlabs.org">linuxppc-dev-request@ozlabs.org</a></b> &lt;<a href="mailto:linuxppc-dev-request@ozlabs.org">linuxppc-dev-request@ozlabs.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Send Linuxppc-dev mailing list submissions to<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a><br><br>To subscribe or unsubscribe via the World Wide Web, visit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">
https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>or, via email, send a message with subject or body &#39;help&#39; to<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:linuxppc-dev-request@ozlabs.org">linuxppc-dev-request@ozlabs.org</a><br>
<br>You can reach the person managing the list at<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:linuxppc-dev-owner@ozlabs.org">linuxppc-dev-owner@ozlabs.org</a><br><br>When replying, please edit your Subject line so it is more specific<br>than &quot;Re: Contents of Linuxppc-dev digest...&quot;
<br><br><br>Today&#39;s Topics:<br><br>&nbsp;&nbsp; 1. Re: [PATCH 15/15] Add DEFINE_SPUFS_ATTRIBUTE() (Michael Ellerman)<br>&nbsp;&nbsp; 2. Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DS port (Segher Boessenkool)<br>
&nbsp;&nbsp; 3. Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DS port (Segher Boessenkool)<br>&nbsp;&nbsp; 4. Re: [PATCH 1/5] Add Freescale DMA and DMA channel to<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Documentation/powerpc/booting-without-of.txt
 file.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Segher Boessenkool)<br>&nbsp;&nbsp; 5. Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DS port (Segher Boessenkool)<br>&nbsp;&nbsp; 6. Re: [PATCH v4] [POWERPC] 85xx: Add basic Uniprocessor MPC8572<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DS port (Segher Boessenkool)
<br>&nbsp;&nbsp; 7. Re: [PATCH] [POWERPC] DTS cleanup (Segher Boessenkool)<br>&nbsp;&nbsp; 8. Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;port (Segher Boessenkool)<br>&nbsp;&nbsp; 9. Re: [PATCH] [RFC][POWERPC] Merge 32 and 64 bit
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pci_process_bridge_OF_ranges() instances (Segher Boessenkool)<br>&nbsp;&nbsp;10. Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;port (Segher Boessenkool)<br>&nbsp;&nbsp;11. Re: [PATCH] [POWERPC] DTS cleanup (Kumar Gala)
<br><br><br>----------------------------------------------------------------------<br><br>Message: 1<br>Date: Thu, 13 Sep 2007 12:05:41 +1000<br>From: Michael Ellerman &lt;<a href="mailto:michael@ellerman.id.au">michael@ellerman.id.au
</a>&gt;<br>Subject: Re: [PATCH 15/15] Add DEFINE_SPUFS_ATTRIBUTE()<br>To: Arnd Bergmann &lt;<a href="mailto:arnd@arndb.de">arnd@arndb.de</a>&gt;<br>Cc: <a href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a>
, Jeremy Kerr &lt;<a href="mailto:jk@ozlabs.org">jk@ozlabs.org</a>&gt;,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:linux-kernel@vger.kernel.org">linux-kernel@vger.kernel.org</a><br>Message-ID: &lt;<a href="mailto:1189649141.19087.13.camel@concordia.ozlabs.ibm.com">
1189649141.19087.13.camel@concordia.ozlabs.ibm.com</a>&gt;<br>Content-Type: text/plain; charset=&quot;us-ascii&quot;<br><br>On Wed, 2007-09-12 at 10:47 +0200, Arnd Bergmann wrote:<br>&gt; On Wednesday 12 September 2007, Michael Ellerman wrote:
<br>&gt; &gt; On Wed, 2007-09-12 at 17:43 +1000, Michael Ellerman wrote:<br>&gt; &gt; &gt; This patch adds DEFINE_SPUFS_ATTRIBUTE(), a wraper around<br>&gt; &gt; &gt; DEFINE_SIMPLE_ATTRIBUTE which does the specified locking for the get
<br>&gt; &gt; &gt; routine for us.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Unfortunately we need two get routines (a locked and unlocked version) to<br>&gt; &gt; &gt; support the coredump code. This patch hides one of those (the locked version)
<br>&gt; &gt; &gt; inside the macro foo.<br>&gt;<br>&gt; &gt;<br>&gt; &gt; jk said:<br>&gt; &gt; &gt; &quot;Good god man!&quot;<br>&gt; &gt;<br>&gt; &gt; Yeah, I&#39;m a bit lukewarm on this one. But the diffstat is nice, 50% code
<br>&gt; &gt; reduction ain&#39;t bad :)<br>&gt;<br>&gt; Have you looked at the change in object code size? I would expect the<br>&gt; object code to actually become bigger. I also think that it hurts<br>&gt; readability rather than help it.
<br><br>Yeah I did, it&#39;s smaller actually:<br><br>&nbsp;&nbsp; text&nbsp;&nbsp;&nbsp;&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp; bss&nbsp;&nbsp;&nbsp;&nbsp; dec&nbsp;&nbsp;&nbsp;&nbsp; hex filename<br>&nbsp;&nbsp;44898&nbsp;&nbsp; 17804&nbsp;&nbsp;&nbsp;&nbsp; 120&nbsp;&nbsp; 62822&nbsp;&nbsp;&nbsp;&nbsp;f566 spufs-before.o<br>&nbsp;&nbsp;44886&nbsp;&nbsp; 17804&nbsp;&nbsp;&nbsp;&nbsp; 120&nbsp;&nbsp; 62810&nbsp;&nbsp;&nbsp;&nbsp;f55a spufs-after.o<br>
<br>&gt; Maybe a better solution is to change the core dump code to not<br>&gt; require the mutex to be held in the first place. By the time<br>&gt; we get to call the get functions, it should already be in<br>&gt; saved state and no longer be able to get scheduled, so we might
<br>&gt; not actually need all the extra tricks with avoiding the<br>&gt; mutex to be taken again.<br><br>Well that&#39;d be nice, but I don&#39;t see anywhere that that happens. AFAICT<br>the acquire we do in the first coredump callback is the first the SPU
<br>contexts know about their PPE process dying. And spufs is still live, so<br>I think we definitely need to grab the mutex, or we might race with<br>userspace accessing spufs files.<br><br>cheers<br><br>--<br>Michael Ellerman
<br>OzLabs, IBM Australia Development Lab<br><br>wwweb: <a href="http://michael.ellerman.id.au">http://michael.ellerman.id.au</a><br>phone: +61 2 6212 1183 (tie line 70 21183)<br><br>We do not inherit the earth from our ancestors,
<br>we borrow it from our children. - S.M.A.R.T Person<br>-------------- next part --------------<br>A non-text attachment was scrubbed...<br>Name: not available<br>Type: application/pgp-signature<br>Size: 189 bytes<br>Desc: This is a digitally signed message part
<br>Url : <a href="http://ozlabs.org/pipermail/linuxppc-dev/attachments/20070913/d7914b17/attachment-0001.pgp">http://ozlabs.org/pipermail/linuxppc-dev/attachments/20070913/d7914b17/attachment-0001.pgp</a><br><br>------------------------------
<br><br>Message: 2<br>Date: Wed, 12 Sep 2007 15:36:55 +0200<br>From: Segher Boessenkool &lt;<a href="mailto:segher@kernel.crashing.org">segher@kernel.crashing.org</a>&gt;<br>Subject: Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DS port<br>To: Kumar Gala &lt;<a href="mailto:galak@kernel.crashing.org">galak@kernel.crashing.org</a>&gt;<br>Cc: <a href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a><br>Message-ID: &lt;<a href="mailto:a58bb9a05680c3befc4d3588992caed0@kernel.crashing.org">
a58bb9a05680c3befc4d3588992caed0@kernel.crashing.org</a>&gt;<br>Content-Type: text/plain; charset=US-ASCII; format=flowed<br><br>Looks a lot better, thanks!<br><br>Some minor nits and suggestions...<br><br>&gt; +/ {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; model = &quot;fsl,MPC8572DS&quot;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; compatible = &quot;fsl,MPC8572DS&quot;, &quot;fsl,MPC85xxDS&quot;;<br><br>We don&#39;t want &quot;xx&quot; compatible entries; especially here it makes<br>no sense at all.&nbsp;&nbsp;If the board is compatible to some other (older)
<br>board, just name that board explicitly.<br><br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PowerPC,8572@0 {<br><br>Maybe it would be good to use &quot;PowerPC,e500&quot; instead -- it would<br>make it easier to probe for the actual CPU type, that way.&nbsp;&nbsp;Not
<br>that Linux uses the name/compatible here at all ;-)<br><br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; soc8572@ffe00000 {<br><br>You should put an interrupt-parent in here, so you can get rid of<br>it in all the children.<br><br><br>And then there&#39;s the pci_bridge thing we&#39;re discussing on IRC, of
<br>course -- basically, get rid of the pci_bridge pseudo-node, and<br>move the interrupt-map for the south-bridge devices into the<br>south-bridge node.<br><br><br>Segher<br><br><br><br>------------------------------<br>
<br>Message: 3<br>Date: Wed, 12 Sep 2007 16:00:38 +0200<br>From: Segher Boessenkool &lt;<a href="mailto:segher@kernel.crashing.org">segher@kernel.crashing.org</a>&gt;<br>Subject: Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DS port<br>To: David Gibson &lt;<a href="mailto:david@gibson.dropbear.id.au">david@gibson.dropbear.id.au</a>&gt;<br>Cc: <a href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a><br>Message-ID: &lt;<a href="mailto:44b4b3a133980aeb6c596aad71612e6c@kernel.crashing.org">
44b4b3a133980aeb6c596aad71612e6c@kernel.crashing.org</a>&gt;<br>Content-Type: text/plain; charset=US-ASCII; format=flowed<br><br>&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uli1575@0 {<br>&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg = &lt;0 0 0 0 0&gt;;
<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; This looks kind of bogus...<br>&gt;&gt;<br>&gt;&gt; Its a PCIe to PCI bridge that is transparent.<br>&gt;<br>&gt; Right.... if it has no control registers, I think it should just lack<br>&gt; &#39;reg&#39;, not define a zero-length register block.
<br><br>&quot;reg&quot; for PCI config registers has length 0 always, it&#39;s defined that<br>way in the PCI binding.<br><br>But if this thing is transparent, it doesn&#39;t have PCI config regs.<br><br>&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#size-cells = &lt;2&gt;;
<br>&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#address-cells = &lt;3&gt;;<br>&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ranges = &lt;02000000 0 80000000<br>&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;02000000 0 80000000<br>&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 20000000
<br>&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;01000000 0 00000000<br>&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;01000000 0 00000000<br>&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 00100000&gt;;<br>&gt;<br>&gt; And if truly transparent, it should perhaps have just ranges;
<br>&gt; indicating that child addresses are identity mapped to parent<br>&gt; addresses.<br><br>If truly transparent, the node should just not be there at all!<br><br>&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pci_bridge@0 {<br>
&gt;&gt;&gt;<br>&gt;&gt;&gt; Ok.. why is pci_bridge nested within uli1575 - with the matching reg<br>&gt;&gt;&gt; and ranges, it looks like they ought to be one device.&nbsp;&nbsp;Also if this<br>&gt;&gt;&gt; is a PCI&lt;-&gt;PCI bridge, I believe it shold have device_type = &quot;pci&quot;.
<br>&gt;&gt;<br>&gt;&gt; We&#39;ve been using this as it stands for a while.&nbsp;&nbsp;If there are some<br>&gt;&gt; changes here that make sense I&#39;m willing to make them.<br>&gt;<br>&gt; Right, at present I don&#39;t see why you couldn&#39;t just ditch the
<br>&gt; pci_bridge node, and drop its contents straight into the uli1575 node.<br><br>Yeah.&nbsp;&nbsp;The preferred name for PCI-to-PCI bridge nodes is simply &quot;pci&quot;,<br>btw.<br><br><br>Segher<br><br><br><br>------------------------------
<br><br>Message: 4<br>Date: Thu, 13 Sep 2007 04:09:29 +0200<br>From: Segher Boessenkool &lt;<a href="mailto:segher@kernel.crashing.org">segher@kernel.crashing.org</a>&gt;<br>Subject: Re: [PATCH 1/5] Add Freescale DMA and DMA channel to
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Documentation/powerpc/booting-without-of.txt file.<br>To: Scott Wood &lt;<a href="mailto:scottwood@freescale.com">scottwood@freescale.com</a>&gt;<br>Cc: <a href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org
</a>, Zhang Wei-r63237<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;<a href="mailto:Wei.Zhang@freescale.com">Wei.Zhang@freescale.com</a>&gt;,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:paulus@samba.org">paulus@samba.org</a>, David Gibson<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;<a href="mailto:david@gibson.dropbear.id.au">
david@gibson.dropbear.id.au</a>&gt;<br>Message-ID: &lt;<a href="mailto:fd81b53021e39a13ea65c0a0319aab77@kernel.crashing.org">fd81b53021e39a13ea65c0a0319aab77@kernel.crashing.org</a>&gt;<br>Content-Type: text/plain; charset=US-ASCII; format=flowed
<br><br>&gt;&gt; I have a strange issue here. If I rename &#39;fsl,dma&#39; to<br>&gt;&gt; &#39;fsl,mpc8540-dma&#39;,<br>&gt;&gt; the &#39;fsl,mpc8540-dma-channel&#39; will be also regarded as DMA device not<br>&gt;&gt; DMA channel.
<br>&gt;<br>&gt; What tree are you using?&nbsp;&nbsp;Commit<br>&gt; 804ace8881d211ac448082e871dd312132393049<br>&gt; in Paul&#39;s git tree should have fixed that.<br><br>Strange, I don&#39;t see that commit -- maybe gitweb is broken, or
<br>maybe the patch was superseded, or maybe it just disappeared?<br>It&#39;s still shown in patchworks with this commit id fwiw.<br><br><br>Segher<br><br><br><br>------------------------------<br><br>Message: 5<br>Date: Wed, 12 Sep 2007 16:10:09 +0200
<br>From: Segher Boessenkool &lt;<a href="mailto:segher@kernel.crashing.org">segher@kernel.crashing.org</a>&gt;<br>Subject: Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DS port<br>To: Kumar Gala &lt;
<a href="mailto:galak@kernel.crashing.org">galak@kernel.crashing.org</a>&gt;<br>Cc: <a href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a>, David Gibson<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;<a href="mailto:david@gibson.dropbear.id.au">
david@gibson.dropbear.id.au</a>&gt;<br>Message-ID: &lt;<a href="mailto:cbff3b332b53f61721a8e14472347b98@kernel.crashing.org">cbff3b332b53f61721a8e14472347b98@kernel.crashing.org</a>&gt;<br>Content-Type: text/plain; charset=US-ASCII; format=flowed
<br><br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i8259: interrupt-controller@20 {<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;1 20 2<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 a0 2
<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 4d0 2&gt;;<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock-frequency = &lt;0&gt;;<br>&gt;&gt;<br>&gt;&gt; Hrm.. what is clock-frequency for on an i8259?&nbsp;&nbsp;I see that other 8259
<br>&gt;&gt; descriptions have this as well, so it&#39;s not a problem with this patch<br>&gt;&gt; specifically.<br>&gt;<br>&gt; Its a copy-paste thing so I don&#39;t know.<br><br>If your bootwrapper doesn&#39;t fill in this value, you should get rid
<br>of this property -- better to have no value than to have the wrong<br>value, esp. since it&#39;s probably unused anyway.<br><br><br>Segher<br><br><br><br>------------------------------<br><br>Message: 6<br>Date: Thu, 13 Sep 2007 00:22:58 +0200
<br>From: Segher Boessenkool &lt;<a href="mailto:segher@kernel.crashing.org">segher@kernel.crashing.org</a>&gt;<br>Subject: Re: [PATCH v4] [POWERPC] 85xx: Add basic Uniprocessor MPC8572<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DS port<br>To: Kumar Gala &lt;
<a href="mailto:galak@kernel.crashing.org">galak@kernel.crashing.org</a>&gt;<br>Cc: <a href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a><br>Message-ID: &lt;<a href="mailto:13038b1ac10f19f2e1fdbd0c1323c1e7@kernel.crashing.org">
13038b1ac10f19f2e1fdbd0c1323c1e7@kernel.crashing.org</a>&gt;<br>Content-Type: text/plain; charset=US-ASCII; format=flowed<br><br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; soc8572@ffe00000 {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells = &lt;1&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells = &lt;1&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type = &quot;soc&quot;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges = &lt;00000000 ffe00000 00100000&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;ffe00000 00001000&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;// CCSRBAR &amp; soc regs, remove once parse
<br>&gt; code for immrbase fixed<br><br>Hrm, if you remove it here, where else are you going to describe<br>the SoC control register block (whatever it is called -- is that<br>IMMR?)<br><br><br>Segher<br><br><br><br>------------------------------
<br><br>Message: 7<br>Date: Thu, 13 Sep 2007 00:10:38 +0200<br>From: Segher Boessenkool &lt;<a href="mailto:segher@kernel.crashing.org">segher@kernel.crashing.org</a>&gt;<br>Subject: Re: [PATCH] [POWERPC] DTS cleanup<br>To: Kumar Gala &lt;
<a href="mailto:galak@kernel.crashing.org">galak@kernel.crashing.org</a>&gt;<br>Cc: <a href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a><br>Message-ID: &lt;<a href="mailto:919c9b76c3e6e45af6e3fb887611a681@kernel.crashing.org">
919c9b76c3e6e45af6e3fb887611a681@kernel.crashing.org</a>&gt;<br>Content-Type: text/plain; charset=US-ASCII; format=flowed<br><br>&gt; * 32-bit in cpu node -- doesn&#39;t exist in any spec and not used by<br>&gt; kernel<br>
<br>Yeah.<br><br>&gt; * built-in for non-standard buses (ISA, PCI)<br><br>&quot;built-in&quot; is some weird CHRP property, so yes we don&#39;t need it<br>or want it.<br><br>&gt; * Removed #interrupt-cells in places they don&#39;t need to be set
<br><br>Great :-)<br><br>&gt; * Fixed ranges on lite5200*<br><br>This has a problem still:<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; model = &quot;fsl,mpc5200&quot;;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible = &quot;mpc5200&quot;;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; revision = &quot;&quot;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;// from bootloader
<br>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells = &lt;3&gt;;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type = &quot;soc&quot;;<br>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges = &lt;0 f0000000 f0010000&gt;;<br>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;f0000000 00010000&gt;;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges = &lt;0 f0000000 0000c000&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;f0000000 0000c000&gt;;<br><br>That makes &quot;reg&quot; and &quot;ranges&quot; identify an identical address range,<br>which means no subnode can claim any address in that range, so the
<br>&quot;ranges&quot; property should go.&nbsp;&nbsp;Alternatively, the &quot;reg&quot; might be<br>claiming too big a space.<br><br>Which is it?<br><br><br>Segher<br><br><br><br>------------------------------<br><br>Message: 8<br>
Date: Wed, 12 Sep 2007 15:20:14 +0200<br>From: Segher Boessenkool &lt;<a href="mailto:segher@kernel.crashing.org">segher@kernel.crashing.org</a>&gt;<br>Subject: Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;port<br>To: Scott Wood &lt;<a href="mailto:scottwood@freescale.com">scottwood@freescale.com</a>&gt;<br>Cc: Olof Johansson &lt;<a href="mailto:olof@lixom.net">olof@lixom.net</a>&gt;, <a href="mailto:linuxppc-dev@ozlabs.org">
linuxppc-dev@ozlabs.org</a><br>Message-ID: &lt;<a href="mailto:41e2e527c0f0dfceedf2ffe6cdf34816@kernel.crashing.org">41e2e527c0f0dfceedf2ffe6cdf34816@kernel.crashing.org</a>&gt;<br>Content-Type: text/plain; charset=US-ASCII; format=flowed
<br><br>&gt;&gt;&gt; well the ifdefs are orthogonal.&nbsp;&nbsp;We don&#39;t have a way of knowing<br>&gt;&gt;&gt; primary from the device tree today.<br>&gt;&gt;<br>&gt;&gt; How about something like &quot;fsl,primary-phb&quot; in the bus device node? I
<br>&gt;&gt; don&#39;t<br>&gt;&gt; know, maybe it&#39;s already been discussed and turned down for some<br>&gt;&gt; reason.<br>&gt;<br>&gt; It&#39;s more of a Linux issue than anything to do with the hardware.<br><br>Yeah, many machines actually have multiple &quot;primary PHBs&quot;, and
<br>Linux cannot really deal with that.&nbsp;&nbsp;It&#39;s probably best to handle<br>this from platform code.<br><br>&gt;&gt; Or would it be sufficient to check children of that device node to see<br>&gt;&gt; if the ULi is on that bus?
<br>&gt;<br>&gt; Or more generally, see if an isa node is somewhere in that subtree.<br><br>And if there is no ISA node, find any other legacy device (non-native<br>ATA controllers, ...), etc.<br><br><br>Segher<br><br><br>
<br>------------------------------<br><br>Message: 9<br>Date: Wed, 12 Sep 2007 16:51:25 +0200<br>From: Segher Boessenkool &lt;<a href="mailto:segher@kernel.crashing.org">segher@kernel.crashing.org</a>&gt;<br>Subject: Re: [PATCH] [RFC][POWERPC] Merge 32 and 64 bit
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pci_process_bridge_OF_ranges() instances<br>To: Arnd Bergmann &lt;<a href="mailto:arnd@arndb.de">arnd@arndb.de</a>&gt;<br>Cc: <a href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a><br>Message-ID: &lt;
<a href="mailto:4cd6407b936b2ce65c11092883e7b8d5@kernel.crashing.org">4cd6407b936b2ce65c11092883e7b8d5@kernel.crashing.org</a>&gt;<br>Content-Type: text/plain; charset=US-ASCII; format=flowed<br><br>&gt;&gt;&gt;&gt; +struct ranges_pci {
<br>&gt;&gt;&gt;&gt; +&nbsp;&nbsp;unsigned int pci_space;<br>&gt;&gt;&gt;&gt; +&nbsp;&nbsp;u64 pci_addr;<br>&gt;&gt;&gt;&gt; +&nbsp;&nbsp;phys_addr_t phys_addr;<br>&gt;&gt;&gt;&gt; +&nbsp;&nbsp;u64 size;<br>&gt;&gt;&gt;&gt; +} __attribute__((packed));<br>&gt;&gt;&gt;&gt; +
<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; This structure definition uses unaligned members because of the<br>&gt;&gt;&gt; &#39;packed&#39; attribute. Is that really what you intended?<br>&gt;&gt;&gt;<br>&gt;&gt; yes, exactly, because I&#39;m mapping this struct on ranges extracted from
<br>&gt;&gt; the dts instead of juggling with ranges[foo] offsets.<br>&gt;<br>&gt; I see. It does however look wrong to me, because you are using a<br>&gt; hardcoded<br>&gt; phys_addr_t type. This breaks when phys_addr has a different size from
<br>&gt; what<br>&gt; you expect, e.g. when booting a pure 32 bit kernel on a machine that<br>&gt; has<br>&gt; a 64 bit physical address space.<br><br>More generally, you can even have a different size for the &quot;phys_addr&quot;
<br>for different nodes in the same device tree.<br><br>You really should look at the #address-cells in this node&#39;s parent,<br>and translate that all the way up to the root node to get a CPU<br>address.<br><br><br>Segher
<br><br><br><br>------------------------------<br><br>Message: 10<br>Date: Wed, 12 Sep 2007 15:20:25 +0200<br>From: Segher Boessenkool &lt;<a href="mailto:segher@kernel.crashing.org">segher@kernel.crashing.org</a>&gt;<br>
Subject: Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;port<br>To: Kumar Gala &lt;<a href="mailto:galak@kernel.crashing.org">galak@kernel.crashing.org</a>&gt;<br>Cc: <a href="mailto:linuxppc-dev@ozlabs.org">
linuxppc-dev@ozlabs.org</a><br>Message-ID: &lt;<a href="mailto:6b92503d73565f8add983e64ad5d5d39@kernel.crashing.org">6b92503d73565f8add983e64ad5d5d39@kernel.crashing.org</a>&gt;<br>Content-Type: text/plain; charset=US-ASCII; format=flowed
<br><br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l2-cache-controller@20000 {<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible = &quot;fsl,8572-l2-cache-controller&quot;;<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;20000 1000&gt;;<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cache-line-size = &lt;20&gt;; // 32 bytes
<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cache-size = &lt;80000&gt;;&nbsp;&nbsp; // L2, 512K<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;mpic&gt;;<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts = &lt;10 2&gt;;<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };
<br>&gt;&gt;<br>&gt;&gt; Should this node be referenced by an l2-cache property in the cpu<br>&gt;&gt; node?<br>&gt;<br>&gt; No, its a front side cache.<br><br>What is a &quot;front side cache&quot;?&nbsp;&nbsp;What exactly does it cache?&nbsp;&nbsp;If it&#39;s
<br>a cache for one CPU only, that fact should be shown in the device<br>tree somehow.<br><br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type = &quot;pci&quot;;<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells = &lt;1&gt;;
<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells = &lt;2&gt;;<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells = &lt;3&gt;;<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;8000 1000&gt;;<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bus-range = &lt;0 ff&gt;;
<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges = &lt;02000000 0 80000000 80000000 0 20000000<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01000000 0 00000000 ffc00000 0 00010000&gt;;<br>&gt;&gt;<br>&gt;&gt; No prefetchable mem space?
<br>&gt;<br>&gt; we haven&#39;t normally provided prefetch on 85xx/86xx.. will deal with<br>&gt; this later.<br><br>If you don&#39;t set up prefetchable memory regions on the PCI from<br>the firmware, this code is fine, sure.&nbsp;&nbsp;It would be a good plan
<br>to do map all BARs that say they are prefetchable in some<br>prefetchable PCI window, it gives a nice speed boost, even when<br>the kernel accesses it as simple non-cacheable space: the PCI<br>bridges in between can streamline loads from these areas.
<br><br>In any case, the device tree should be in synch with how the<br>firmware set up the PCI hardware, and it seems that&#39;s what you<br>have now, so all is fine.<br><br><br>Segher<br><br><br><br>------------------------------
<br><br>Message: 11<br>Date: Wed, 12 Sep 2007 22:08:33 -0500<br>From: Kumar Gala &lt;<a href="mailto:galak@kernel.crashing.org">galak@kernel.crashing.org</a>&gt;<br>Subject: Re: [PATCH] [POWERPC] DTS cleanup<br>To: Segher Boessenkool &lt;
<a href="mailto:segher@kernel.crashing.org">segher@kernel.crashing.org</a>&gt;<br>Cc: <a href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a><br>Message-ID: &lt;<a href="mailto:8FFFBF2E-8255-40FB-836D-AB5B19222DD9@kernel.crashing.org">
8FFFBF2E-8255-40FB-836D-AB5B19222DD9@kernel.crashing.org</a>&gt;<br>Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed<br><br><br>On Sep 12, 2007, at 5:10 PM, Segher Boessenkool wrote:<br><br>&gt;&gt; * 32-bit in cpu node -- doesn&#39;t exist in any spec and not used by
<br>&gt;&gt; kernel<br>&gt;<br>&gt; Yeah.<br>&gt;<br>&gt;&gt; * built-in for non-standard buses (ISA, PCI)<br>&gt;<br>&gt; &quot;built-in&quot; is some weird CHRP property, so yes we don&#39;t need it<br>&gt; or want it.<br>
<br>Do you suggest we get ride of it from ISA nodes as well?<br><br>&gt;<br>&gt;&gt; * Removed #interrupt-cells in places they don&#39;t need to be set<br>&gt;<br>&gt; Great :-)<br>&gt;<br>&gt;&gt; * Fixed ranges on lite5200*
<br>&gt;<br>&gt; This has a problem still:<br>&gt;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;model = &quot;fsl,mpc5200&quot;;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compatible = &quot;mpc5200&quot;;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;revision = &quot;&quot;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;// from bootloader
<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#interrupt-cells = &lt;3&gt;;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;device_type = &quot;soc&quot;;<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ranges = &lt;0 f0000000 f0010000&gt;;<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg = &lt;f0000000 00010000&gt;;
<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ranges = &lt;0 f0000000 0000c000&gt;;<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg = &lt;f0000000 0000c000&gt;;<br>&gt;<br>&gt; That makes &quot;reg&quot; and &quot;ranges&quot; identify an identical address range,
<br>&gt; which means no subnode can claim any address in that range, so the<br>&gt; &quot;ranges&quot; property should go.&nbsp;&nbsp;Alternatively, the &quot;reg&quot; might be<br>&gt; claiming too big a space.<br>&gt;<br>&gt; Which is it?
<br><br>Yeah, I think it should be 0x100 for the &#39;soc&#39; regs on 52xx so I&#39;ll<br>set regs to that.<br><br>- k<br><br><br>------------------------------<br><br>_______________________________________________<br>Linuxppc-dev mailing list
<br><a href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br><br>End of Linuxppc-dev Digest, Vol 37, Issue 84
<br>********************************************<br></blockquote></div><br>

------=_Part_7202_30755943.1189657896784--
