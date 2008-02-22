Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51026DE067
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 09:26:42 +1100 (EST)
Subject: Re: How to dynamically disable/enable CPU features?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20080221200758.62940@gmx.net>
References: <20080221200758.62940@gmx.net>
Content-Type: text/plain
Date: Sat, 23 Feb 2008 09:26:19 +1100
Message-Id: <1203719179.6976.25.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-02-21 at 21:07 +0100, Gerhard Pircher wrote:
> Hi,
> 
> I'm wondering how to disable or enable CPU features based on the board the
> kernel is running on. In my case I want to disable the
> CPU_FTR_NEED_COHERENT flag for 74xx CPUs, because it locks up the machine.
> I tried to clear the flag in the platform's *_probe() function with the
> following code:
> 
> cur_cpu_spec->cpu_features &= ~CPU_FTR_NEED_COHERENT;

That works on 64 bits but unfortunately not on 32 bits. This is a
longstanding issue that we need to fix. ie. we need to move the
fixups later in the boot process (if possible put them in the 
same place for 32 and 64 bits), though that needs to be done very
carefully, making sure nothing that requires those fixups ends up
happening before they happen as a result of the move.

Ben.
