Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: michael@ellerman.id.au
Subject: Re: [Cbe-oss-dev] [patch 11/11] powerpc/cell: Add
	DMA_ATTR_STRONG_ORDERING dma attribute and use in IOMMU code
Date: Mon, 7 Jul 2008 11:01:24 +0200
References: <20080704190535.316377278@arndb.de>
	<200807052351.39945.arnd@arndb.de>
	<1215388851.19157.0.camel@localhost>
In-Reply-To: <1215388851.19157.0.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200807071101.25286.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 07 July 2008, Michael Ellerman wrote:
> 
> > It turned out that the firmware sets up the south bridge to never set the 'S'
> > bit on incoming transactions, which overrides the IOPTE_SO_RW bits, on all
> > existing cell hardware.
> 
> It seems strange to me that the southbridge is allowed to override the
> setting in the IOMMU page table, but if that's what the doc says ..

That's what I thought at first as well, but it actually makes sense:
If the bridge knows that a data packet has been reordered already
by the originator or one of its own busses, there is no point in
enforcing strong ordering at the IOMMU again.

	Arnd <><
