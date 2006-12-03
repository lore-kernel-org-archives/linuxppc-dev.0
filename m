Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0931D67B52
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 10:16:36 +1100 (EST)
Date: Sun, 3 Dec 2006 23:23:49 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: pata_sl82c105 can not reserve IO region
Message-ID: <20061203232349.72be01e7@localhost.localdomain>
In-Reply-To: <20061203222450.GA23765@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
	<20061203171216.GB21947@aepfle.de>
	<20061203222450.GA23765@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 3 Dec 2006 23:24:49 +0100 (MET)
Olaf Hering <olaf@aepfle.de> wrote:

> This change seems to fix it, only a single reset occurs. I think that
> one is normal when a CD is in the drive during bootup, maybe it leaves
> the drive in a confused state.
> 
> @@ -167,9 +175,13 @@ static void sl82c105_reset_engine(struct
>         struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>         u16 val;
> 
> +       udelay(42);
>         pci_read_config_word(pdev, 0x7E, &val);
> +       udelay(10);
>         pci_write_config_word(pdev, 0x7E, val | 4);
> +       udelay(10);
>         pci_write_config_word(pdev, 0x7E, val & ~4);
> +       udelay(42);
>  }

Where do you get the delays from ? There is nothing in the documentation
or errata sheets I have here on that subject. Is this guesswork, divine
inspiration or an errata note I don't posess ?

In the absence of documented behaviour its seem to me much more likely
that the delay is actually either moving a race condition in the libata
code, or perhaps just allowing some time for the CD to "recover" in which
case it's perhaps a bit of a delay we need in libata. That would explain
why the old -> new change broke stuff.

Either way its most interesting it makes a difference.

Alan
