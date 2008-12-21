Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18765.40821.503441.882948@cargo.ozlabs.ibm.com>
Date: Sun, 21 Dec 2008 12:44:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/7] powerpc/32: Setup OF properties for kdump
In-Reply-To: <20081217200906.GC4624@oksana.dev.rtsoft.ru>
References: <20081217200610.GA31887@oksana.dev.rtsoft.ru>
	<20081217200906.GC4624@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov writes:

> From: Dale Farnsworth <dale@farnsworth.org>
> 
> Refactor the setting of kexec OF properties, moving the common code
> from machine_kexec_64.c to machine_kexec.c where it can be used on
> both ppc64 and ppc32.  This will be needed for kdump to work on ppc32
> platforms.
> 
> Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/kernel/machine_kexec.c    |   36 ++++++++++++++++++++
>  arch/powerpc/kernel/machine_kexec_64.c |   56 ++-----------------------------
>  2 files changed, 40 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> index 4f797c0..b3abebb 100644
> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
> @@ -120,6 +120,7 @@ int overlaps_crashkernel(unsigned long start, unsigned long size)
>  
>  /* Values we need to export to the second kernel via the device tree. */
>  static unsigned long kernel_end;
> +static unsigned long crashk_size;
>  
>  static struct property kernel_end_prop = {
>  	.name = "linux,kernel-end",

This patch doesn't apply.  The current version of machine_kexec.c ends
with overlaps_crashkernel.  There's no kernel_end or kernel_end_prop
in that file.  Is there a preceding patch that needs to be applied
first?

Paul.
