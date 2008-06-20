Return-Path: <matvejchikov@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id E2D51DDED7
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 18:55:24 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so793991wag.13
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 01:55:22 -0700 (PDT)
Message-ID: <8496f91a0806200155hcb1f440ld7b5f678d95fdb85@mail.gmail.com>
Date: Fri, 20 Jun 2008 12:55:22 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: "Laurent Pinchart" <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] fs_enet: restore promiscuous and multicast settings in
	restart()
In-Reply-To: <200806201025.28768.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806181707.17739.laurentp@cse-semaphore.com>
	<20080619230128.def96ee0.billfink@mindspring.com>
	<200806201025.28768.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, Bill Fink <billfink@mindspring.com>,
	vbordug@ru.mvista.com, netdev@vger.kernel.org
Reply-To: matvejchikov@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> > diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
>> > index ce40cf9..1a95cf1 100644
>> > --- a/drivers/net/fs_enet/mac-fcc.c
>> > +++ b/drivers/net/fs_enet/mac-fcc.c
>> > @@ -464,6 +464,9 @@ static void restart(struct net_device *dev)
>> >             C32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
>> >
>> >     S32(fccp, fcc_gfmr, FCC_GFMR_ENR | FCC_GFMR_ENT);
>> > +
>> > +   /* Restore multicast and promiscous settings */
>> > +   set_multicast_list(dev);
>> >  }

Is it right to call set_multicast_list() after turning on transmitter
and receiver? May be swap this lines around?
