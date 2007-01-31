Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51F26DDF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 02:35:27 +1100 (EST)
In-Reply-To: <000001c7454b$69a25ae0$6405a8c0@absolut>
References: <mailman.1454.1170226011.9285.linuxppc-embedded@ozlabs.org>
	<000601c74531$62220820$6405a8c0@absolut>
	<0ACC0A3E-9DF3-4927-8F67-E525BA0E6C13@kernel.crashing.org>
	<000001c7454b$69a25ae0$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0A655A39-4101-48B4-BE9C-50A30163679C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Audigy SE / ca0106 driver for PowerPC?
Date: Wed, 31 Jan 2007 09:34:16 -0600
To: <rmcguire@videopresence.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


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
