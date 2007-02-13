Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9EADFDDEE6
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 08:20:16 +1100 (EST)
Subject: Re: [PATCH 4/16] powerpc: Allow duplicate lmb_reserve() calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <21160.1171350320@neuling.org>
References: <20070213061024.82D45DDD0D@ozlabs.org>
	<21160.1171350320@neuling.org>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 07:44:14 +1100
Message-Id: <1171399454.20192.92.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This might indicate that two things actually want to use the same memory
> region.  How about we print a warning?

I don't think so. If we want to print that sort of warning, I'd rather
do it in the code that creates the reserve map (not in the kernel) or if
the reserve map has overlapping but not identical entries.

There are various cases where we used to rely on things being in the
reserve map and that the kernel "knows" how to reserve itself (like the
initrd typically) where warnings would just be confusing.

Ben.
