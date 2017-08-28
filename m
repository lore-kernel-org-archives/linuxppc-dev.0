Return-Path: <srs0=h+48=76=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgfXF6gf4zDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:52:45 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xgfXF615gz8t8c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:52:45 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xgfXF33mDz9ryv
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2017 14:52:45 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7S4nuCJ119471
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2017 00:52:43 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cm1x1kqqu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2017 00:52:43 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sun, 27 Aug 2017 22:52:42 -0600
Date: Sun, 27 Aug 2017 21:52:38 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 06/12] powerpc/vas: Define helpers to alloc/free windows
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1503556688-15412-7-git-send-email-sukadev@linux.vnet.ibm.com>
 <878ti8uh0r.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <878ti8uh0r.fsf@concordia.ellerman.id.au>
Message-Id: <20170828045238.GD12907@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [mpe@ellerman.id.au] wrote:
> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> > diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c

> > +	rc = ida_pre_get(ida, GFP_KERNEL);
> > +	if (!rc)
> > +		return -EAGAIN;
> > +
> > +	spin_lock(&vas_ida_lock);
> > +	rc = ida_get_new_above(ida, 0, &winid);
> 
> If you're passing 0 you can just use ida_get_new().

Ok.

> 
> Or did you actually want to exclude 0? In which case you should pass 1.
> 
> > +	spin_unlock(&vas_ida_lock);
> > +
> > +	if (rc)
> > +		return rc;
> 
> You're supposed to handle EAGAIN I thought.

Yes, I will retry the pre_get()
> 
> > +
> > +	if (winid > VAS_WINDOWS_PER_CHIP) {
> > +		pr_err("VAS: Too many (%d) open windows\n", winid);
> > +		vas_release_window_id(ida, winid);
> > +		return -EAGAIN;
> > +	}
> > +
> > +	return winid;
> > +}
> > +
> > +void vas_window_free(struct vas_window *window)
> 
> static.

Ok

> 
> > +{
> > +	int winid = window->winid;
> > +	struct vas_instance *vinst = window->vinst;
> > +
> > +	unmap_winctx_mmio_bars(window);
> > +	kfree(window);
> > +
> > +	vas_release_window_id(&vinst->ida, winid);
> > +}
> > +
> > +struct vas_window *vas_window_alloc(struct vas_instance *vinst)
> > +{
> > +	int winid;
> > +	struct vas_window *window;
> > +
> > +	winid = vas_assign_window_id(&vinst->ida);
> > +	if (winid < 0)
> > +		return ERR_PTR(winid);
> > +
> > +	window = kzalloc(sizeof(*window), GFP_KERNEL);
> > +	if (!window)
> > +		return ERR_PTR(-ENOMEM);
> 
> You leak an id here.

Argh. Yes.

> 
> The error handling would be easier in here if the caller did the alloc,
> or if you split alloc and init, and alloc just did the kzalloc().

I was trying to simplify error handling in the callers where they have
to only deal with one failure now.
> 
> One of the callers even prints "unable to allocate memory" if this
> function fails, but that's not accurate, there's several failure modes.

Yes, will fix that message and the leaks.

Thanks,

Suka
