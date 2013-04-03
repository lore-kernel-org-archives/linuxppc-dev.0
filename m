Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 7D2D62C012D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 05:01:44 +1100 (EST)
Message-ID: <1365012091.2882.252.camel@bling.home>
Subject: Re: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu
 implementation.
From: Alex Williamson <alex.williamson@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Date: Wed, 03 Apr 2013 12:01:31 -0600
In-Reply-To: <20130402161812.GI15687@8bytes.org>
References: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
 <1364500442-20927-6-git-send-email-Varun.Sethi@freescale.com>
 <20130402161812.GI15687@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: stuart.yoder@freescale.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, scottwood@freescale.com,
 Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-04-02 at 18:18 +0200, Joerg Roedel wrote:
> Cc'ing Alex Williamson
> 
> Alex, can you please review the iommu-group part of this patch?

Sure, it looks pretty reasonable.  AIUI, all PCI devices are below some
kind of host bridge that is either new and supports partitioning or old
and doesn't.  I don't know if that's a visibility or isolation
requirement, perhaps PCI ACS-ish.  In the new host bridge case, each
device gets a group.  This seems not to have any quirks for
multifunction devices though.  On AMD and Intel IOMMUs we test
multifunction device ACS support to determine whether all the functions
should be in the same group.  Is there any reason to trust multifunction
devices on PAMU?

I also find it curious what happens to the iommu group of the host
bridge.  In the partitionable case the host bridge group is removed, in
the non-partitionable case the host bridge group becomes the group for
the children, removing the host bridge.  It's unique to PAMU so far that
these host bridges are even in an iommu group (x86 only adds pci
devices), but I don't see it as necessarily wrong leaving it in either
scenario.  Does it solve some problem to remove them from the groups?
Thanks,

Alex
