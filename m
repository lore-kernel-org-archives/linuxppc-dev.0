Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CCAB6B7B80
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 15:55:55 +1100 (EST)
Subject: Re: [PATCH] of/platform: Implement support for dev_pm_ops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20091012224410.GA18923@oksana.dev.rtsoft.ru>
References: <20091012155041.GA1071@oksana.dev.rtsoft.ru>
	<fa686aa40910121509n1b7dba87nbe9ddf34f0b4d7c@mail.gmail.com>
	<20091012224410.GA18923@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Oct 2009 15:55:40 +1100
Message-Id: <1255496140.2347.36.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-13 at 02:44 +0400, Anton Vorontsov wrote:

> I agree that there is some room for improvements in general (e.g.
> merging platform and of_platform devices/drivers), but it's not as
> easy as you would like to think. Let's make it in a separate step
> that don't stop real features from being implemented (e.g.
> hibernate).
> 
> For the six functions that we can reuse I can prepare a cleanup
> patch that we can merge via -mm, or it can just sit and collect
> needed acks and can be merged via any tree. But please, no
> cross-tree dependencies for the cruicial features.

I agree. I'll take the patch for now.

In the long run, I'm all for killing of_platform if we can find
a "proper" way to replace it with platform.

IE. With dev_archdata, any device carries the of device node, so
of_platform doesn't really buy us much anymore.

We could even "default" by populating platform device resources
with standard-parsing of "reg" properties etc...

So for devices who don't actually need anything more, we may get
away re-using platform devices as-is, all we would need is some
kind of conversion table or such to map OF match to platform dev names,
or maybe a secondary match table in the drivers themselves.

Anyway, that's an old discussion, something we still need to sort out...

Ben.
