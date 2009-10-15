Return-Path: <blofeldus@yahoo.com>
Received: from web53511.mail.re2.yahoo.com (web53511.mail.re2.yahoo.com
	[206.190.39.65]) by ozlabs.org (Postfix) with SMTP id AF012B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 14:56:56 +1100 (EST)
Message-ID: <71202.24923.qm@web53511.mail.re2.yahoo.com>
Date: Wed, 14 Oct 2009 20:56:53 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
Subject: Yenta + sata_sil + 2.6.30.8 fails because dma_ops==NULL
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi
 I have a powerbook G4 which has drives connected via a cardbus sata_sil. It is running fedora 11. It boots fine with 2.6.27.35-170.2.94.fc10.ppc, but with 2.6.30.8-64.fc11.ppc because of an error in the probe function of sata_sil.

 I have traced the problem to be the line in sata_sil.c function sil_init_one

    rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);

which returns -5 (-EIO) because 

 get_dma_ops(&pdev->dev);

returns NULL.

I looked at the diffs to sata_sil.c between these kernel revs and didn't see the problem. Seems to be something at a higher level changed.

Any ideas where I should look or how to find the real cause?

Thanks
-roger

P.S., on the working kernel lspci gives:
0001:11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3512 [SATALink/SATARaid] Serial ATA Controller (rev 01)


      
