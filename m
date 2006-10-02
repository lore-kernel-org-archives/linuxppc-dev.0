Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17696.49584.252608.249426@cargo.ozlabs.ibm.com>
Date: Mon, 2 Oct 2006 17:37:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 3/15] qe_lib: Add common files
In-Reply-To: <20060930183333.0ec7fe0f.kim.phillips@freescale.com>
References: <20060930183333.0ec7fe0f.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kim Phillips writes:

> qe_lib: Add common files

> diff --git a/arch/powerpc/sysdev/qe_lib/Makefile b/arch/powerpc/sysdev/qe_lib/Makefile
> new file mode 100644
> index 0000000..9a54a81
> --- /dev/null
> +++ b/arch/powerpc/sysdev/qe_lib/Makefile
> @@ -0,0 +1,8 @@
> +#
> +# Makefile for the linux ppc-specific parts of QE
> +#
> +obj-$(CONFIG_QUICC_ENGINE)+= qe_common.o qe.o qe_ic.o qe_io.o

But qe.c, qe_ic.c and qe_io.c don't exist as of this patch, so the
kernel won't build.

Also I notice that qe_common.c gets added by this patch and then
modified by subsequent patches.  Why don't we just add the final
version instead?

It looks to me like most of this series needs to be committed as one
commit so that git bisect still works.  Please re-send the patches
(except the rheap fix) as a series where the kernel will build and run
after each patch in the series.

Also, when you are sending on a patch that someone else created,
please make the first non-blank line of the message say "From: "
followed by the author's name and email address, so we get the
attribution right in the git repository.

Paul.
