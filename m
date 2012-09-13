Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 35DFA2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 08:41:47 +1000 (EST)
Date: Thu, 13 Sep 2012 17:41:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] vfio: enabled and supported on power (v7)
Message-ID: <20120913224127.GA31437@buserror.net>
References: <20120821113534.GS29724@truffula.fritz.box>
 <1346744035-31154-1-git-send-email-aik@ozlabs.ru>
 <1347292924.24938.45.camel@ul30vt.home>
 <504EF638.3090507@ozlabs.ru>
 <1347575699.24938.344.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1347575699.24938.344.camel@ul30vt.home>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2012 at 04:34:59PM -0600, Alex Williamson wrote:
> Do you only want VFIO drivers to work on POWER if they're written by
> POWER people?  Ideally there are a few simple concepts: a) devices have
> an I/O virtual address space.  On x86 we call this the iova and it's
> effectively a zero-based, 64bit (not really, but close enough) address
> space.  You seem to have two smaller windows, one in 32bit space,
> another in 64bit space (maybe we could name these more consistently).
> b) Userspace has a buffer that they want to map and unmap to an iova,
> potentially with some access flags.  That's all you need to know to use
> the x86 _type1 VFIO IOMMU API.  Why do I need to know about H_PUT_TCE to
> use this interface?  Let's assume there might be some VFIO drivers some
> day that aren't written by POWER people.  Thanks,

I'm not familiar with the POWER IOMMU, but certainly with our chips it
would help allow generic drivers to work if there were a type of mapping
operation where the IOMMU driver decides the IOVA and returns it, instead
of the driver trying to choose the IOVA with no knowledge of the IOMMU's
constraints.

-Scott
