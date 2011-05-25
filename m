Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9A6FB6F9B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 19:57:30 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Kernel cannot see PCI device
Date: Wed, 25 May 2011 11:57:12 +0200
References: <BANLkTimm98Xxx8y9qM8DUSR4rTDPSFpgHw@mail.gmail.com>
	<BANLkTi=J5EFvs3nHDQXNQfyd0EejWJvzcQ@mail.gmail.com>
	<1306273388.7481.240.camel@pasglop>
In-Reply-To: <1306273388.7481.240.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201105251157.12537.sr@denx.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Prashant Bhole <prashantsmailcenter@gmail.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Tirumala Marri <tmarri@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 24 May 2011 23:43:08 Benjamin Herrenschmidt wrote:
> On Tue, 2011-05-24 at 10:25 +0530, Prashant Bhole wrote:
> > Fixed the problem by soft resetting the PCIe port in the function
> > ppc460ex_pciex_port_init_hw().
> > Is it a right thing to do?

<snip>

> Well, it's odd that you'd have to do that, maybe something the
> bootloader is doing ?
> 
> I personally don't mind but I'd like Stefan and/or Tirumala opinion on
> this.

Not sure. I had no problems with the PCIe cards I tested with the current 
code. But from my experience, this card reset behavior is highly card/device 
dependent.

It would be good to know that this new code doesn't break detection of other 
PCIe cards/devices. Prashant, did you check this new code with other PCIe 
cards/devices as well? If this patch doesn't break other PCIe cards like the 
Intel PRO/1000, then:

Acked-by: Stefan Roese <sr@denx.de>

Cheers,
Stefan
