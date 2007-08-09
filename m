Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 04809DDE32
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 14:16:50 +1000 (EST)
Date: Wed, 8 Aug 2007 23:16:32 -0500
From: Nathan Lynch <ntl@pobox.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC/PATCH] remove gratuitous reads from maple pci config space
	methods
Message-ID: <20070809041632.GA13921@localdomain>
References: <20070809005044.GD10114@localdomain>
	<20070809030555.GA8261@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070809030555.GA8261@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, Aug 08, 2007 at 07:50:44PM -0500, Nathan Lynch wrote:
> > The maple pci configuration space write methods read the written
> > location immediately after the write is performed, presumably in order
> > to flush the write.  However, configuration space writes are not
> > allowed to be posted, making these reads gratuitous.
> 
> It might be worth checking that there isn't a particular reason for
> these.  Just because posting writes are forbidden doesn't mean a
> particular bridge won't screw it up...

Well, I had already checked with Ben, who wrote the code, and my
understanding is that the reads are intended to work around some
misbehaving Apple bridges, but that a sync after the write (implied by
releasing pci_lock in the generic pci code) should suffice for those.
