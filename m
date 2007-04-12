Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E93B0DDF83
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 09:27:22 +1000 (EST)
Date: Thu, 12 Apr 2007 18:23:26 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3] powerpc: change rheap functions to use ulongs instead
	of pointers
In-Reply-To: <1176417846358-git-send-email-timur@freescale.com>
Message-ID: <Pine.LNX.4.64.0704121823030.7202@localhost.localdomain>
References: <1176417846358-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 12 Apr 2007, Timur Tabi wrote:

> The rheap allocation functions return a pointer, but the actual value is based
> on how the heap was initialized, and so it can be anything, e.g. an offset
> into a buffer.  A ulong is a better representation of the value returned by
> the allocation functions.
>
> This patch changes all of the relevant rheap functions to use a unsigned long
> integers instead of a pointer.  In case of an error, the value returned is
> a negative error code that has been cast to an unsigned long.  The caller can
> use the IS_ERR_VALUE() macro to check for this.
>
> All code which calls the rheap functions is updated accordingly.  Macros
> IS_MURAM_ERR() and IS_DPERR(), have been deleted in favor of IS_ERR_VALUE().
>
> Also added error checking to rh_attach_region().
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This version of the patch applies to Paul's master.  The previous version was
> intended for for-2.6.22, but it also had some errors in it that would prevent
> it from applying to any tree.
>
>  arch/powerpc/lib/rheap.c                |  117 ++++++++++++++++++-------------
>  arch/powerpc/sysdev/commproc.c          |   20 +++---
>  arch/powerpc/sysdev/cpm2_common.c       |   21 +++---
>  arch/powerpc/sysdev/qe_lib/qe.c         |   29 ++++----
>  arch/powerpc/sysdev/qe_lib/ucc_fast.c   |    5 +-
>  arch/powerpc/sysdev/qe_lib/ucc_slow.c   |    7 +-
>  arch/ppc/8xx_io/commproc.c              |   22 +++---
>  arch/ppc/lib/rheap.c                    |   95 +++++++++++++------------
>  arch/ppc/syslib/cpm2_common.c           |   23 +++---
>  drivers/net/fs_enet/mac-scc.c           |    2 +-
>  drivers/net/ucc_geth.c                  |   30 ++++----
>  drivers/serial/cpm_uart/cpm_uart_cpm1.c |    4 +-
>  drivers/serial/cpm_uart/cpm_uart_cpm2.c |    4 +-
>  include/asm-powerpc/qe.h                |   13 +---
>  include/asm-ppc/commproc.h              |   13 +---
>  include/asm-ppc/cpm2.h                  |   13 +---
>  include/asm-ppc/rheap.h                 |   20 +++---
>  17 files changed, 221 insertions(+), 217 deletions(-)

applied.

- k
