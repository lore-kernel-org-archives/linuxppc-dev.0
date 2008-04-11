Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AED07DE0F2
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 11:37:57 +1000 (EST)
Date: Thu, 10 Apr 2008 18:37:46 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Message-ID: <20080411013745.GA28655@farnsworth.org>
References: <1207869739-19892-1-git-send-email-paul.gortmaker@windriver.com>
	<0006b107cbf99a968352d9369a8e26304d4bf13a.1207868891.git.paul.gortmaker@windriver.com>
MIME-Version: 1.0
In-Reply-To: <0006b107cbf99a968352d9369a8e26304d4bf13a.1207868891.git.paul.gortmaker@windriver.com>
Subject: Re: [PATCH 1/3] powerpc: Add support for Wind River SBC8641D board
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 10, 2008 at 07:22:17PM -0400, Paul Gortmaker wrote:
> This adds support for the Wind River SBC8641D board, based
> largely on the mpc86xx_hpcn support.  The biggest difference is
> the lack of the Uli and the i8259 cascade, which simplifies things.

Hi Paul,

A couple issues.  (These should be fixed in the mpc86xx_hpcn.c as well.)

> +void __init
> +sbc8641_init_irq(void)

Make this function static.

> +void
> +sbc8641_show_cpuinfo(struct seq_file *m)

This one too.

> +static int __init sbc8641_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	if (of_flat_dt_is_compatible(root, "mpc86xx"))

"mpc86xx" is too generic.  You should make the compatible field
in your devtree something like "WIND,sbc8641d", to differentiate
it from the mpc86xx_hpcn.

> +long __init
> +mpc86xx_time_init(void)

Another static function.

Regards,
-Dale
