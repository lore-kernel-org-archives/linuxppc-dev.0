Return-Path: <rmcguire@videopresence.com>
Received: from smtpout10-04.prod.mesa1.secureserver.net
	(smtpout10-04.prod.mesa1.secureserver.net [64.202.165.238])
	by ozlabs.org (Postfix) with SMTP id 447A5DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 08:00:44 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
References: <mailman.1454.1170226011.9285.linuxppc-embedded@ozlabs.org>
	<000601c74531$62220820$6405a8c0@absolut>
	<0ACC0A3E-9DF3-4927-8F67-E525BA0E6C13@kernel.crashing.org>
	<000001c7454b$69a25ae0$6405a8c0@absolut>
	<0A655A39-4101-48B4-BE9C-50A30163679C@kernel.crashing.org>
Subject: RE: Audigy SE / ca0106 driver for PowerPC?
Date: Wed, 31 Jan 2007 13:00:19 -0800
Message-ID: <000701c7457a$d180e300$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <0A655A39-4101-48B4-BE9C-50A30163679C@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am using the Freescale MPC8360E, with U-boot 1.2.0.
When I compile the kernel <2.6.20-rc6> I select the MPC8360E-MDS board.
ARCH = PowerPC.

Well I might be all confused on the IO Remap, but if I look through the
nvidafb driver and the ati frame buffer driver I can see the
resource_start() and pci_resource_len() function being called, followed by
the ioremap() before any configuration is done with the PCI boards.

The ca0106 driver seems to miss this <ioremap> function, and it is the only
one that 100% locks the system up during the PCI probing <that I have
tried>, and it happens after/during the very first inl() or outl() command.

I read a thread someplace that says that pci_resource_start() is not
intended to return an actual address, but rather a token that is to be used
by the ioremap() function? It just happens that on some systems this value
is the same and so for some it will not fail with a missing ioremap(), but
others it will not be. To be safe it must be passed through ioremap()? This
is the deprecated part, <right term? Perhaps just bad assumption is a better
one> that this driver makes.

After looking through more drivers, this ioremap seems 100% in place on my
drivers. Maybe nobody has tested this with PowerPC in the past?

See this thread as an example:
http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-09/1187.html

Or see:
/drivers/video/nvidia/nvidia.c lines 1239->1243

Verses

/sound/pci/ca0106/ca0106_main.c 
lines 1279 till the interrupt request 
then lines 1069->1089 at which it locks on inl()

I don't mean to argue, I am just confused at this point.



-Russ
-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org] 
Sent: Wednesday, January 31, 2007 7:34 AM
To: rmcguire@videopresence.com
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Audigy SE / ca0106 driver for PowerPC?


On Jan 31, 2007, at 9:20 AM, Russell McGuire wrote:

> After comparing the driver methods to a couple of other PCI drivers  
> that do
> work on PowerPC <like the nvidia and ati stuff>, it looks like the  
> methods
> for accessing the PCI IO space are very depreciated in this driver..

Not sure I follow that comment, in*/out* have been the mechanisms to  
access PCI IO space for as long as I've know.

> Would it be safe to assume that if I were to modify the existing
>
> chip->port = pci_resource_start(pcidev,0);
> chip->res_port = request_region(chip->port, size);
>
> outl(chip->port+MyReg, data);
>
> To something like:
>
> chip->port = pci_resource_start(pcidev,0);
> snd_length = pci_resource_len(pcidev, 0);
> snd_port = ioremap(chip->port, length);
>
> outl(port+MyReg, data);
>
> I am not sure if I want to leave the outl in there, perhaps a  
> different
> function, or just a direct assignment?

You shouldn't have to do the ioremap, the PCI platform code should  
have already handled all of this.

What PPC platform are you on?

- k
