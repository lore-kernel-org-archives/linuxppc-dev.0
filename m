From: Benjamin Herrenschmidt <bh40@calva.net>
To: Tibor Pausz <pausz@stud.uni-frankfurt.de>,
        linuxppc-dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Status of PCI-PCI bridge on UMAX S900
Date: Thu, 4 Jan 2001 21:41:04 +0100
Message-Id: <19341129141248.27470@mailhost.mipsys.com>
In-Reply-To: <19341129125123.15815@mail.server.uni-frankfurt.de>
References: <19341129125123.15815@mail.server.uni-frankfurt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>it seems like someone was confused about the meaning of the 'interrupts'
>>property when they wrote prom.c.  its basically the number of interrupts
>>supported by this pci device.  interpret_dbdma_props() also has the
>>same confusion, so the following would be a more complete patch to
>>prom.c.  note that it checks to see if a pci node has an interrupt
>>property before assigning one, otherwise devices on the far side of
>>a pci bridge (that shares interrupts) would be assigned interrupts
>>when they dont need them.
>
>Today I tried your patch. Well, I breaks the hole interrupt stuff.
>Now, even Mesh has trouble with interrupts (kernel crash), the
>console=ttyS0 doesn't work so no output from the booting ...

The "interrupts" property can have various meanings depending on the OF
version, I suggest you don't mess with it. Just check that if you find no
AAPL,interrupts, and that pmac_newworld == 0, then look for parent
AAPL,interrupts.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
