Return-Path: <alex.williamson@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E96DD1A08E9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2015 07:28:18 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6391014009B
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2015 07:28:18 +1100 (AEDT)
Message-ID: <1426278489.3643.116.camel@redhat.com>
Subject: Re: [PATCH 2/2] drivers/vfio: Support EEH error injection
From: Alex Williamson <alex.williamson@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 13 Mar 2015 14:28:09 -0600
In-Reply-To: <20150312042129.GS11973@voom.redhat.com>
References: <1426055651-22925-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1426055651-22925-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150312005721.GP11973@voom.redhat.com> <20150312031642.GA15888@shangw>
 <20150312042129.GS11973@voom.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm@vger.kernel.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-12 at 15:21 +1100, David Gibson wrote:
> On Thu, Mar 12, 2015 at 02:16:42PM +1100, Gavin Shan wrote:
> > On Thu, Mar 12, 2015 at 11:57:21AM +1100, David Gibson wrote:
> > >On Wed, Mar 11, 2015 at 05:34:11PM +1100, Gavin Shan wrote:
> > >> The patch adds one more EEH sub-command (VFIO_EEH_PE_INJECT_ERR)
> > >> to inject the specified EEH error, which is represented by
> > >> (struct vfio_eeh_pe_err), to the indicated PE for testing purpose.
> > >> 
> > >> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > >> ---
> > >>  Documentation/vfio.txt        | 47 ++++++++++++++++++++++++++++++-------------
> > >>  drivers/vfio/vfio_spapr_eeh.c | 14 +++++++++++++
> > >>  include/uapi/linux/vfio.h     | 34 ++++++++++++++++++++++++++++++-
> > >>  3 files changed, 80 insertions(+), 15 deletions(-)
> > >> 
> > >> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> > >> index 96978ec..2e7f736 100644
> > >> --- a/Documentation/vfio.txt
> > >> +++ b/Documentation/vfio.txt
> > >> @@ -328,7 +328,13 @@ So 4 additional ioctls have been added:
> > >>  
> > >>  The code flow from the example above should be slightly changed:
> > >>  
> > >> -	struct vfio_eeh_pe_op pe_op = { .argsz = sizeof(pe_op), .flags = 0 };
> > >> +	struct vfio_eeh_pe_op *pe_op;
> > >> +	struct vfio_eeh_pe_err *pe_err;
> > >> +
> > >> +	pe_op = malloc(sizeof(*pe_op) + sizeof(*pe_err));
> > >> +	pe_err = (void *)pe_op + sizeof(*pe_op);
> > >> +	pe_op->argsz = sizeof(*pe_op) + sizeof(*pe_err);
> > >
> > >Surely that argsz can't be correct for most of the operations.  The
> > >extended structure should only be there for the error inject ioctl,
> > >yes?
> > >
> > 
> > argsz isn't appropriate for most cases because kernel has the check
> > "expected_argsz < passed_argsz", not "expected_argsz ==
> > passed_argsz".
> 
> It works for now, but if any of those calls was extended with more
> data, it would break horribly.  By setting the argsz greater than
> necessary, you're effectively passing uninitialized data to the
> ioctl().  At the moment, the ioctl() ignores it, but the whole point
> of the argsz value is that in the future, it might not.

argsz tells us how much data the user is passing, we're always going to
need to figure out what the extra data is, so I don't really see the
point of this objection.  In fact, it might make use of this interface
quite a bit easier if vfio_eeh_pe_op ended with a union including
vfio_eeh_pe_err.  op == VFIO_EEH_PE_INJECT_ERR defines that the user has
passed vfio_eeh_pe_err in the union, other ops may add new unions later.
Thanks,

Alex

> > However, I'll fix it as follows to avoid confusion after collecting
> > more comments:
> > 
> > 	struct vfio_eeh_pe_op *pe_op;
> > 	struct vfio_eeh_pe_err *pe_err;
> > 
> > 	/* For all cases except error injection */
> > 	pe_op = malloc(sizeof(*pe_op));
> > 	pe_op->argsz = sizeof(*pe_op);
> > 
> > 	/* For error injection case here */
> > 	pe_op = realloc(sizeof(*pe_op) + sizeof(*pe_err));
> > 	pe_op->argsz = sizeof(*pe_op) + sizeof(*pe_err);
> > 	pe_err = (void *)pe_op + sizeof(*pe_op);
> > 
> > Thanks,
> > Gavin
> > 
> > 
> > 
> 
