Return-Path: <jwboyer@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.178])
	by ozlabs.org (Postfix) with ESMTP id 8FC95DDEF7
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 06:38:13 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id o28so264244ele.3
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 13:38:07 -0700 (PDT)
Subject: Re: indications for oprofile in compact mode
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: torez <lnxtorez@linux.vnet.ibm.com>
In-Reply-To: <487267D8.5010605@linux.vnet.ibm.com>
References: <487267D8.5010605@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 16:37:52 -0400
Message-Id: <1215463072.20774.63.camel@weaponx>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-07 at 14:00 -0500, torez wrote:
> plain text document attachment (Indications oprofile in compact
> mode.txt)

Please don't send patches at attachments.

> This patch allows Performance monitoring driver to detect when
> operating in PowerPC compliance mode.

And why is that needed?  The reason should be included in the changelog
for the patch.

> use patch -p0 to apply.

This seems wrong.  The patch looks like a -p1 to me.

You're missing your Signed-off-by line.  See
Documentation/SubmittingPatches.

> 
> ==========================================================================
> diff -urN linux-2.6.26-rc7.orig/arch/powerpc/kernel/cputable.c linux-2.6.26-rc7/arch/powerpc/kernel/cputable.c
> --- linux-2.6.26-rc7.orig/arch/powerpc/kernel/cputable.c	2008-07-07 11:37:40.000000000 -0500
> +++ linux-2.6.26-rc7/arch/powerpc/kernel/cputable.c	2008-07-07 11:27:09.000000000 -0500
> @@ -352,6 +352,7 @@
>  		.icache_bsize		= 128,
>  		.dcache_bsize		= 128,
>  		.machine_check		= machine_check_generic,
> +		.oprofile_cpu_type	= "ppc64/compat-power5+",
>  		.platform		= "power5+",
>  	},
>  	{	/* Power6 */
> @@ -383,6 +384,7 @@
>  		.icache_bsize		= 128,
>  		.dcache_bsize		= 128,
>  		.machine_check		= machine_check_generic,
> +		.oprofile_cpu_type	= "ppc64/compat-power6",
>  		.platform		= "power6",
>  	},
>  	{	/* 2.06-compliant processor, i.e. Power7 "architected" mode */
> @@ -394,6 +396,7 @@
>  		.icache_bsize		= 128,
>  		.dcache_bsize		= 128,
>  		.machine_check		= machine_check_generic,
> +		.oprofile_cpu_type	= "ppc64/compat-power7",
>  		.platform		= "power7",
>  	},
>  	{	/* Power7 */
> @@ -1593,6 +1596,12 @@
>  			 * from the real PVR with a new value obtained
>  			 * using a logical PVR value, don't modify the
>  			 * performance monitor fields.
> +			 * The performance monitor sub-system needs to have
> +			 * access to the values from the real PVR, but, at 
> +			 * the same time it needs to be aware it may be running
> +			 * in compatibility mode. We we are changing the values
                                                When ^ ?

> +			 * for the real PVR to those of the compatibility PVR,
> +			 * change the oprofile_cpu_type field as well.

You might want to change the original comment to not say "...don't
modify the performance monitor fields."  Your addition explains why, but
it doesn't flow well with the original comment.

josh
