Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D5AF6B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 04:21:39 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc: add support for MPIC message register API
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1329446943-9732-2-git-send-email-B38951@freescale.com>
Date: Wed, 21 Mar 2012 12:21:36 -0500
Message-Id: <BAB50753-4444-443B-8291-CC54E01009E4@kernel.crashing.org>
References: <1329446943-9732-1-git-send-email-B38951@freescale.com>
 <1329446943-9732-2-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: meador_inge@mentor.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 16, 2012, at 8:49 PM, Jia Hongtao wrote:

> Some MPIC implementations contain one or more blocks of message =
registers
> that are used to send messages between cores via IPIs.  A simple API =
has
> been added to access (get/put, read, write, etc ...) these message =
registers.
> The available message registers are initially discovered via nodes in =
the
> device tree.  A separate commit contains a binding for the message =
register
> nodes.
>=20
> Signed-off-by: Meador Inge <meador_inge@mentor.com>
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> This patch is an update for : http://patchwork.ozlabs.org/patch/98075/
>=20
> Meador Inge addressed the following points from Ben's feedback:
> * Drop the 'mpic_msgr.msr' field.
> * Drop the 'mpic_msgr.mer' field in favor of address arithmetic off of =
 'mpic_msgr.addr'.
> * Document the API.
> * Disable MPIC register in 'mpic_msgr_put'.
> * Put locking in 'mpic_msgr_disable'.
> * s/EXPORT_SYMBOL/EXPORT_SYMBOL_GPL/g.
> * Make 'mpic_msgr_write' and 'mpic_msgr_read' 'static inline'.
>=20
> I just fixed the checkpatch errors and addressed the following item:
> * In 'mpic_msgr_set_destination' have a wrapper that goes from Linux
>  CPU number to HW CPU number.
>=20
> arch/powerpc/include/asm/mpic_msgr.h |  132 ++++++++++++++++
> arch/powerpc/platforms/Kconfig       |    8 +
> arch/powerpc/sysdev/Makefile         |    2 +
> arch/powerpc/sysdev/mpic_msgr.c      |  282 =
++++++++++++++++++++++++++++++++++
> 4 files changed, 424 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/include/asm/mpic_msgr.h
> create mode 100644 arch/powerpc/sysdev/mpic_msgr.c

applied

- k=
