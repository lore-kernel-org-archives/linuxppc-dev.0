Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Dan Malek <dan@mvista.com>
Subject: Re: drivers - modules versus compiled in?
Date: Thu, 1 Nov 2001 13:11:30 -0500
Cc: linuxppc-dev@lists.linuxppc.org
References: <20011031211539.SIZF7882.tomts5-srv.bellnexxia.net@there> <3BE18AE4.1070507@mvista.com> <20011101175923.FDKP6233.tomts6-srv.bellnexxia.net@there>
In-Reply-To: <20011101175923.FDKP6233.tomts6-srv.bellnexxia.net@there>
MIME-Version: 1.0
Message-Id: <20011101180859.NUCU21717.tomts13-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I forgot to include my info:

Kernel 2.4.10-ac6
PowerMac B+W G3 with 512Meg with every pci slot filled
(Adaptec SCSI Card, Radeon 32Meg Mac Edition PCI Card, and an AsanteFast
10/100 NIC (the one I am trying to get to work better).

Thanks,

Kevin

On November 1, 2001 01:01, Kevin B. Hendricks wrote:
> Hi Dan,
>
> The driver in question is the tulip nic driver with my modifications to
> support the PNIC_II chip (but most of the driver is common acrosss other
> chips that tulip supports including transmit and receive buffer code,
> which I have not touched)
>
> The funny thing is that when compiled as a module, it works flawlessly.
> But when I compile it into the kernel, it seems a bit flakey and some
> received packets get lost somehow (I can see the transmitted packets
> generating link activity on the switch, but nothing seems to come the
> other way).  The driver debug messages all look sane and it looks like
> the driver is working but not data is ever returned from the card.
>
> This driver does use DMA and does allocate buffer space for it.
>
> Given the "virt_to_bus()' issue you describe, I would expect the
> compiled in kernel to be the working one and not the one built as a
> module.
>
> Are there any mechanisms that would help isolate a module's memory from
> corruption that don't exist when compiled into a kernel?
>
> Thanks,
>
> Kevin
>
> On November 1, 2001 12:48, you wrote:
> > Kevin B. Hendricks wrote:
> > > Are the allocated memory areas differnt?
> >
> > Yes, this is usually why you may see different behavior.  First,
> > the module itself is allocated from kernel memory that other errant
> > pointers could access that wouldn't otherwise.  Usually, the problem
> > is related to buffers or data structures the driver allocates that
> > are further used for DMA operations.  Things like 'virt_to_bus()'
> > won't work on static objects in a module, while it will in a
> > compiled driver.
> >
> > > Any hints as to what might have changed?
> >
> > Provide some hints to us :-).  What type of system, what
> > kernel, what driver?
> >
> > Thanks.
> >
> >
> > 	-- Dan
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
