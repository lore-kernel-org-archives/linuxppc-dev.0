Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDE4D67B6A
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 09:14:57 +1000 (EST)
Subject: Re: [POWERPC] convert string i/o operations to C
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <45103DF0.9050409@genesi-usa.com>
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>
	<20060919182953.GK29167@austin.ibm.com>
	<20060919135259.303706d3.kim.phillips@freescale.com>
	<45103DF0.9050409@genesi-usa.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 09:14:36 +1000
Message-Id: <1158707676.6002.174.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-09-19 at 20:58 +0200, Matt Sealey wrote:
> Shouldn't this stuff be optimized out depending on what processor you're 
> ACTUALLY running?
> 
> For a generic "powerpc" kernel it can be understood, but when you 
> consider that on 970/POWER4 and above they use lwsync instead of sync
> (google for them and see the mailing list posts :), just to breathe back 
> some performance in spinlocks and so on, surely this can be rejigged so 
> that processors don't do more work than necessary..? Even a noop takes 
> time doesn't it?

The architecture is precise enough there. It should be twi,isync. The
goal of the isync is to make sure no subsequent instruction can execute
until the previous conditional branch has been fully resolved, which
implies loading the dependent data. An isync is the only instruction in
this specific case that is guaranteed to provide what we need by the
architecture.

Ben
