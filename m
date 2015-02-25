Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.182])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 403BF1A0013
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 23:02:45 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Markus Stockhausen' <stockhausen@collogia.de>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: RE: [PATCH v1 1/3] SHA1 for PPC/SPE - assembler
Date: Wed, 25 Feb 2015 12:01:45 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CAEBB2D@AcuExch.aculab.com>
References: <ce3e5ff2-5904-4e1c-bfa9-e37c9682f961@EXCHANGE.collogia.de>
In-Reply-To: <ce3e5ff2-5904-4e1c-bfa9-e37c9682f961@EXCHANGE.collogia.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Stockhausen
> [PATCH v1 1/3] SHA1 for PPC/SPE - assembler
>=20
> This is the assembler code for SHA1 implementation with
> the SIMD SPE instruction set. With the enhanced instruction
> set we can operate on 2 32 bit words in parallel. That helps
> reducing the time to calculate W16-W79. For increasing
> performance even more the assembler function can compute
> hashes for more than one 64 byte input block.
>=20
> The state of the used SPE registers is preserved via the
> stack so we can run from interrupt context

Does the ppc use the same kind of delayed state save for the SPE
resisters that x86 uses (at least on the BSDs) for its FP (etc) regs.

That would mean that the registers might contain values for
a different process, and that the cpu could receive an IPI
requesting they be written to the processes normal save area
so that they can be reloaded onto a different cpu.

	David
