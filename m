Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3B89DDDEC
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 11:33:39 +1100 (EST)
Subject: Re: [PATCH 1/3 v3] Add StorCenter DTS first draft.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40801221449p28889ea5r68bd726726558dc0@mail.gmail.com>
References: <E1JHRkS-0005du-O1@jdl.com>
	<fa686aa40801221449p28889ea5r68bd726726558dc0@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 23 Jan 2008 11:33:16 +1100
Message-Id: <1201048396.6807.52.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > +
> > +               mpic: interrupt-controller@40000 {
> > +                       #interrupt-cells = <2>;
> > +                       #address-cells = <0>;
> 
> Is #address-cells needed?  There are no child nodes.

It's preferrable for interrupt controllers as #address-cells of the
parent interrupt controller defines the size of the interrupt unit
specifier in the child in the interrupt tree.

I think there's an ongoing argument as to whether the absence of
#address-cells should be the same as #address-cells = 0 in that specific
case but I'm not sure the code does the right thing so let's have it
explicit.

Ben.
