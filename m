Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D5477B6FCA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2012 06:15:24 +1000 (EST)
Subject: Re: [PATCH] powerpc: fix build when CONFIG_BOOKE_WDT is enabled
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4c2709df9123c32681503972be3707026c9dab74.1334816894.git.baruch@tkos.co.il>
Date: Thu, 19 Apr 2012 15:15:25 -0500
Message-Id: <E58B01B5-BE5C-4857-A31C-58CBB0AD5937@kernel.crashing.org>
References: <4c2709df9123c32681503972be3707026c9dab74.1334816894.git.baruch@tkos.co.il>
To: Baruch Siach <baruch@tkos.co.il>
Cc: David Howells <dhowells@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 19, 2012, at 1:32 AM, Baruch Siach wrote:

> Commit ae3a197e (Disintegrate asm/system.h for PowerPC) broke build of
> assembly files when CONFIG_BOOKE_WDT is enabled as follows:
>=20
>  AS      arch/powerpc/lib/string.o
> /home/baruch/git/stable/arch/powerpc/include/asm/reg_booke.h: =
Assembler messages:
> /home/baruch/git/stable/arch/powerpc/include/asm/reg_booke.h:19: =
Error: Unrecognized opcode: `extern'
> /home/baruch/git/stable/arch/powerpc/include/asm/reg_booke.h:20: =
Error: Unrecognized opcode: `extern'
>=20
> Since setup_32.c is the only user of the booke_wdt configuration =
variables, move
> the declarations there.
>=20
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> arch/powerpc/include/asm/reg_booke.h |    5 -----
> arch/powerpc/kernel/setup_32.c       |    5 +++++
> 2 files changed, 5 insertions(+), 5 deletions(-)

applied to merge, minor moving of the externs to be in same ifdef in =
setup_32.c

- k=
