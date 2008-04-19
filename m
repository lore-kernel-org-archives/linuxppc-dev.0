Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C637DDEE4
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 19:10:00 +1000 (EST)
Date: Sat, 19 Apr 2008 11:09:34 +0200
From: Jean Delvare <khali@linux-fr.org>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] [POWERPC] i2c: fix build breakage introduced by OF
	helpers
Message-ID: <20080419110934.672648e6@hyperion.delvare>
In-Reply-To: <20080418.231128.97404791.davem@davemloft.net>
References: <18441.28496.84724.411784@cargo.ozlabs.ibm.com>
	<20080418.210933.01471700.davem@davemloft.net>
	<18441.33181.511355.338428@cargo.ozlabs.ibm.com>
	<20080418.231128.97404791.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, i2c@lm-sensors.org, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 18 Apr 2008 23:11:28 -0700 (PDT), David Miller wrote:
> From: Paul Mackerras <paulus@samba.org>
> Date: Sat, 19 Apr 2008 15:22:37 +1000
> 
> > David Miller writes:
> > > From: Paul Mackerras <paulus@samba.org>
> > > Date: Sat, 19 Apr 2008 14:04:32 +1000
> > > 
> > > It's OK if this breaks the sparc64 allmodconfig build, I'll take
> > > care of this once it's merged in.
> > 
> > It breaks the sparc32 allmodconfig build, which seems to be a
> > concern.  How do you suggest we fix that?
> 
> I'll fix both sparc64 and sparc32 builds when I merge my sparc
> tree in.

Guys, you're doing things the wrong way around. Breaking things to fix
them later is not OK, it's a pain for testers and also when bisecting
the kernel. Everything should still work after merging the powerpc
tree. Dave, if you need to loosen the dependency, you should do it
yourself _after_ having changed whatever needs to be in the sparc32 and
sparc64 trees so that loosening the dependency doesn't break anything.
As far as I can see it's only a matter of changing one line in a
Kconfig file, that's not exactly difficult to do it in the right order.

Thanks,
-- 
Jean Delvare
