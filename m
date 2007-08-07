Return-Path: <ak@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E1297DDECD
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 11:24:24 +1000 (EST)
Sender: ak@suse.de
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 2.6.22.y] ieee1394: revert "sbp2: enforce
	32bit	DMA	mapping"
References: <fa.Qn3Snqoik3hhnxcA6HqjGV0Yzck@ifi.uio.no>
	<46B4B3DC.7020609@shaw.ca> <46B4B7C6.1040107@s5r6.in-berlin.de>
	<1186272926.938.8.camel@localhost.localdomain>
	<46B5824B.1000103@s5r6.in-berlin.de>
	<1186351473.938.21.camel@localhost.localdomain>
	<20070806135124.GA2900@suse.de>
	<1186436848.938.75.camel@localhost.localdomain>
	<46B79F25.50205@s5r6.in-berlin.de> <46B79FD7.9020801@shaw.ca>
	<46B7A537.9020807@s5r6.in-berlin.de>
From: Andi Kleen <andi@firstfloor.org>
Date: 07 Aug 2007 04:18:43 +0200
In-Reply-To: <46B7A537.9020807@s5r6.in-berlin.de>
Message-ID: <p73bqdkccjg.fsf@bingen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Hancock <hancockr@shaw.ca>, linuxppc-dev@ozlabs.org,
	Olaf Hering <olh@suse.de>, stable@kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Richter <stefanr@s5r6.in-berlin.de> writes:
> 
>   1.) The ieee1394 subsystem is known to work on x86_64 with more than 4
> GB RAM, 

It's actually ~3+GB where memory above the 4GB barrier starts appearing.
In some extreme cases even for 2+GB. 

> so I gather that architecture code already sets a proper DMA
> mask for all those 32bit PCI OHCI-1394 implementations out there.

If you don't set a DMA mask then the default is always 4GB.

-Andi
