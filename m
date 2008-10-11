Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D3C5DDD04
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Oct 2008 09:21:42 +1100 (EST)
Subject: Re: [PATCH RFC] pata_platform: add 8 bit data io support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wang Jian <lark@linux.net.cn>
In-Reply-To: <20081011180014.GA4908@debian>
References: <20081011180014.GA4908@debian>
Content-Type: text/plain
Date: Sun, 12 Oct 2008 09:21:27 +1100
Message-Id: <1223763687.8157.178.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Tejun Heo <htejun@gmail.com>,
	linux-ide@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-10-12 at 02:00 +0800, Wang Jian wrote:
> To avoid adding another rare used ata_port member, new bit is added to
> ata_port->flags.
> 
> Originally, I hacked pata_platform to make it 8bit only to support 8bit
> data wired CF card. This patch is more generic.
> 
> With this patch, __pata_platform_probe() interface is changed, and
> pata_of_platform is broken, so a small patch is needed.
> 
> Signed-off-by: Wang Jian <lark@linux.net.cn>
> ---

A couple of things. First I would personally prefer (but I'm not the
libata maintainer so it's up to Jeff ...) if you had a separate patch
that adds the 8-bit support to libata core first, and then a patch that
modifies pata_platform.

Then, in order to avoid breaking bisection, I would like you to fixup
pata_of_platform in the same patch that modifies __pata_platform_probe
so there is no breakage in between patches.

Now, regarding the patch itself, if the core grows a 8-bit flag, then
I strongly suspect the core should also grow the 8-bit xfer function
rather than having it hidden in pata_platform.

Cheers,
Ben.
