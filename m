Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B2ECAB6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 07:40:28 +1000 (EST)
Subject: Re: powerpc: mpc85xx regression since 2.6.39-rc2, one cpu core lame
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Richard Cochran <richardcochran@gmail.com>, Kumar Gala
	<galak@kernel.crashing.org>
In-Reply-To: <20110517162827.GA16918@riccoc20.at.omicron.at>
References: <20110517162827.GA16918@riccoc20.at.omicron.at>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 May 2011 07:40:16 +1000
Message-ID: <1305668416.2781.23.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-05-17 at 18:28 +0200, Richard Cochran wrote:
> Ben,
> 
> Recent 2.6.39-rc kernels behave strangely on the Freescale dual core
> mpc8572 and p2020. There is a long pause (like 2 seconds) in the boot
> sequence after "mpic: requesting IPIs..."
> 
> When the system comes up, only one core shows in /proc/cpuinfo. Later
> on, lots of messages appear like the following:
> 
>    INFO: task ksoftirqd/1:9 blocked for more than 120 seconds.
> 
> I bisected [1] the problem to:
> 
>    commit c56e58537d504706954a06570b4034c04e5b7500
>    Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>    Date:   Tue Mar 8 14:40:04 2011 +1100
> 
>        powerpc/smp: Create idle threads on demand and properly reset them
> 
> I don't see from that commit what had gone wrong. Perhaps you can
> help resolve this?

Hrm, odd. Kumar, care to have a look ? That's what happens when you
don't get me HW to test with :-)

Cheers,
Ben.

> Thanks,
> Richard
> 
> 
> 1. I had to patch commit e5462d16 by hand when bisecting, which is a
>    fixup for commit fa3f82c8 and not yet merged in c56e5853.
