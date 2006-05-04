Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17498.34041.993647.189930@cargo.ozlabs.ibm.com>
Date: Fri, 5 May 2006 08:49:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
In-Reply-To: <Pine.LNX.4.44.0605041622180.3700-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0605041622180.3700-100000@gate.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Please pull from 'for_paulus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git

> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -236,6 +236,7 @@ arch_initcall(ppc_init);
>  void __init setup_arch(char **cmdline_p)
>  {
>  	extern void do_init_bootmem(void);
> +	extern void setup_panic(void);

Urk.

> @@ -285,6 +286,9 @@ #endif
>  	/* reboot on panic */
>  	panic_timeout = 180;
>  
> +	if (ppc_md.panic)
> +		setup_panic();

Since no 32-bit platform sets ppc_md.panic AFAICS, I guess this
doesn't need to be pushed into 2.6.17.  Please redo with setup_panic
declared in a header file.

Paul.
