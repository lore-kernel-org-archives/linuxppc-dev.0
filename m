Return-Path: <dmitry.torokhov@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 6800BDDDFB
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 01:54:38 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so2659227pyi
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 07:54:37 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] fix appletouch geyser 1 breakage
Date: Sun, 28 Oct 2007 10:54:31 -0400
References: <1193222676.4510.5.camel@johannes.berg>
	<200710280100.13304.dtor@insightbb.com>
	<1193567513.3966.9.camel@johannes.berg>
In-Reply-To: <1193567513.3966.9.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710281054.31303.dmitry.torokhov@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	Dmitry Torokhov <dtor@insightbb.com>, Anton Ekblad <valderman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 28 October 2007, Johannes Berg wrote:
> 
> > OK, then maybe instead of reverting the change outright we could try the
> > patch below?
> 
> That patch works,

Any chance Benjamin could also test it? The behaviour is different
from 2.6.24-rc1 since we call atp_geyser_init for all geysers now.
 
> minor comments: 
> 
> > Older models of fountains do not support change mode request and
> 
> I think there's only one fountain model.

I was hoping that FOUNTAIN_TP_ONLY_PRODUCT_ID (0x30A) behaves similar
to Geyser in this regard. If you know that this assumption is incorrect
then we need to rename atp_is_older_fountain() to atp_is_fountain()
anf add this product ID to it.

> 
> > therefore shoudl be excluded from idle reset attempts.
> 
> typo

OK

> 
> >  /* MacBook Pro (Geyser 3 & 4) initialization constants */
> 
> That comment is no longer correct, you should change it.
> 

OK

> > -#define ATP_GEYSER3_MODE_READ_REQUEST_ID 1
> 
> > + * Reinitialise the device. This usually stops stream of empty packets
> > + * coming form it.
> 
> typo "from"
> 

Yep, thanks.

-- 
Dmitry
