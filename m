Return-Path: <olaf@aepfle.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id C11FC67BC8
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 11:30:49 +1100 (EST)
Date: Mon, 4 Dec 2006 01:30:47 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_sl82c105 can not reserve IO region
Message-ID: <20061204003048.GA24585@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
	<20061203171216.GB21947@aepfle.de> <20061203222450.GA23765@aepfle.de>
	<20061203232349.72be01e7@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20061203232349.72be01e7@localhost.localdomain>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 03, Alan wrote:

> On Sun, 3 Dec 2006 23:24:49 +0100 (MET)
> Olaf Hering <olaf@aepfle.de> wrote:
> 
> > This change seems to fix it, only a single reset occurs. I think that
> > one is normal when a CD is in the drive during bootup, maybe it leaves
> > the drive in a confused state.
> > 
> > @@ -167,9 +175,13 @@ static void sl82c105_reset_engine(struct
> >         struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> >         u16 val;
> > 
> > +       udelay(42);
> >         pci_read_config_word(pdev, 0x7E, &val);
> > +       udelay(10);
> >         pci_write_config_word(pdev, 0x7E, val | 4);
> > +       udelay(10);
> >         pci_write_config_word(pdev, 0x7E, val & ~4);
> > +       udelay(42);
> >  }
> 
> Where do you get the delays from ? There is nothing in the documentation
> or errata sheets I have here on that subject. Is this guesswork, divine
> inspiration or an errata note I don't posess ?

Just guessing.
The udelay(10) calls can go, then it still works.
I moved the delays to the callers, which should have been equivalent,
but it failed again.
