Return-Path: <rmcguire@videopresence.com>
Received: from smtpout09-04.prod.mesa1.secureserver.net
	(smtpout09-04.prod.mesa1.secureserver.net [64.202.165.17])
	by ozlabs.org (Postfix) with SMTP id CA0EDDDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 02:21:18 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
References: <mailman.1454.1170226011.9285.linuxppc-embedded@ozlabs.org>
	<000601c74531$62220820$6405a8c0@absolut>
	<0ACC0A3E-9DF3-4927-8F67-E525BA0E6C13@kernel.crashing.org>
Subject: RE: Audigy SE / ca0106 driver for PowerPC?
Date: Wed, 31 Jan 2007 07:20:59 -0800
Message-ID: <000001c7454b$69a25ae0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <0ACC0A3E-9DF3-4927-8F67-E525BA0E6C13@kernel.crashing.org>
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

After comparing the driver methods to a couple of other PCI drivers that do
work on PowerPC <like the nvidia and ati stuff>, it looks like the methods
for accessing the PCI IO space are very depreciated in this driver..

Would it be safe to assume that if I were to modify the existing

chip->port = pci_resource_start(pcidev,0);
chip->res_port = request_region(chip->port, size);

outl(chip->port+MyReg, data);

To something like:

chip->port = pci_resource_start(pcidev,0);
snd_length = pci_resource_len(pcidev, 0);
snd_port = ioremap(chip->port, length);

outl(port+MyReg, data);

I am not sure if I want to leave the outl in there, perhaps a different
function, or just a direct assignment?

-Russ
-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org] 
Sent: Wednesday, January 31, 2007 6:53 AM
To: rmcguire@videopresence.com
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Audigy SE / ca0106 driver for PowerPC?


On Jan 31, 2007, at 6:14 AM, Russell McGuire wrote:

> All,
>
> I recently tried to plugin and use an Audigy SE PCI card with  
> 2.6.20 and
> noticed that it would lock up during driver registration.
>
> After a little digging, I found that the interrupt routine and a  
> few other
> functions are relying on the x86 inl() / outl() to read from the  
> sound card.
>
> Is anyone aware of a PPC port for this driver? Or if it would be  
> feasible? I
> haven't ported a driver between architectures before.
>
> Or does the inl() / outl() already have PPC equivalent functions  
> and I need
> to be looking for a PCI configuration problem with my system?

We implement these on PPC.  Clearly we don't have x86 style port IO,  
usually its handled by memory mapped access to a special region of  
memory that will be converted into a PCI IO space access.

- k
