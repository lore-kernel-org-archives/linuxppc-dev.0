Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5QKv3bCLzDq6Q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 09:58:59 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id u62so10618325pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Jul 2017 16:58:59 -0700 (PDT)
Message-ID: <1499644730.6344.3.camel@gmail.com>
Subject: Re: [PATCH 5/5] mtd: powernv_flash: Use
 opal_async_wait_response_interruptible()
From: Cyril Bur <cyrilbur@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Cc: stewart@linux.vnet.ibm.com, dwmw2@infradead.org
Date: Mon, 10 Jul 2017 09:58:50 +1000
In-Reply-To: <1499543997.29707.6.camel@kernel.crashing.org>
References: <20170629065413.19845-1-cyrilbur@gmail.com>
 <20170629065413.19845-6-cyrilbur@gmail.com>
 <1499543997.29707.6.camel@kernel.crashing.org>
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

On Sat, 2017-07-08 at 14:59 -0500, Benjamin Herrenschmidt wrote:
> On Thu, 2017-06-29 at 16:54 +1000, Cyril Bur wrote:
> > The OPAL calls performed in this driver shouldn't be using
> > opal_async_wait_response() as this performs a wait_event() which, on
> > long running OPAL calls could result in hung task warnings. wait_event()
> > also prevents timely signal delivery which is also undesirable.
> > 
> > This patch also attempts to quieten down the use of dev_err() when
> > errors haven't actually occurred and also to return better information up
> > the stack rather than always -EIO.
> 
> So what happens when you get a signal then ? The async op is still in
> progress, will the callers properly handle that ?
> 
> For example, for a read, OPAL will potentially still be writing to
> the destination buffer. Are the callers expecting this ?
> 
> That sounds very broken to me ....
> 

Correct - I have a v2 that I let stew in my head over the weekend
before sending. I think its good.

Thanks,

Cyril

> You should simply limit the amount of flash that can be affected by
> a single call to avoid long hung tasks.
> 
> > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > ---
> >  drivers/mtd/devices/powernv_flash.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
> > index 7b41af06f4fe..a7c5ae2b2898 100644
> > --- a/drivers/mtd/devices/powernv_flash.c
> > +++ b/drivers/mtd/devices/powernv_flash.c
> > @@ -88,19 +88,23 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
> >  	}
> >  
> >  	if (rc != OPAL_ASYNC_COMPLETION) {
> > -		dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
> > -				op, rc);
> > +		if (rc != OPAL_BUSY)
> > +			dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
> > +					op, rc);
> >  		opal_async_release_token(token);
> > -		rc = -EIO;
> > +		rc = opal_error_code(rc);
> >  		goto out;
> >  	}
> >  
> > -	rc = opal_async_wait_response(token, &msg);
> > +	rc = opal_async_wait_response_interruptible(token, &msg);
> >  	opal_async_release_token(token);
> >  	mutex_unlock(&info->lock);
> >  	if (rc) {
> > -		dev_err(dev, "opal async wait failed (rc %d)\n", rc);
> > -		return -EIO;
> > +		if (rc == -ERESTARTSYS)
> > +			rc = -EINTR;
> > +		else
> > +			dev_err(dev, "opal async wait failed (rc %d)\n", rc);
> > +		return rc;
> >  	}
> >  
> >  	rc = opal_get_async_rc(msg);
> > @@ -109,7 +113,7 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
> >  		if (retlen)
> >  			*retlen = len;
> >  	} else {
> > -		rc = -EIO;
> > +		rc = opal_error_code(rc);
> >  	}
> >  
> >  	return rc;
