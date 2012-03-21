Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2E56FB6EF4
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2012 02:09:07 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: don't call of_platform_bus_probe() twice
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20120319160452.B57D13E05A5@localhost>
Date: Wed, 21 Mar 2012 10:08:49 -0500
Message-Id: <50E98FCC-EA02-4215-98EC-7C16671447DF@kernel.crashing.org>
References: <1322669957-8259-1-git-send-email-timur@freescale.com>
 <F8C3451C-1B14-4C30-A194-B15B6C10B0A7@kernel.crashing.org>
 <4F63A7A4.4000205@freescale.com> <20120319160452.B57D13E05A5@localhost>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Scott Wood <scottwood@freescale.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Timur Tabi <timur@freescale.com>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 19, 2012, at 11:04 AM, Grant Likely wrote:

> On Fri, 16 Mar 2012 15:50:44 -0500, Timur Tabi <timur@freescale.com> =
wrote:
>> Kumar Gala wrote:
>>=20
>>> This seems like paper taping over the real issue.  We should be able =
to call of_platform_bus_probe() multiple times.
>>=20
>> I tried debugging it, but I couldn't figure it out.  My guess is that =
the
>> nodes probed by of_platform_bus_probe() are somehow "reserved", so =
that
>> the second time it's called, they're skipped.  I figured that this =
was
>> just a side-effect of the way the OF layer works.
>=20
> The problem is that you want to create devices for grandchildren
> nodes when the bus ids passed in don't match any of the child nodes so
> the of_platform_bus_probe() doesn't iterate down to that level.  This
> is correct and expected behaviour.
>=20
> g.

Does of_platform_populate() handle this?

- k=
