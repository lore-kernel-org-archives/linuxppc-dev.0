Date: Fri, 18 Jan 2002 19:13:21 -0800
From: Ira Weiny <iweiny@acm.org>
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Walnut base board PCI problems
Message-Id: <20020118191321.7708fdaf.iweiny@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It has been some time since I have written to the list with a question so
forgive me if this deficient in some way.

We have a custom 405GP board which is basically a Walnut platform minus some of
the peripherals like keyboard/mouse, FPGA, etc.

We manufactured 10 boards and one works.  The others all display the same
behavior below.

We have an on board Promise IDE/PCI chip and 2 pci slots.  Whenever we have
just one device active on the PCI bus everything seems to be fine...  When we
start using a 2nd device the machine does one of 2 things.

1) One of the PCI devices fails.  But the machine is still running.
2) More often though the machine locks up.  (basically in an endless loop or
something)

There is no oops and the BDI reveals the processor to be at different places
and still running, although not responsive at the prompt.

All of the software including the kernel and user level code runs perfectly
fine on the Walnut reference platform so we are chasing a hardware problem.

My question is:

What is the best way to track this problem down?

We have read through the PCI spec and seen that there is an ErrStatus register
on each device which doesn't seem to be used anywhere in the kernel.  We don't
have a PCI bus analyzer or logic analyzer.  So we wanted to try and read these
registers to see if we could get an error report on what is happening but I
don't know how to do that with the BDI?

We have thought to try and have the BDI break on some condition but we don't
know what that condition might be.  Or if I could check those registers at irq
time somewhere and print them if I detected an error?  (using
pci_read_config_word)

This is a highly repeatable error.  And it only occurs when 2 devices are being
used.  We can have 2 devices in the machine but if I don't load the modules to
control them one device can run just fine.  The clocks on the PCI bus look fine
as well as voltages and all the basic hardware things to the slots.  And all
these cards work fine in other machines.

Any thoughts would be greatly appreciated.

Thanks,
Ira Weiny
iweiny@acm.org


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
