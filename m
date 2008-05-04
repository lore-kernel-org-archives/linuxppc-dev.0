Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1EB27DDDFB
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 07:45:56 +1000 (EST)
Subject: Re: how to check for "optional" ppc chip features (MSR_BE)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <DC173CDE-FBC4-4EA0-8022-3F993B6466BF@kernel.crashing.org>
References: <20080502012118.96ED926FA07@magilla.localdomain>
	<DC173CDE-FBC4-4EA0-8022-3F993B6466BF@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 05 May 2008 07:45:49 +1000
Message-Id: <1209937549.21644.2.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-05-01 at 22:48 -0500, Kumar Gala wrote:
> 
> Look at arch/powerpc/kernel/cputable.c to see how we handle issues  
> like this.
> 

Oh and classic pitfall: If you define a new feature bit, make sure
CPU_FTRS_POSSIBLE is updated to contain it in cputable.h

Also, It may not be totally clear, but:

PPC_FEATURE_* are exposed to userspace via AT_HWCAP

CPU_FTR_* are kernel internal (and can be used for runtime patching of
assembly code).

Ben.
