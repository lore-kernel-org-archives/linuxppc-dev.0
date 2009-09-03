Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BDC05B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Sep 2009 02:21:28 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n83GEgFd008297
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2009 12:14:42 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n83GLNnb239588
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2009 12:21:23 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n83GLLnx028563
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2009 12:21:22 -0400
Date: Thu, 3 Sep 2009 12:21:15 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Adam Zilkie <azilkie@datacast.com>
Subject: Re: AW: PowerPC PCI DMA issues (prefetch/coherency?)
Message-ID: <20090903162115.GB22047@zod.rchland.ibm.com>
References: <1251926572.10090.17.camel@Adam> <4A9F78AF.4010206@oxtel.com>
	<1251971849.15089.28.camel@pasglop> <1251993890.2548.14.camel@Adam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1251993890.2548.14.camel@Adam>
Cc: Chris Pringle <chris.pringle@oxtel.com>,
	Andrea Zypchen <azypchen@intldata.ca>,
	linuxppc-dev@lists.ozlabs.org, Tom Burns <tburns@datacast.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 03, 2009 at 12:04:50PM -0400, Adam Zilkie wrote:
>Ben,
>
>Thanks for your info.
>
>Are you sure there is L2 cache on the 440?

It depends on which 440 SoC you have.  It also depends on that being 
configured in the kernel even if it does exist.

>I am seeing this problem with our custom IDE driver which is based on
>pretty old code. Our driver uses pci_alloc_consistent() to allocate the
>physical DMA memory and alloc_pages() to allocate a virtual page. It
>then uses pci_map_sg() to map to a scatter/gather buffer. Perhaps I
>should convert these to the DMA API calls as you suggest.

I would suggest updating the code.  I have no idea if that is the problem,
but it should probably be done anyway.

josh
