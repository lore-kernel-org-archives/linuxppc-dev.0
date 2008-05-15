Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3FF26DDEE8
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 16:51:38 +1000 (EST)
Subject: Re: PS3: Fix memory hotplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <1210834125.8297.80.camel@pasglop>
References: <4829C07A.4040407@am.sony.com> <1210834125.8297.80.camel@pasglop>
Content-Type: text/plain
Date: Wed, 14 May 2008 23:51:29 -0700
Message-Id: <1210834289.8297.85.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Paul, any thoughts here ? Should we add a lock ? That would mean being
> careful as the LMB stuff can be called very early, and spinlock wants
> things like PACA and possibly lockdep to be around.. 

Actually, we call early_init_devtree(), which populates the LMB, after
we initialize the PACA and lockdep, so it -should- be safe to add a
spinlock.

Dave ? Any objection to adding a spinlock to the LMB code ?

Cheers,
Ben.
