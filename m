Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D3584DDF60
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 04:24:55 +1000 (EST)
Message-ID: <46DEF44E.8070003@s5r6.in-berlin.de>
Date: Wed, 05 Sep 2007 20:24:14 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@gmail.com>
Subject: Re: [PATCH] Re: Sleep problems with kernels >= 2.6.21 on powerpc
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>
	<20070827065246.GA21220@ime.usp.br>
	<46D279E8.10001@edge.ping.de> <46D72BC6.3020809@edge.ping.de>
	<20070905100754.57ab4e3e.akpm@linux-foundation.org>
	<46DEEBBE.4070201@s5r6.in-berlin.de>
	<tkrat.7174534bdd0ddaff@s5r6.in-berlin.de>
In-Reply-To: <tkrat.7174534bdd0ddaff@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Kristian_H=F8gsber?=, michal.k.k.piotrowski@gmail.com,
	=?ISO-8859-1?Q?g?= <krh@redhat.com>,
	linux-kernel@vger.kernel.org, rjw@sisk.pl,
	linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pm@lists.linux-foundation.org, Tim Teulings <rael@edge.ping.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rogério Brito wrote on 2007-08-27:
> If things progress well, I will incrementally include features on the
> kernel that I need (I left out, for instance, the Firewire subsystem, so
> that compilation wouldn't take more than an hour here, despite the fact
> that I do need Firewire support on the kernel) and see the point where
> things are not normal.

The trivial pci_set_power_state issue aside, resume is currently
defective with the new firewire-ohci driver:
  - The version in Linus' tree doesn't restore a certain detail of
    IEEE 1394 state during resume, hence some protocols like SBP-2 don't
    work after resume unless you unload and reload the drivers.
  - The version in -mm restores everything but panics soon after resume
    on an APM notebook in combination with some SBP-2 targets.  I have
    yet to try netconsole or so to gather more information.
-- 
Stefan Richter
-=====-=-=== =--= --=-=
http://arcgraph.de/sr/
