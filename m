Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BBDC967BD6
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Oct 2006 09:51:40 +1000 (EST)
Subject: Re: [RFC] Porting AmigaOne platform code from ppc to powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20061019132423.270440@gmx.net>
References: <20060628202753.198630@gmx.net>	<s5hfyhopb0s.wl%tiwai@suse.de>
	<20060629211513.64980@gmx.net> <s5hwtaz9fdr.wl%tiwai@suse.de>
	<20060630182144.27980@gmx.net>  <20061019132423.270440@gmx.net>
Content-Type: text/plain
Date: Sun, 22 Oct 2006 09:51:32 +1000
Message-Id: <1161474692.10524.266.camel@localhost.localdomain>
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

On Thu, 2006-10-19 at 15:24 +0200, Gerhard Pircher wrote:
> Hi!
> 
> I'm working on the AmigaOne Linux kernel port. The AmigaOne is a G3/G4 desktop system and makes use of U-boot v1.1.0 as firmware. I intend to port the current code base of this platform to the powerpc architecture, but I'm not sure how to address this.
> 
> The "problem" is the device tree required by the powerpc architecture. The AmigaOne's U-boot version doesn't support the flattened device tree yet and also requires a special flash rom programmer tool (I guess it adds some sort of dongle code to the flash rom content). Otherwise users won't be able to boot AmigaOS4. Thus using a newer U-boot version is not really an option and AFAIK the OS4 developers are not going to update their U-boot version.
> 
> Well, some time ago I read about a CUIMAGE target that can be used to get powerpc-arch kernels working on old U-boot versions by using a precompiled/static device tree. I don't think that this approch makes sense for a desktop platform, which uses different CPUs (750FX, 750GX, 7410, 7450, 7455, etc..), PCI/AGP cards, etc.
> 
> Any advice for me in this case?

You can also look at the rework being done currently on zImage wrappers.
Among others, they have the ability to embed a device-tree.

Ben.
