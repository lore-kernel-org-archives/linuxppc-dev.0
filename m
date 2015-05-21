Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 119331A0AD5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 18:59:22 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 497DD140781
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 18:59:21 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 21 May 2015 18:59:20 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C28563578048
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 18:59:16 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4L8x8fS12714192
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 18:59:16 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4L8whVA029430
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 18:58:44 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: mpe <mpe@ellerman.id.au>, benh <benh@kernel.crashing.org>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 brking <brking@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 19/19] cxl: Add AFU virtual PHB and kernel API
In-reply-to: <1432034556-32400-20-git-send-email-mikey@neuling.org>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
 <1432034556-32400-20-git-send-email-mikey@neuling.org>
Date: Thu, 21 May 2015 18:58:18 +1000
Message-Id: <1432193794-sup-4147@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mikey,

> +/* wrappers around afu_* file ops which are EXPORTED */

This is fine, though alternatively you could export the original
functions directly from file.c (feel free to rename them to your
versions if you do change it) - I don't really mind either way :)

> +static void cxl_pci_reset_secondary_bus(struct pci_dev *dev)
> +{
> +    /* Should we do an AFU reset here ? */

I'm still not sure what the best answer should be to this question... At
the moment it's working fine without an afu reset here, so we can delay
adding it until (and if) it becomes clear we need it?

Could this be called while the afu is in use (need to be careful), or
should it only ever be called when the afu is inactive (afu reset should
be safe)?

> +/*
> + * Context lifetime overview:
> + *
> + * An AFU context may be inited and then started and stoppped multiple times
> + * before it's released. ie.
> + *    - cxl_dev_context_init()
> + *      - cxl_start_context()
> + *      - cxl_stop_context()
> + *      - cxl_start_context()
> + *      - cxl_stop_context()
> + *     ...repeat...
> + *    - cxl_release_context()
> + * Once released, a context can't be started again.

Ok, we'll need to be a little careful here as this differs from the
userspace api (which cannot reuse a context and relies on the file
descriptor release() to stop the context).

Let's see...

> +int cxl_start_context(struct cxl_context *ctx, u64 wed,
> +		      struct task_struct *task)
> +{
> +	int rc = 0;
> +	bool kernel = true;
> +
> +	pr_devel("%s: pe: %i\n", __func__, ctx->pe);
> +
> +	mutex_lock(&ctx->status_mutex);
> +	if (ctx->status == STARTED)
> +		goto out; /* already started */
> +	if (task) {
> +		ctx->pid = get_task_pid(task, PIDTYPE_PID);
> +		get_pid(ctx->pid);

OK, this pid is put in the release call (in reclaim_ctx, which is an rcu
callback from cxl_context_free), which means if we reuse a context we
will prevent the pid from ever being reused, reducing the total number
of runnable processes by one.

> +		kernel = false;
> +	}
> +
> +	cxl_ctx_get();

Likewise this is mirrored in the release call instead of the stop call,
so if we reuse a context we will then permanently mark cxl as being in
use, which will then permanently enable the slbia hook.

> +	if ((rc = cxl_attach_process(ctx, kernel, wed , 0))) {
> +		put_pid(ctx->pid);
> +		cxl_ctx_put();
> +		goto out;
> +	}
> +
> +	ctx->status = STARTED;
> +	get_device(&ctx->afu->dev);
> +out:
> +	mutex_unlock(&ctx->status_mutex);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(cxl_start_context);

> +/* Stop a context.  Returns 0 on success, otherwise -Errno */
> +int cxl_stop_context(struct cxl_context *ctx)
> +{
> +	int rc;
> +
> +	rc = __detach_context(ctx);
> +	if (!rc)
> +		put_device(&ctx->afu->dev);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(cxl_stop_context);

> +int cxl_release_context(struct cxl_context *ctx)
> +{
> +	if (ctx->status != CLOSED)
> +		return -EBUSY;
> +
> +	cxl_context_free(ctx);
> +
> +	cxl_ctx_put();
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_release_context);

Otherwise it looks good :)

Cheers,
-Ian
