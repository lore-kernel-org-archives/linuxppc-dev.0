Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id B9E1B2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Oct 2013 08:41:44 +1100 (EST)
Date: Sat, 5 Oct 2013 23:43:04 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Jon Mason <jon.mason@intel.com>
Subject: Re: [PATCH RFC 54/77] ntb: Ensure number of MSIs on SNB is enough
 for the link interrupt
Message-ID: <20131005214303.GA21589@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <5d9c5b2d3bbc444ff32bddeece7a239d046bd79c.1380703263.git.agordeev@redhat.com>
 <20131003004805.GL6768@jonmason-lab>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131003004805.GL6768@jonmason-lab>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 stable@vger.kernel.org, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-pci@vger.kernel.org, iss_storagedev@hp.com, linux-driver@qlogic.com,
 Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, e1000-devel@lists.sourceforge.net,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 02, 2013 at 05:48:05PM -0700, Jon Mason wrote:
> On Wed, Oct 02, 2013 at 12:49:10PM +0200, Alexander Gordeev wrote:
> > Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> > ---
> >  drivers/ntb/ntb_hw.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/ntb/ntb_hw.c b/drivers/ntb/ntb_hw.c
> > index de2062c..eccd5e5 100644
> > --- a/drivers/ntb/ntb_hw.c
> > +++ b/drivers/ntb/ntb_hw.c
> > @@ -1066,7 +1066,7 @@ static int ntb_setup_msix(struct ntb_device *ndev)
> >  		/* On SNB, the link interrupt is always tied to 4th vector.  If
> >  		 * we can't get all 4, then we can't use MSI-X.
> >  		 */
> > -		if (ndev->hw_type != BWD_HW) {
> > +		if ((rc < SNB_MSIX_CNT) && (ndev->hw_type != BWD_HW)) {
> 
> Nack, this check is unnecessary.

If SNB can do more than SNB_MSIX_CNT MSI-Xs then this check is needed
to enable less than maximum MSI-Xs in case the maximum was not allocated.
Otherwise SNB will fallback to single MSI instead of multiple MSI-Xs.

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
