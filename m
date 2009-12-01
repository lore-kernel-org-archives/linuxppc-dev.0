Return-Path: <mikpe@it.uu.se>
Received: from fanny.its.uu.se (fanny.its.uu.se [130.238.4.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 819C9B6F1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 22:17:57 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19220.62569.492975.964154@pilspetsen.it.uu.se>
Date: Tue, 1 Dec 2009 11:48:09 +0100
From: Mikael Pettersson <mikpe@it.uu.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio,
	driver Apple PowerMac/PowerBook IDE controller
In-Reply-To: <20091201070834.6A840B7B63@ozlabs.org>
References: <20091201070834.6A840B7B63@ozlabs.org>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	jeff@garzik.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:
 > This is a libata driver for the "macio" IDE controller used on most Apple
 > PowerMac and PowerBooks. It's a libata equivalent of drivers/ide/ppc/pmac.c
 > 
 > It supports all the features of its predecessor, including mediabay hotplug
 > and suspend/resume. It should also support module load/unload.
 > 
 > The timing calculations have been simplified to use pre-calculated tables
 > compared to drivers/ide/pmac.c and it uses the new mediabay interface
 > provided by a previous patch.
 > 
 > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
 > ---
 > 
 > Only lightly tested so far, this is for review, NOT for merge.
 > 
 > I would like to merge it eventually via the powerpc tree since there's a
 > few dependent patches, though I would need the libata "fix" for
 > bmdma_stop to go in first, unless I carry it as well with appropriate
 > acks.
 > 
 > I have addressed some of the comments from the previous version (almost a
 > year ago I think). I have kept the single function for the PIO and DMA
 > timings due to the one bit overlap between the fields in the HW register
 > on the shasta chipset. It seems to work fine.

Thanks for reviving pata_macio.

Does the new version work with yaboot? (the previous one didn't)

/Mikael
