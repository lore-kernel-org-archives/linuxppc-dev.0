Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E73BDB7006
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2012 04:30:36 +1000 (EST)
Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1340880651.20977.83.camel@pasglop>
Date: Thu, 28 Jun 2012 13:30:26 -0500
Message-Id: <D2BA086B-6EB3-4853-B901-FA37DCCDC134@kernel.crashing.org>
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
 <1340748634.3732.27.camel@pasglop>
 <20120627102138.GB10476@localhost.localdomain>
 <1340797732.3732.46.camel@pasglop>
 <20120628033815.GA11387@localhost.localdomain>
 <1340880651.20977.83.camel@pasglop>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 28, 2012, at 5:50 AM, Benjamin Herrenschmidt wrote:

> On Thu, 2012-06-28 at 11:38 +0800, Zhao Chenhui wrote:
>>=20
>>=20
>> The bootloader have done a timebase sync. If we do not need KEXEC or
>> HOTPLUG_CPU feature, it is unnecessary to do it again at boot time of
>> kernel. I only compile the timebase sync routines
>> when users enable KEXEC or HOTPLUG_CPU.=20
>=20
> Still, how much are you really saving ? Is it worth the added mess and
> loss of test coverage ?
>=20
> We have too many conditional stuff like that already.
>=20
> Cheers,
> Ben.
>=20

I'd also be interested to know how long it actually takes to do time =
base sync this way.  Since you are freezing the timers for some period =
how long does it really take between the freeze/unfreeze in =
mpc85xx_give_timebase()

+	mpc85xx_timebase_freeze(1);
...
+	mpc85xx_timebase_freeze(0);

You can use ATBL/U as a way to see # of cycles taken.

- k=
