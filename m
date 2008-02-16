Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4BF6EDDEBC
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 22:50:19 +1100 (EST)
Subject: Re: [PATCH 1/2] fb: add support for foreign endianness
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080205154432.GA8749@localhost.localdomain>
References: <20080205154432.GA8749@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 16 Feb 2008 22:49:58 +1100
Message-Id: <1203162598.22915.48.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, adaplas@gmail.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-02-05 at 18:44 +0300, Anton Vorontsov wrote:
> This patch adds support for the framebuffers with non-native
> endianness. This is done via FBINFO_FOREIGN_ENDIAN flag that will
> be used by the drivers. Depending on the host endianness this flag
> will be overwritten by FBINFO_BE_MATH internal flag, or cleared.
> 
> Tested to work on MPC8360E-RDK (BE) + Fujitsu MINT framebuffer (LE).

Good luck running X on that thing :-)

The base server seems to cope.. until you start using render operations
or that sort of things, and then things blow up. There's shitload of
stuff that seems to assume native fb endianness..

Ben.
