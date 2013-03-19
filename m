Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5F3F72C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 17:40:46 +1100 (EST)
Message-ID: <1363675240.18880.19.camel@pasglop>
Subject: Re: Kernel panic on PowerMac G5 while scanning for SMU sensors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Phileas Fogg <phileas-fogg@mail.ru>
Date: Tue, 19 Mar 2013 07:40:40 +0100
In-Reply-To: <5145BA3A.8080508@mail.ru>
References: <5145B20C.2090104@mail.ru> <5145BA3A.8080508@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-03-17 at 13:42 +0100, Phileas Fogg wrote:

> A further analysis showed that it crashes in _smu_i2c_complete_command_
> which is called from _smu_i2c_low_completion_.
> 
> This line caused the panic:
> 
> list_del(&cmd->link);

Ok, we must have a bug :-) I'm on holiday for a while, I can look when
I'm back.

However, I would generally advise against messing around with the
sensors directly from userspace which is what I believe lm-sensors does.
It has no real understanding of what those sensors are about, where they
are located etc... and might also conflict with the use of those sensors
by the kernel windfarm drivers.

If you want to look at the values, windfarm does expose them to
userspace in sysfs, you might want to take a peek.

Cheers,
Ben.
