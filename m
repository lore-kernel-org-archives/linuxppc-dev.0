Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Leonardo Pereira Santos <lsantos@pd3.com.br>
To: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Card Services in a FADS850SAR board
Date: Tue, 12 Nov 2002 19:26:07 -0200
MIME-Version: 1.0
Message-Id: <200211121926.09433.lsantos@pd3.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



	I know, I know, the FADS board is a piece of c**p but it is the only card I
will have for some time now I i stuck with it :( . Ok, I trying to make the
boad's PCMCIA connector work. I'm using a recent kernel (2.4.20-pre11) in a
MPC850 processor, and the PCMCIA card is a WiFi card.
	First I compiled the kernel with built-in PCMCIA support and modules for the
card's drivers. The first strange thing is that the PCMCIA interrupt
generates a sig 11 error (kernel accessed bad area). But if I boot
(initialize Card Services) with the board already connected, the 8xx module
works fine. So I load up the three driver modules I need (hermes, orinoco,
orinoco_cs), but when I do a lsmod, the orinoco_cs is listed as unused.
Shouldn't the cs driver be used by Card Services? In Paul J. Lucas' page
about a PCMCIA in a PowerBook there is a fine "dummies guide" to make it
work. I followed it but CS' cardmanager doesn't load up the drivers, although
it identifies my card. In Paul's page, he says CS versions prior to 3.1.27
don't work out-of-the-box with a powerpc, and the kernel's version is 3.1.22.
	So I went to CS' HP, downloaded and complied  it to my kernel. After starting
CS with a insmod, when I tried to load the socked driver to the 8xx powerpc
(m8xx_pcmcia) , it generates a sig 11 error in the middle of its
initialization. As a desperate measure, I trying to integrate CS' new code
(3.2.3) in the kernel, but that gives me a very strange compilation error in
re resource management code.
	After all this, my questions are:
	Should I tell my boss to give me a new board RIGHT NOW?
	If there is hope of making it work on my card, why the orinoco_cs module is
unused?
	I got the powerpc kernel in bitkeeper, there is another kernel with a more
recent version of CS?
	Am I making something really stupid compiling CS? I justo follow its
Configure script.
	Now the question that I fear: There is need of a ISA bus? If yes, where do I
configure it, as there isn't any option in the general setup menu in the
kernel config.
	I'm configuring my kernel to support:
	- hot plugable devies,
	- CardBus,
	- 8xx support
	The rest is the module support to my WiFi card.
	Sorry for the long mail. I'd be very grateful if anyoune could give me any
information. Thanks a lot!

- --
"All things are ready, if our minds be so"
The Life Of King Henry V - William Sharespeare

Leonardo Pereira Santos
Engenheiro de Projetos
PD3 Tecnologia
av. Pará 330/202
(51) 3337 1237


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
