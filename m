Return-Path: <alex.williamson@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB5751A0058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 12:55:45 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5274A14011D
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 12:55:45 +1100 (AEDT)
Message-ID: <1427334941.3643.888.camel@redhat.com>
Subject: Re: [PATCH v4 4/4] drivers/vfio: Remove duplicated PE states
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Wed, 25 Mar 2015 19:55:41 -0600
In-Reply-To: <20150326005903.GA16778@shangw>
References: <1427325637-14345-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1427325637-14345-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <1427330788.3643.883.camel@redhat.com> <20150326005903.GA16778@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, agraf@suse.de, kvm@vger.kernel.org,
 david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-26 at 11:59 +1100, Gavin Shan wrote:
> On Wed, Mar 25, 2015 at 06:46:28PM -0600, Alex Williamson wrote:
> >On Thu, 2015-03-26 at 10:20 +1100, Gavin Shan wrote:
> >> The set of constants for PE states defined in uapi/linux/vfio.h is
> >> duplicated to uapi/asm/eeh.h. The patch removes the set from the
> >> former.
> >> 
> >> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> >> ---
> >>  include/uapi/linux/vfio.h | 5 -----
> >>  1 file changed, 5 deletions(-)
> >> 
> >> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >> index d81c17f..3fd1e86 100644
> >> --- a/include/uapi/linux/vfio.h
> >> +++ b/include/uapi/linux/vfio.h
> >> @@ -492,11 +492,6 @@ struct vfio_eeh_pe_op {
> >>  #define VFIO_EEH_PE_UNFREEZE_IO		2	/* Enable IO for frozen PE   */
> >>  #define VFIO_EEH_PE_UNFREEZE_DMA	3	/* Enable DMA for frozen PE  */
> >>  #define VFIO_EEH_PE_GET_STATE		4	/* PE state retrieval        */
> >> -#define  VFIO_EEH_PE_STATE_NORMAL	0	/* PE in functional state    */
> >> -#define  VFIO_EEH_PE_STATE_RESET	1	/* PE reset in progress      */
> >> -#define  VFIO_EEH_PE_STATE_STOPPED	2	/* Stopped DMA and IO        */
> >> -#define  VFIO_EEH_PE_STATE_STOPPED_DMA	4	/* Stopped DMA only          */
> >> -#define  VFIO_EEH_PE_STATE_UNAVAIL	5	/* State unavailable         */
> >>  #define VFIO_EEH_PE_RESET_DEACTIVATE	5	/* Deassert PE reset         */
> >>  #define VFIO_EEH_PE_RESET_HOT		6	/* Assert hot reset          */
> >>  #define VFIO_EEH_PE_RESET_FUNDAMENTAL	7	/* Assert fundamental reset  */
> >
> >How do you know that nobody depends on these defines?  I thought the
> >suggestion was to use the EEH_* defines for error injection, not to
> >remove existing VFIO_EEH_* defines.  You could certainly redefine these
> >in terms of EEH_* defines instead.  Thanks,
> >
> 
> QEMU should be the first user to utilize the EEH capability exposed by
> the host kernel, and I believe QEMU doesn't use those constants yet.
> So it's right time to move those constants to uapi/asm/eeh.h. Once some
> one starts to use them, it's impossible to do so.

There are soon to be four kernel versions out there with these defines,
you can't be sure that nobody has already or won't in the future do
VFIO/EEH development on those kernels.  The defines need to stay IMHO.
Thanks,

Alex
