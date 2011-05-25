Return-Path: <prashantsmailcenter@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26AF0B6F9B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 20:48:55 +1000 (EST)
Received: by iym7 with SMTP id 7so7168633iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 03:48:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201105251157.12537.sr@denx.de>
References: <BANLkTimm98Xxx8y9qM8DUSR4rTDPSFpgHw@mail.gmail.com>
	<BANLkTi=J5EFvs3nHDQXNQfyd0EejWJvzcQ@mail.gmail.com>
	<1306273388.7481.240.camel@pasglop> <201105251157.12537.sr@denx.de>
Date: Wed, 25 May 2011 16:18:52 +0530
Message-ID: <BANLkTimtYqH1Nsx5gKmHRQecFWVmFbKeBw@mail.gmail.com>
Subject: Re: Kernel cannot see PCI device
From: Prashant Bhole <prashantsmailcenter@gmail.com>
To: Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Bjorn Helgaas <bhelgaas@google.com>, Tirumala Marri <tmarri@apm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 25, 2011 at 3:27 PM, Stefan Roese <sr@denx.de> wrote:
> On Tuesday 24 May 2011 23:43:08 Benjamin Herrenschmidt wrote:
>> On Tue, 2011-05-24 at 10:25 +0530, Prashant Bhole wrote:
>> > Fixed the problem by soft resetting the PCIe port in the function
>> > ppc460ex_pciex_port_init_hw().
>> > Is it a right thing to do?
>
> <snip>
>
>> Well, it's odd that you'd have to do that, maybe something the
>> bootloader is doing ?
>>
>> I personally don't mind but I'd like Stefan and/or Tirumala opinion on
>> this.
>
> Not sure. I had no problems with the PCIe cards I tested with the current
> code. But from my experience, this card reset behavior is highly card/device
> dependent.
>
> It would be good to know that this new code doesn't break detection of other
> PCIe cards/devices. Prashant, did you check this new code with other PCIe
> cards/devices as well? If this patch doesn't break other PCIe cards like the
> Intel PRO/1000, then:
>

I agree, this behavior is device specific. I have other boards with
different disk
controller chips. Those chips were detected without soft resetting the port.
New code has been checked with three PCIe devices:
Marvell 88SE9485, SiI 3132 and LSISAS2008.


-Prashant
