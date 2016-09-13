Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYLBp0dGczDrfR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 20:14:42 +1000 (AEST)
Subject: Re: [Openipmi-developer] [PATCH 3/4] ipmi: allow dynamic BMC version
 information
To: minyard@acm.org, openipmi-developer@lists.sourceforge.net
References: <1473670537-26428-1-git-send-email-jk@ozlabs.org>
 <1473670537-26428-4-git-send-email-jk@ozlabs.org>
 <7732b504-a9f1-b8f6-fb7a-ead34719d862@acm.org>
From: Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org
Message-ID: <9165a84f-412a-cf60-72a0-8da6b9a5a984@ozlabs.org>
Date: Tue, 13 Sep 2016 18:14:41 +0800
MIME-Version: 1.0
In-Reply-To: <7732b504-a9f1-b8f6-fb7a-ead34719d862@acm.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Corey,

> In all, this looks good.  I have two minor nits inline below, and
> two more major comments here:
> 
> I would prefer if it always queried the data, even if the device id
> information is provided by the lower level driver.

OK, can do. I was concerned that the SMI driver may want to provide its
own device identification details (and not want to override those with
the ones provided by Get Device Id), but if that's not the case then it
makes sense to store the original values but allow requery.

> Since the values can change while you are querying them, do
> we need some sort of mutex on them?

Which values are you referring to here? The device ID, or the members of
struct bmc_device?

If it's the latter, I'd be happy to take your guidance on the locking
protocol there. Is there an existing mutex that would be suitable for
that?

>From the comments inline:

> > +    /* Do we have enough data to parse the device ID details? This doesn't
> > +     * inclde the optional auxilliary version data. */
> 
> Minor nit: include is misspelled. 

D'oh, will fix in v2.

> > @@ -2450,6 +2590,8 @@ static int ipmi_bmc_register(ipmi_smi_t intf, int ifnum)
> >   
> >   	mutex_lock(&ipmidriver_mutex);
> >   
> > +	bmc_update_device_id(bmc);
> > +
> 
> What happens if this fails?  You can return an error from this function.
> It's also probably not necessary to have this inside the mutex.

I didn't think we'd want to fail registration on query failure there; it
could be a transient error.

Cheers,


Jeremy
