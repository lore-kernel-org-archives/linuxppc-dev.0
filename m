Date: Thu, 10 Apr 2003 01:32:41 -0700
From: Ira Weiny <iweiny@acm.org>
Subject: Machine Check question
To: linuxppc <linuxppc-dev@lists.linuxppc.org>
Message-id: <20030410013241.3ae349e5.iweiny@acm.org>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have put some more effort into my Microdrive (PCMCIA IDE) problem.

What I don't understand is, if a machine check is the CPU flagging an incorrect
address reference, what does a Power Mac do to make that address range valid in
the MMU?  (Or whatever is flagging that error when the address goes out on the
bus?)

I have searched all over for some function but I don't see it.  It would seem
to me that ioremap would do this.

The way I figure it I have one kernel which uses an address to access
the IDE registers on the card.  And now the new kernel uses the same address
and it machine checks.  (Both address are 0x170-0x177)  I am concluding that
there is something not set up right in the new kernel.  However, I don't see
anything which ioremap's those addresses in either kernel.  I see
request_resource but AFAICT that just keeps a software mapping of the resources
and does not actually set up any page tables or what not that would be causing
the machine check.

I guess I am fighting this more so that I might learn once and for all how the
virtual memory system works on these pmacs...

I have read the IO-mapping.txt doc and I understand it in principle but I would
like to learn more...

So.. I do some more digging and find that really all the ide calls are just
"IN_BYTE" and "OUT_BYTE" calls.  They just add _IO_BASE to the address which
is...  isa_io_base  and call (in/out)_8 which is an inline assembly call for
the actual operation.

So this is very confusing.  If I have the same address given to the same
function and dereferenced, why would one give me a machine check and the other
not?

During my digs I have found some interesting things most notably
"pcibios_fixup_cardbus" has some major differences between the two versions.  I
don't think this would have anything to do with a machine check but...  If a
PCI device was not configured correctly would it "refuse" an address maped to
it and could that cause a machine check?  If so then pcibios_fixup_cardbus
might be suspect.

"check_for_io_childs" called by "do_fixup_p2p_level" seems more likely a
problem.  But I can't trace it to anything so I am not sure if it is being run.

I also have the following in my messages file.

kernel: Can't get bus-range for /pci@f2000000/cardbus@1a

That seems suspicious.  But following that leads to "fixup_one_level_bus_range"
which once again does not seem to make any mappings.  (Unless it is store and
done later, which is what I would hope someone could tell me?)

Well that is enough for this message I am sure.  Thanks in advance for any
clues you all might have...

Thanks,
Ira Weiny
iweiny@acm.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
