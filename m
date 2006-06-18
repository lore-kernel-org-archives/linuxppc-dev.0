Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 993CA67B4A
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jun 2006 13:07:52 +1000 (EST)
Subject: Re: [PATCH 5/9 v3] Add the MPC8641 HPCN platform files.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1Frjen-0004Oz-Hz@jdl.com>
References: <E1Frjen-0004Oz-Hz@jdl.com>
Content-Type: text/plain
Date: Sun, 18 Jun 2006 13:07:35 +1000
Message-Id: <1150600056.23600.152.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> struct smp_ops_t smp_86xx_ops = {
> +	.message_pass = smp_mpic_message_pass,
> +	.probe = smp_mpic_probe,
> +	.kick_cpu = smp_86xx_kick_cpu,
> +	.setup_cpu = smp_86xx_setup_cpu,
> +	.take_timebase = smp_generic_take_timebase,
> +	.give_timebase = smp_generic_give_timebase,
> +};

You don't have any way to freeze the timebase ? (No GPIO controlling
TBEN ?) It's pretty nasty to rely on software sync, especially if it's
supposed to be an example design ...

Ben.
