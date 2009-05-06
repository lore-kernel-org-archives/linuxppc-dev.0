Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9AE11DDFB7
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:12:53 +1000 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 03/12] fs_enet: Add FEC TX Alignment workaround for
	MPC5121.
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa40905061337w6aa82f5aj787618ba108e528f@mail.gmail.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-4-git-send-email-wd@denx.de>
	<fa686aa40905061337w6aa82f5aj787618ba108e528f@mail.gmail.com>
Date: Thu, 07 May 2009 00:12:50 +0200
Message-Id: <20090506221250.C977183420E8@gemini.denx.de>
Cc: Piotr Ziecik <kosmo@semihalf.com>, Detlev Zundel <dzu@denx.de>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Grant Likely,

In message <fa686aa40905061337w6aa82f5aj787618ba108e528f@mail.gmail.com> you wrote:
>
> > The FEC on 5121 has problems with misaligned tx buffers.
> > The RM says any alignment is ok but empirical results
> > show that packet buffers ending in 0x1E will sometimes
> > hang the FEC. Other bad alignment does not hang but will
> > cause silent TX failures resulting in about a 1% packet
> > loss as tested by ping -f from a remote host.
> >
> > This patch is a work around that copies every tx packet
> > to an aligned skb before sending.
>
> OUCH!

Yes :-(

> > +#else
> > +#define tx_skb_align_workaround(dev, skb) (skb)
> > +#endif
>
> Another use of #ifdef blocks.  What is the multiplatform impact?

Hm... Can you recommend a better way to solve the problem? Suggestions
are welcome.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You don't have to worry about me. I might have been born yesterday...
but I stayed up all night.
