Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 12A6BDDDF0
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 01:01:35 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB4E0CgP002524
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 07:00:12 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB4E1GC3063886
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 07:01:17 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB4E1Fbo021133
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 07:01:15 -0700
Date: Thu, 4 Dec 2008 09:01:07 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] ndfc driver
Message-ID: <20081204090107.20269571@zod.rchland.ibm.com>
In-Reply-To: <20081203222832.3fc77d28@lappy.seanm.ca>
References: <20081203222832.3fc77d28@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 3 Dec 2008 22:28:32 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

Hi Sean,

A couple of comments/requests below.

> The current ndfc driver only compiles under arch/ppc. This arch was
> removed from the kernel. I notice the event entry for the ndfc in
> Kconfig has been removed in 2.6.28.
> 
> This patch converts the ndfc to a proper OF (OpenFirmware) driver. I
> can give a working example of the DTS if needed.

In addition to an example DTS patch (probably to warp itself), could
you briefly write up a binding and put it in
Documentation/powerpc/dts-bindings/amcc (or similar)?  Also please CC
the devicetree-discuss list on that part.

> The patch has been in production use on the PIKA Warp Appliance and is
> in use by others. The Warp basically boots from NAND, so the ndfc driver
> is very important to us.

Looking over the patch it seems pretty straight-forward and I don't see
anything immediately wrong with it.  You do have a number of
semi-unrelated changes to the actual port to of_platform though, like
the s/__raw_writel/out_be32 stuff, the addition of partition parsing,
etc.  I'm wondering if you could do those fixups separately from the
actual port.

Also, could you document why the data structures changed as they did in
the changelog or perhaps in a summary email.

You also seem to only support a single NAND chip, however the NDFC can
support multiple chips.  Have you looked at how the the fsl_elbc_nand
driver does multiple chip support?  If not, could you at least document
the limitation in the patch?

> This is a bi-monthly posting ;)

Keep at it Sean.  Your work is appreciated, even if the rest of us are
slow to review.

josh
