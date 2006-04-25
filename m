Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 97F1267BAD
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 07:39:00 +1000 (EST)
Date: Tue, 25 Apr 2006 14:38:57 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FT u-boot shim
Message-ID: <20060425213857.GA4176@gate.ebshome.net>
References: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
	<20060425182418.GA1132@gate.ebshome.net>
	<200604251329.35584.bcook@bpointsys.com>
	<248CD1B3-A33B-47F5-AFE8-F7C9DDCD1D0B@kernel.crashing.org>
	<20060425185314.GC1132@gate.ebshome.net>
	<1448E56E-1327-40D5-BE44-0DC103AC3E8A@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448E56E-1327-40D5-BE44-0DC103AC3E8A@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 25, 2006 at 03:00:05PM -0500, Kumar Gala wrote:
> 
> If we have a u-boot shim there are some questions that need answering:
> * where should the .dts live (hate duplicating the file both in u- 
> boot and kernel source tree)

I have no strong opinion on this, maybe arch/powerpc/boot/85xx or 
something. Although we may require having U-Boot tree somewhere I 
don't particularly like this solution, it's better to keep kernel 
self-contained, even if it requires some duplication. I personally 
don't see this as an issue, because I assume this file isn't gonna 
change frequently anyway.

Also, I think it's much safer to have this file in the kernel, this 
way we will avoid potential problems with using different U-Boot 
versions with different versions.

> * how does build system find .dts

If we go with "we-need-U-Boot-tree" solution, we can add Kconfig 
option to specify path to U-Boot tree.

> * a Kconfig option to enable shim

Yes, there should be an option, for boards which can support old and 
new U-Boot it should be user-selectable with old U-Boot being 
a default. For boards which support only one type of U-Boot, this 
option can be selected automatically.

> * assume done as a boot wrapper of sorts

Yeah, probably.

-- 
Eugene
