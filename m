Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF7921A0680
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 12:27:10 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 630A214011D
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 12:27:10 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 11:27:08 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AA1D12CE8054
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 12:27:04 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2Q1QuJa30343308
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 12:27:04 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2Q1QUBl020851
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 12:26:30 +1100
Date: Thu, 26 Mar 2015 12:26:06 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 4/4] drivers/vfio: Remove duplicated PE states
Message-ID: <20150326012606.GA17303@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1427325637-14345-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1427325637-14345-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <1427330788.3643.883.camel@redhat.com>
 <20150326010157.GA28039@voom.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150326010157.GA28039@voom.redhat.com>
Cc: linuxppc-dev@ozlabs.org, Alex Williamson <alex.williamson@redhat.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm@vger.kernel.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 26, 2015 at 12:01:57PM +1100, David Gibson wrote:
>On Wed, Mar 25, 2015 at 06:46:28PM -0600, Alex Williamson wrote:
>> On Thu, 2015-03-26 at 10:20 +1100, Gavin Shan wrote:
>> > The set of constants for PE states defined in uapi/linux/vfio.h is
>> > duplicated to uapi/asm/eeh.h. The patch removes the set from the
>> > former.
>> > 
>> > Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> > ---
>> >  include/uapi/linux/vfio.h | 5 -----
>> >  1 file changed, 5 deletions(-)
>> > 
>> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> > index d81c17f..3fd1e86 100644
>> > --- a/include/uapi/linux/vfio.h
>> > +++ b/include/uapi/linux/vfio.h
>> > @@ -492,11 +492,6 @@ struct vfio_eeh_pe_op {
>> >  #define VFIO_EEH_PE_UNFREEZE_IO		2	/* Enable IO for frozen PE   */
>> >  #define VFIO_EEH_PE_UNFREEZE_DMA	3	/* Enable DMA for frozen PE  */
>> >  #define VFIO_EEH_PE_GET_STATE		4	/* PE state retrieval        */
>> > -#define  VFIO_EEH_PE_STATE_NORMAL	0	/* PE in functional state    */
>> > -#define  VFIO_EEH_PE_STATE_RESET	1	/* PE reset in progress      */
>> > -#define  VFIO_EEH_PE_STATE_STOPPED	2	/* Stopped DMA and IO        */
>> > -#define  VFIO_EEH_PE_STATE_STOPPED_DMA	4	/* Stopped DMA only          */
>> > -#define  VFIO_EEH_PE_STATE_UNAVAIL	5	/* State unavailable         */
>> >  #define VFIO_EEH_PE_RESET_DEACTIVATE	5	/* Deassert PE reset         */
>> >  #define VFIO_EEH_PE_RESET_HOT		6	/* Assert hot reset          */
>> >  #define VFIO_EEH_PE_RESET_FUNDAMENTAL	7	/* Assert fundamental reset  */
>> 
>> How do you know that nobody depends on these defines?  I thought the
>> suggestion was to use the EEH_* defines for error injection, not to
>> remove existing VFIO_EEH_* defines.  You could certainly redefine these
>> in terms of EEH_* defines instead.  Thanks,
>
>Yeah, since they're already exported, these can't be just removed, but
>should be redefined in terms of the new exported EEH defines.
>

I just explained to Alex.W with something as follows. Are you sure to
keep this set of defines in vfio.h? That way, the EEH error constants
are all defined in uapi/asm/eeh.h, but the EEH PE state constatns will
be distributed in vfio.h and uapi/asm/eeh.h at the same time. Actually,
I believe it's safe to move the PE state defines from vfio.h to
uapi/asm/eeh.h and now is the right time to do so :)

---

QEMU should be the first user to utilize the EEH capability exposed by
the host kernel, and I believe QEMU doesn't use those constants yet.
So it's right time to move those constants to uapi/asm/eeh.h. Once some
one starts to use them, it's impossible to do so.

>I also think this should be folded into 1/1.
>

The reason I didn't fold it to PATCH[1/4]: I was afraid the changs
will be taken via different trees (ppc-next and vfio-next).

Thanks,
Gavin

>-- 
>David Gibson			| I'll have my music baroque, and my code
>david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
>				| _way_ _around_!
>http://www.ozlabs.org/~dgibson
