Message-Id: <m0znjja-0000WVC@tri-yann.crf.canon.fr>
Date: Wed, 9 Dec 1998 14:32:54 +0100 (CET)
From: "VALETTE Eric" <valette@crf.canon.fr>
To: paubert@iram.es
CC: cort@persephone.cs.nmt.edu, linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.HPP.3.96.981209114400.17076a-100000@gra-ux1.iram.es>
	(message from Gabriel Paubert on Wed, 9 Dec 1998 11:47:48 +0100 (MET))
Subject: Re: Incomplete (potentially broken) Raven Chipset support for PREP machines.
References: <Pine.HPP.3.96.981209114400.17076a-100000@gra-ux1.iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Gabriel" == Gabriel Paubert <paubert@iram.es> writes:

Gabriel> To quote Linus: there ain't such thing as interrupt priority (I disagree
Gabriel> for RT, and while trying to measure interrupt latency on VME, I've found
Gabriel> nasty occasional long delays). 

Being the guy that have specified and architectured Chorus Interrupt handling
I also disagree.

>> 3) handle multi-function devices?

Gabriel> Hopefully my patch works for multifunction devices too.

>> 4) Change the IRQ for PCI devices... (writting the PCI configuration
>> register is not sufficeint. You must also enable the interrupt in the
>> raven registers),

Gabriel> This is done when doing request_irq.

NO!. The actual code do nothing at RAVEN MPIC interrupt controller level.
It works because the cascade mode is not used (M bit of the RAVEN MPIC 
global configuration register Page 2-73 of the mcp750a/pg1  manual).

extract of motorola doc : 

M bit : 0 => pass through
        1 cascade mode

"CASCADE MODE. Allows cascading of an external 8259 pair connected 
to the first interrupt source input pin (0). In the pass through mode, 
interrupt source 0 is passed directly through to the processor 0 INT pin. 
RavenMPIC is essentially disabled. In the mixed mode, 8259 interrupts 
are delivered using the priority and distribution mechanism of RavenMPIC. 
The Vector/Priority and Destination registers for interrupt source 0 are 
used to control the delivery mode for all 8259 generated interrupt sources.

Basically anything that comes from ISA/PCI  go first through the 

	  8259_emulation = > raven => processor.


NOTE : there is no MPC106/MPC105 and I cannot figure what the following 
supposed code for routing the interrupts does...

-----------------
	unsigned char *ibc_pirq = (unsigned char *)0x80800860;   <===== Can find anything on RAVEN...
	unsigned char *ibc_pcicon = (unsigned char *)0x80800840;  <==== that lloks like this

	....

	/* Set up mapping from slots */
	for (i = 1;  i <= 4;  i++)
	{
		ibc_pirq[i-1] = Motherboard_routes[i];
	}
	/* Enable PCI interrupts */
	*ibc_pcicon |= 0x20;

-----------------

Gabriel> Note that if you have an initrd image, please send me. Eitehr I have
Gabriel> managed to destriy them all, or they have disappeared from vger. But 
Gabriel> I want to add initrd support to my bootloader.

You mean a ramdisk image??? Sure I have one but in order to use it you must
change you RAMDISK configuration to have 8192 instead of 4096 1K block...
Putting it on your ftp server is convenient?




-- 
   __                 
  /  `                   	Eric Valette
 /--   __  o _.          	Canon CRF
(___, / (_(_(__         	Rue de la touche lambert
				35517 Cesson-Sevigne  Cedex
				FRANCE
Tel: +33 (0)2 99 87 68 91	Fax: +33 (0)2 99 84 11 30
E-mail: valette@crf.canon.fr

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
