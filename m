Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 624F31A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 09:50:42 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2BE63140082
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2015 09:50:42 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 16 Mar 2015 08:50:40 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 400D22BB0047
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2015 09:50:37 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2FMoTsQ53215486
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2015 09:50:37 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2FMo3o5016000
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2015 09:50:03 +1100
Date: Mon, 16 Mar 2015 09:49:39 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/2] drivers/vfio: Support EEH error injection
Message-ID: <20150315224939.GA4644@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1426055651-22925-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1426055651-22925-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150312005721.GP11973@voom.redhat.com>
 <20150312031642.GA15888@shangw>
 <20150312042129.GS11973@voom.redhat.com>
 <1426278489.3643.116.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426278489.3643.116.camel@redhat.com>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, agraf@suse.de,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 13, 2015 at 02:28:09PM -0600, Alex Williamson wrote:
>On Thu, 2015-03-12 at 15:21 +1100, David Gibson wrote:
>> On Thu, Mar 12, 2015 at 02:16:42PM +1100, Gavin Shan wrote:
>> > On Thu, Mar 12, 2015 at 11:57:21AM +1100, David Gibson wrote:
>> > >On Wed, Mar 11, 2015 at 05:34:11PM +1100, Gavin Shan wrote:
>> > >> The patch adds one more EEH sub-command (VFIO_EEH_PE_INJECT_ERR)
>> > >> to inject the specified EEH error, which is represented by
>> > >> (struct vfio_eeh_pe_err), to the indicated PE for testing purpose.
>> > >> 
>> > >> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> > >> ---
>> > >>  Documentation/vfio.txt        | 47 ++++++++++++++++++++++++++++++-------------
>> > >>  drivers/vfio/vfio_spapr_eeh.c | 14 +++++++++++++
>> > >>  include/uapi/linux/vfio.h     | 34 ++++++++++++++++++++++++++++++-
>> > >>  3 files changed, 80 insertions(+), 15 deletions(-)
>> > >> 
>> > >> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
>> > >> index 96978ec..2e7f736 100644
>> > >> --- a/Documentation/vfio.txt
>> > >> +++ b/Documentation/vfio.txt
>> > >> @@ -328,7 +328,13 @@ So 4 additional ioctls have been added:
>> > >>  
>> > >>  The code flow from the example above should be slightly changed:
>> > >>  
>> > >> -	struct vfio_eeh_pe_op pe_op = { .argsz = sizeof(pe_op), .flags = 0 };
>> > >> +	struct vfio_eeh_pe_op *pe_op;
>> > >> +	struct vfio_eeh_pe_err *pe_err;
>> > >> +
>> > >> +	pe_op = malloc(sizeof(*pe_op) + sizeof(*pe_err));
>> > >> +	pe_err = (void *)pe_op + sizeof(*pe_op);
>> > >> +	pe_op->argsz = sizeof(*pe_op) + sizeof(*pe_err);
>> > >
>> > >Surely that argsz can't be correct for most of the operations.  The
>> > >extended structure should only be there for the error inject ioctl,
>> > >yes?
>> > >
>> > 
>> > argsz isn't appropriate for most cases because kernel has the check
>> > "expected_argsz < passed_argsz", not "expected_argsz ==
>> > passed_argsz".
>> 
>> It works for now, but if any of those calls was extended with more
>> data, it would break horribly.  By setting the argsz greater than
>> necessary, you're effectively passing uninitialized data to the
>> ioctl().  At the moment, the ioctl() ignores it, but the whole point
>> of the argsz value is that in the future, it might not.
>
>argsz tells us how much data the user is passing, we're always going to
>need to figure out what the extra data is, so I don't really see the
>point of this objection.  In fact, it might make use of this interface
>quite a bit easier if vfio_eeh_pe_op ended with a union including
>vfio_eeh_pe_err.  op == VFIO_EEH_PE_INJECT_ERR defines that the user has
>passed vfio_eeh_pe_err in the union, other ops may add new unions later.
>Thanks,
>

Ok. I'll have following data struct in next revision:

struct vfio_eeh_pe_err {
	__u32 type;
	__u32 func;
	__u64 addr;
	__u64 mask;
};

struct vfio_eeh_pe_op {
	__u32 argsz;
        __u32 flags;
        __u32 op;
	union {
		struct vfio_eeh_pe_err err;
	};
};

Thanks,
Gavin

>Alex
>
>> > However, I'll fix it as follows to avoid confusion after collecting
>> > more comments:
>> > 
>> > 	struct vfio_eeh_pe_op *pe_op;
>> > 	struct vfio_eeh_pe_err *pe_err;
>> > 
>> > 	/* For all cases except error injection */
>> > 	pe_op = malloc(sizeof(*pe_op));
>> > 	pe_op->argsz = sizeof(*pe_op);
>> > 
>> > 	/* For error injection case here */
>> > 	pe_op = realloc(sizeof(*pe_op) + sizeof(*pe_err));
>> > 	pe_op->argsz = sizeof(*pe_op) + sizeof(*pe_err);
>> > 	pe_err = (void *)pe_op + sizeof(*pe_op);
>> > 
>> > Thanks,
>> > Gavin
>> > 
>> > 
>> > 
>> 
>
>
>
