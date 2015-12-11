Return-Path: <wen.pu@powercore.com.cn>
Received: from smtpbg202.qq.com (smtpbg202.qq.com [184.105.206.29])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C69051A0657
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 13:43:39 +1100 (AEDT)
From: Wen Pu <wen.pu@powercore.com.cn>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: pr_warn_once on unsupported OPAL_MSG type
Date: Fri, 11 Dec 2015 10:43:17 +0800
Message-ID: <1564474.AyfhtnPqY7@pw-vbox>
In-Reply-To: <1449800465.21866.6.camel@ellerman.id.au>
References: <1449796103-7700-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1449800465.21866.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, December 11, 2015 01:21:05 PM Michael Ellerman wrote:
> On Fri, 2015-12-11 at 12:08 +1100, Stewart Smith wrote:
> > When running on newer OPAL firmware that supports sending extra
> > OPAL_MSG types, we would print a warning on *every* message received.
> > 
> > This could be a problem for kernels that don't support OPAL_MSG_OCC
> > on machines that are running real close to thermal limits and the
> > OCC is throttling the chip. For a kernel that is paying attention to
> > the message queue, we could get these notifications quite often.
> > 
> > Conceivably, future message types could also come fairly often,
> > and printing that we didn't understand them 10,000 times provides
> > no further information than printing them once.
> > 
> > diff --git a/arch/powerpc/platforms/powernv/opal.c
> > b/arch/powerpc/platforms/powernv/opal.c index 4296d55e88f3..57cffb80bc36
> > 100644
> > --- a/arch/powerpc/platforms/powernv/opal.c
> > +++ b/arch/powerpc/platforms/powernv/opal.c
> > @@ -278,7 +278,7 @@ static void opal_handle_message(void)
> > 
> >  	/* Sanity check */
> >  	if (type >= OPAL_MSG_TYPE_MAX) {
> > 
> > -		pr_warning("%s: Unknown message type: %u\n", __func__, type);
> > +		pr_warn_once("%s: Unknown message type: %u\n", __func__, type);
> > 
> >  		return;
> 
> This will only print once, even if there are multiple unknown message types,
> are we happy with that?
> 
> cheers

Yes, I also think it's much better that printing once than printing a warning 
on *every* message received. 

Thanks!
