Message-ID: <3B571F13.8F067B1@mvista.com>
Date: Thu, 19 Jul 2001 10:55:31 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: ashish anand <ashisha@india.infogain.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI Config access doesn't return correct data...
References: <3B567E57.D2339645@india.infogain.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


ashish anand wrote:

> Hi all,
> I found a strange behaviour of pci config access on my board.
> my host bridge is MPC107(address map b)
> indirect pci config access method with config_addr and config_data ports
> at 0xfec00000 and 0xfee00000.
>
> I am using sandpoint+750 board and Bluecat Linux.

Do yourself a favor and either use the latest 2_4_devel kernel or hhl2.0 kernel from mvista
for the sandpoint.

>
> I have a case of pci config not returning devid and vendorid correctly
> sometime 0x00000000 , hence the cards put in slot are not even detected ,
> in following conditions.
> (card not behaving correctly are scsi aha 294xxx and 3c905b n/w card
> but surprisingly INTEL 82559 always behaves correctly)
>
> 1> when you boot through osloader
>
> 2> when you put your scsi or 3com card in OUTER slot only
>
> but when i put mb() in definition of pcibios_xxxx_config_xxxx in file indirect_pci.c
> before and after the reading and writing the pci_config_addr and pci_config_data ports
> everything behaves correctly.
>
> it is clear that it was a reordering problem.
> i want a further comment on this ,why it should happen?
> noteworthy point is that it only happens when you ,
>
> boot through osloader + with scsi and 3com cards not intel one +  only when cards are put
> in OUTER slots.
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
