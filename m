Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5C35ADDF47
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 03:39:34 +1000 (EST)
In-Reply-To: <20070423084710.10570DDF14@ozlabs.org>
References: <20070423084710.10570DDF14@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <64f77a2f874650aae9980e37eea66b9c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Rename MPIC_BROKEN_U3 to MPIC_U3_HT_IRQS
Date: Mon, 23 Apr 2007 19:39:23 +0200
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Olof Johannsson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Rename MPIC_BROKEN_U3 to something a little more descriptive. Its
> effect is to enable support for HT irqs behind the PCI-X/HT bridge on
> U3/U4 (aka. CPC9x5) parts.

Not quite.  It's a workaround for the problem that
the U3/U4 HT interrupt interface doesn't send ACKs
for interrupts that require them ("level" interrupts).
It does this by setting the ACK bit in HT APIC config
space every time an interrupt from such a source happens.

This doesn't affect PCI bridges only.

The name change looks good though :-)


Segher
