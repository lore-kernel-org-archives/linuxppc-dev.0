Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E99281A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2015 14:12:56 +1000 (AEST)
Message-ID: <1432527176.29580.4.camel@neuling.org>
Subject: Re: [PATCH 19/19] cxl: Add AFU virtual PHB and kernel API
From: Michael Neuling <mikey@neuling.org>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: mpe <mpe@ellerman.id.au>, benh <benh@kernel.crashing.org>, "Matthew R.
 Ochs" <mrochs@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking
 <brking@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
Date: Mon, 25 May 2015 14:12:56 +1000
In-Reply-To: <1432193794-sup-4147@delenn.ozlabs.ibm.com>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
 <1432034556-32400-20-git-send-email-mikey@neuling.org>
 <1432193794-sup-4147@delenn.ozlabs.ibm.com>
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

On Thu, 2015-05-21 at 18:58 +1000, Ian Munsie wrote:
> Hi Mikey,
>=20
> > +/* wrappers around afu_* file ops which are EXPORTED */
>=20
> This is fine, though alternatively you could export the original
> functions directly from file.c (feel free to rename them to your
> versions if you do change it) - I don't really mind either way :)

I'll probably just keep it so all the API functions are in one spot.

> > +static void cxl_pci_reset_secondary_bus(struct pci_dev *dev)
> > +{
> > +    /* Should we do an AFU reset here ? */
>=20
> I'm still not sure what the best answer should be to this question... At
> the moment it's working fine without an afu reset here, so we can delay
> adding it until (and if) it becomes clear we need it?

Yeah I think I'll leave it out

> Could this be called while the afu is in use (need to be careful), or
> should it only ever be called when the afu is inactive (afu reset should
> be safe)?

Yeah, I assume we'd need to give some EEH events to the attached driver
so they could handle the AFU losing all that state/contexts.

> > +/*
> > + * Context lifetime overview:
> > + *
> > + * An AFU context may be inited and then started and stoppped multiple=
 times
> > + * before it's released. ie.
> > + *    - cxl_dev_context_init()
> > + *      - cxl_start_context()
> > + *      - cxl_stop_context()
> > + *      - cxl_start_context()
> > + *      - cxl_stop_context()
> > + *     ...repeat...
> > + *    - cxl_release_context()
> > + * Once released, a context can't be started again.
>=20
> Ok, we'll need to be a little careful here as this differs from the
> userspace api (which cannot reuse a context and relies on the file
> descriptor release() to stop the context).
>=20
> Let's see...

Yep. =20

>=20
> > +int cxl_start_context(struct cxl_context *ctx, u64 wed,
> > +		      struct task_struct *task)
> > +{
> > +	int rc =3D 0;
> > +	bool kernel =3D true;
> > +
> > +	pr_devel("%s: pe: %i\n", __func__, ctx->pe);
> > +
> > +	mutex_lock(&ctx->status_mutex);
> > +	if (ctx->status =3D=3D STARTED)
> > +		goto out; /* already started */
> > +	if (task) {
> > +		ctx->pid =3D get_task_pid(task, PIDTYPE_PID);
> > +		get_pid(ctx->pid);
>=20
> OK, this pid is put in the release call (in reclaim_ctx, which is an rcu
> callback from cxl_context_free), which means if we reuse a context we
> will prevent the pid from ever being reused, reducing the total number
> of runnable processes by one.

As discussed offline, I've moved this around.

> > +		kernel =3D false;
> > +	}
> > +
> > +	cxl_ctx_get();
>=20
> Likewise this is mirrored in the release call instead of the stop call,
> so if we reuse a context we will then permanently mark cxl as being in
> use, which will then permanently enable the slbia hook.

Ditto.

>=20
> > +	if ((rc =3D cxl_attach_process(ctx, kernel, wed , 0))) {
> > +		put_pid(ctx->pid);
> > +		cxl_ctx_put();
> > +		goto out;
> > +	}
> > +
> > +	ctx->status =3D STARTED;
> > +	get_device(&ctx->afu->dev);
> > +out:
> > +	mutex_unlock(&ctx->status_mutex);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_start_context);
>=20
> > +/* Stop a context.  Returns 0 on success, otherwise -Errno */
> > +int cxl_stop_context(struct cxl_context *ctx)
> > +{
> > +	int rc;
> > +
> > +	rc =3D __detach_context(ctx);
> > +	if (!rc)
> > +		put_device(&ctx->afu->dev);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_stop_context);
>=20
> > +int cxl_release_context(struct cxl_context *ctx)
> > +{
> > +	if (ctx->status !=3D CLOSED)
> > +		return -EBUSY;
> > +
> > +	cxl_context_free(ctx);
> > +
> > +	cxl_ctx_put();
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_release_context);
>=20
> Otherwise it looks good :)

Thanks,

Mikey

>=20
> Cheers,
> -Ian
>=20
