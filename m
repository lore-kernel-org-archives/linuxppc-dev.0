Return-Path: <cyrilbur@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtWjJ5PXXzDr1M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 16:23:00 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id h134so2944450iof.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 23:23:00 -0700 (PDT)
Message-ID: <1498112571.1181.9.camel@gmail.com>
Subject: Re: [PATCH V4 2/2] powerpc/powernv : Add support for OPAL-OCC
 command/response interface
From: Cyril Bur <cyrilbur@gmail.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
 paulus@samba.org,  mpe@ellerman.id.au, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com
Date: Thu, 22 Jun 2017 16:22:51 +1000
In-Reply-To: <6548f1df-9d0e-a5db-677b-48d3d418b1d6@linux.vnet.ibm.com>
References: <1498032387-26010-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1498032387-26010-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1498093120.1181.5.camel@gmail.com>
 <6548f1df-9d0e-a5db-677b-48d3d418b1d6@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-22 at 09:57 +0530, Shilpasri G Bhat wrote:
> Hi Cyril,
> 
> On 06/22/2017 06:28 AM, Cyril Bur wrote:
> > On Wed, 2017-06-21 at 13:36 +0530, Shilpasri G Bhat wrote:
> > > In P9, OCC (On-Chip-Controller) supports shared memory based
> > > commad-response interface. Within the shared memory there is an OPAL
> > > command buffer and OCC response buffer that can be used to send
> > > inband commands to OCC. This patch adds a platform driver to support
> > > the command/response interface between OCC and the host.
> > > 
> > 
> > Sorry I probably should have pointed out earlier that I don't really
> > understand the first patch or exactly what problem you're trying to
> > solve. I've left it ignored, feel free to explain what the idea is
> > there or hopefully someone who can see what you're trying to do can
> > step in.
> 
> Thanks for reviewing this patch.
> 
> For the first patch however, OCC expects a different request_id in the command
> interface every time OPAL is requesting a new command .
> 'opal_async_get_token_interruptible()' returns a free token from the
> 'opal_async_complete_map' which does not work for the above OCC requirement as
> we may end up getting the same token. Thus the first patch tries to get a new
> token excluding a token that was used for the last command.
> 

Oh yes I see because you're using the OPAL token to the opal call as
the OCC msg request_id. Is there any requirement that these two numbers
match?

Is the 'different' a per OCC or a global 'all OCC' requirement?

Couldn't you just have a counter in your occ struct in this patch that
you increment on each call?

I've looked through your skiboot patch and it looks like you use the
msg->request_id so that you know who to respond to - wouldn't be easier
to just pass the opal token through as an extra parameter to
OPAL_OCC_COMMAND and store it alongside the msg structure?

Apologies I shouldn't have overlooked this for so long.

> 
> > 
> > As for this patch, just one thing.
> > 
> > 
> > > Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> > > ---
> > > - Hold occ->cmd_in_progress in read()
> > > - Reset occ->rsp_consumed if copy_to_user() fails
> > > 
> > >  arch/powerpc/include/asm/opal-api.h            |  41 +++-
> > >  arch/powerpc/include/asm/opal.h                |   3 +
> > >  arch/powerpc/platforms/powernv/Makefile        |   2 +-
> > >  arch/powerpc/platforms/powernv/opal-occ.c      | 313 +++++++++++++++++++++++++
> > >  arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
> > >  arch/powerpc/platforms/powernv/opal.c          |   8 +
> > >  6 files changed, 366 insertions(+), 2 deletions(-)
> > >  create mode 100644 arch/powerpc/platforms/powernv/opal-occ.c
> > > 
> > 
> > [snip]
> > 
> > > +
> > > +static ssize_t opal_occ_read(struct file *file, char __user *buf,
> > > +			     size_t count, loff_t *ppos)
> > > +{
> > > +	struct miscdevice *dev = file->private_data;
> > > +	struct occ *occ = container_of(dev, struct occ, dev);
> > > +	int rc;
> > > +
> > > +	if (count < sizeof(*occ->rsp) + occ->rsp->size)
> > > +		return -EINVAL;
> > > +
> > > +	if (!atomic_cmpxchg(&occ->rsp_consumed, 1, 0))
> > > +		return -EBUSY;
> > > +
> > > +	if (atomic_cmpxchg(&occ->cmd_in_progress, 0, 1))
> > > +		return -EBUSY;
> > > +
> > 
> > Personally I would have done these two checks the other way around, it
> > doesn't really matter which one you do first but what does matter is
> > that you undo the change you did in the first cmpxchg if the second
> > cmpxchg causes you do return.
> > 
> > In this case if cmd_in_progress then you'll have marked the response as
> > consumed...
> 
> Here, if cmd_in_progress is set by some other thread doing a write() then it
> will set the 'rsp_consumed' to valid on successful command completion. If
> write() fails then we are doing a good thing here by not setting 'rsp_consumed'
> so the user will not be able to read previous command's response.
> 

Yep, if you're happy I'm happy, I suppose there is a scenario where you
might lose a response.

read() and sees that there is a response, and marks it as consumed,
meanwhile a write grabs cmd_in_progress which causes the read()er to
return EBUSY but something fails before the write()er can actually send
an occ command so there is a lost command there... I mean, either way
we lose that command since if the write() had successfully sent the
command we would have overwritten the previous response... if you're
happy with this I'm happy with this. It is incredibly unlikey to happen
and this should be the same program doing this, I'm happy to have them
be able to shoot themselves in the foot like that.

> Thanks and Regards,
> Shilpa
> 
> > 
> > > +	rc = copy_to_user((void __user *)buf, occ->rsp,
> > > +			  sizeof(occ->rsp) + occ->rsp->size);
> > > +	if (rc) {
> > > +		atomic_set(&occ->rsp_consumed, 1);
> > > +		atomic_set(&occ->cmd_in_progress, 0);
> > > +		pr_err("Failed to copy OCC response data to user\n");
> > > +		return rc;
> > > +	}
> > > +
> > > +	atomic_set(&occ->cmd_in_progress, 0);
> > > +	return sizeof(*occ->rsp) + occ->rsp->size;
> > > +}
> > > +
> > 
> > [snip]
> > 
> 
> 
