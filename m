Date: Wed, 9 Dec 1998 11:47:48 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: VALETTE Eric <valette@crf.canon.fr>
cc: cort@persephone.cs.nmt.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: Incomplete (potentially broken) Raven Chipset support for PREP machines.
In-Reply-To: <m0zmwWp-0000WWC@tri-yann.crf.canon.fr>
Message-ID: <Pine.HPP.3.96.981209114400.17076a-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 7 Dec 1998, VALETTE Eric wrote:

> I'm affraid,  parsing residual data if far from beeing sufficient : as far as I 
> understand, the residual data are set up by the boot loader. How will that help
> to :
>    1) reprogram and IDE controller to native PCI mode rather than "legacy PC"
>    mode,
>    2) change the set up interrupt priorities ? (the raven can do that),

To quote Linus: there ain't such thing as interrupt priority (I disagree
for RT, and while trying to measure interrupt latency on VME, I've found
nasty occasional long delays). 

>    3) handle multi-function devices?

Hopefully my patch works for multifunction devices too.

>    4) Change the IRQ for PCI devices... (writting the PCI configuration
>    register is not sufficeint. You must also enable the interrupt in the
>    raven registers),

This is done when doing request_irq.

> Gabriel> I have code which correctly extracts the interrupt routing from the
> Gabriel> residual data, I hope to make it public next week, it has been working
> Gabriel> for two weeks on my MVME2600 and simply needs some cleanup:
> 
> Gabriel> [root@vcorr1 ppc]# cat /proc/interrupts
> Gabriel>            CPU0       
> Gabriel>   1:          8     82c59     keyboard
> Gabriel>   2:          0     82c59     cascade
> Gabriel>   4:        191     82c59     serial
> Gabriel>  16:          0   OpenPIC     82c59 cascade
> Gabriel>  18:      17047   OpenPIC     DC21140 (eth0)
> Gabriel>  19:       7429   OpenPIC     ncr53c8xx
> Gabriel>  21:       7542   OpenPIC     vme (universe)
> Gabriel> BAD:          1               spurious or short
> 
> I would love to test it on my MCP750 system to see how the IDE controller irq
> is routed... This would probably enable me to install my own Linux installation...

Note that if you have an initrd image, please send me. Eitehr I have
managed to destriy them all, or they have disappeared from vger. But 
I want to add initrd support to my bootloader.

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
