Return-Path: <benh@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A13682C029D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 19:38:46 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 27 May 2013 19:29:49 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B2F022BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 19:38:33 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4R9OJPQ14221468
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 19:24:19 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4R9cWZE005931
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 19:38:33 +1000
Message-ID: <1369647511.3557.27.camel@pasglop>
Subject: Re: [PATCH 1/2] ARM: kirkwood: proper retain MAC address workaround
 on DT ethernet
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Mon, 27 May 2013 19:38:31 +1000
In-Reply-To: <51A26B62.4050009@gmail.com>
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130525.210441.818472895703230779.davem@davemloft.net>
 <51A26B62.4050009@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: andrew@lunn.ch, jason@lakedaemon.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, buytenh@wantstofly.org,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-05-26 at 22:06 +0200, Sebastian Hesselbarth wrote:

> good you mention it. I added Grant on Cc and will give a short
> sum-up why I casted the const from property->value away here.
> 
> Maybe I overlooked the API for modifying the DT property but as
> far as I've seen - there is no API for modifying it. And yes,
> you are right, it is kind of an abuse of DT here.

of_update_property(). That also makes sure that any notifiers
is called and proc/device-tree is updated in the case where the property
is new.

> As Kirkwoods loose their MAC address on clock gating, I was looking
> for a place to store it early. (a) DT property "local-mac-address"
> looked as a good place as it will allow the driver to find it without
> any extra code. Of course, I am doing severaly sanity checks if it is
> safe to overwrite it, i.e. no other MAC set, property is there, long
> enough.
> 
> If Grant also NACKs modifying the DT we basically have two more options
> left for Kirkwood: (b) have MAC stored early in two global arrays in
> board init and reference that from mv643xx_eth or (c) leave the clock
> ungated unconditionally on all Kirkwoods.
> 
> I can live with all three, just name it and I prepare a final patch set.

No, putting it in the DT makes sense, just use the right accessor.

Cheers,
Ben.

> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
