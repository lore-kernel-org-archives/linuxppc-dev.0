Return-Path: <benh@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C785B1A000E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 17:56:49 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 25 Jun 2014 17:56:47 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3D47F3578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 17:56:45 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5P7uTfx11993356
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 17:56:29 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5P7uitG011270
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 17:56:44 +1000
Message-ID: <1403682997.4587.208.camel@pasglop>
Subject: Re: [RFC PATCH V3 06/17] ppc/pnv: allocate pe->iommu_table dynamically
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 25 Jun 2014 17:56:37 +1000
In-Reply-To: <53AA7F30.40504@ozlabs.ru>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <53A94DA8.6020206@ozlabs.ru> <20140625011211.GA5785@richard>
 <53AA4C32.7060004@ozlabs.ru> <20140625052758.GA8873@richard>
 <53AA7F30.40504@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, yan@linux.vnet.ibm.com, bhelgaas@google.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-06-25 at 17:50 +1000, Alexey Kardashevskiy wrote:

> > Yes, iommu_talbe's life time equals to PE lifetime, so when releasing a PE we
> > need to release the iommu table. Currently, there is one function to release
> > the iommu table, iommu_free_table() which takes a pointer of the iommu_table
> > and release it.
> > 
> > If the iommu table in PE is just a part of PE, it will have some problem to
> > release it with iommu_free_table(). That's why I make it a pointer in PE
> > structure.
> 
> So you are saying that you want to release PE by one kfree() and release
> iommu_table by another kfree (embedded into iommu_free_table()). For me
> that means that PE and iommu_table have different lifetime.
> 
> And I cannot find the exact place in this patchset where you call
> iommu_free_table(), what do I miss?

He has a point though... iommu_free_table() does a whole bunch of things
in addition to kfree at the end.

This is a discrepancy in the iommu.c code, we don't allocate the table,
it's allocated by our callers, but we do free it in iommu_free_table().

My gut feeling is that we should fix that in the core by moving the
kfree() out of iommu_free_table() and back into vio.c and
pseries/iommu.c, the only two callers, otherwise we can't wrap the table
structure inside another object if we are going to ever free it.

Cheers,
Ben.
