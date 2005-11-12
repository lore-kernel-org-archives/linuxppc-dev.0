Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFF1568746
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 09:34:48 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20051112222045.GC21448@stusta.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122237.17157.mbuesch@freenet.de>
	<20051112215304.GB21448@stusta.de>
	<200511122257.05552.mbuesch@freenet.de>
	<20051112222045.GC21448@stusta.de>
Content-Type: text/plain
Date: Sun, 13 Nov 2005 09:31:06 +1100
Message-Id: <1131834667.7406.49.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	Michael Buesch <mbuesch@freenet.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> ucSystemType is a variable that is EXPORT_SYMBOL'ed but never used in 
> any way.
> 
> _prep_type is a variable that is needlessly EXPORT_SYMBOL'ed.

Therse are old PREP stuffs

> But prep_init points to the real problem:
> 
> CONFIG_PPC_PREP requires code from arch/ppc/platforms/, but this 
> directory is never visited.
> 
> What is the correct fix?
> Migrate the code from arch/ppc/platforms/ to arch/powerpc/platforms/ ?

Yes, PREP need to be migrated, but that includes adding some minimum
device-tree support for it among others. And few people still have PREP
machines, I'm not even sure we have access to one here in ozlabs... I
think for 2.6.15, we'd better just disable it in .config for
ARCH=powerpc.

Ben.
