Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4292ADDEDB
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 01:02:32 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m46F4c9j012043
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 11:04:38 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m46F2SPx259878
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 11:02:28 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m46F2SUd002832
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 11:02:28 -0400
Date: Tue, 6 May 2008 10:01:17 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] [POWERPC] 4xx: Fix problem with new TLB storage
	attibute fields on 440x6 core
Message-ID: <20080506100117.22c88b09@zod.rchland.ibm.com>
In-Reply-To: <1209970399-4464-1-git-send-email-sr@denx.de>
References: <1209970399-4464-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon,  5 May 2008 08:53:19 +0200
Stefan Roese <sr@denx.de> wrote:

> The new 440x6 core used on AMCC 460EX/GT introduces new storage attibure
> fields to the TLB2 word. Those are:
> 
> Bit  11   12   13   14   15
>      WL1  IL1I IL1D IL2I IL2D
> 
> With these bits the cache (L1 and L2) can be configured in a more flexible
> way, instruction- and data-cache independently now. The "old" I and W bits
> are still available and setting these old bits will automically set these
> new bits too (for backward compatibilty).
> 
> The current code does not clear these fields resulting in disabling the cache
> by chance. This patch now makes sure that these new bits are cleared when
> the TLB2 word is written.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>

Finally catching back up with email.  This looks like .26 material,
correct?

josh
