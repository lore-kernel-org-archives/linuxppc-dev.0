Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4FBF567B8D
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 14:05:16 +1000 (EST)
Date: Wed, 12 Apr 2006 06:05:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH 2/2] Base pSeries PCIe support
Message-ID: <20060412040503.GA7870@lst.de>
References: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
	<20060331161330.3c723103.moilanen@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060331161330.3c723103.moilanen@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 31, 2006 at 04:13:30PM -0600, Jake Moilanen wrote:
> This patch hooks our current interrupt subsystem and sets up a single
> vector MSI as if it was a LSI.  Multiple MSI vectors is coming in the
> future.

This is broken.  Linux drivers expect MSI to be disabled on ->probe.
There's at least two reasons for that:

 (1) Many devices that claim to implement MSI are actually broken in
     more or less subtile ways. and thus must use traditition INTx pins.
 (2) MSI defines relaxed semantics for dma synchronization.  Silently
     enabling MSI could cause subtile data corruption.
