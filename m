Message-ID: <3B4D01C6.91646BE6@india.infogain.com>
Date: Thu, 12 Jul 2001 07:17:50 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI BAR initialisation..?
References: <3B4C0567.9BC25E5B@india.infogain.com> <15181.18002.484704.634903@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have mpc107 pci-host bridge.
motherboard is sandpoint + mcp750 processor.
pci_config_access method is indirect and config_address is 0xfec00000
config_data is 0xfee00000 rather than 0xcfc and 0xcf8.

i wonder if it would have been a case of memory reordering in that case
In bios how can we always believe on resource assignment of devices.
does it just a matter of chance that when we assign through bios this
reordering issue doesn't affect us..



Paul Mackerras wrote:
>
> ashish anand writes:
>
> > But by any chance if somebody has come across a random feature of pci BAR.
> > that is if you write the required pci addresses in BAR after writing 0xffffffff and
> > reading it back , and to confirm if the actual value has reached the BAR , we read it again
> > but then it returns funny values.
> >
> > more surprisingly if i move the code in some other function then everything behaves correctly.
> > I am more then sure that nothing relevant is happening betwen two places.
>
> Hmmm, that sounds like maybe the config space reads and writes are
> getting reordered, which would be a Bad Thing.
>
> What sort of PCI host bridge does your system have?
>
> If you place an mb() call after each pci config read or write, does
> that fix the problem?
>
> Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
