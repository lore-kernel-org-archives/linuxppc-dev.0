Date: Thu, 5 Jun 2003 15:40:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: linuxppc_2_4_devel patch adding KGDB support to ev64260
Message-ID: <20030605224031.GA14976@ip68-0-152-218.tc.ph.cox.net>
References: <3EDFBA82.2010403@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3EDFBA82.2010403@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 05, 2003 at 02:47:46PM -0700, Mark A. Greer wrote:

> ===== arch/ppc/platforms/ev64260.c 1.22 vs edited =====
> --- 1.22/arch/ppc/platforms/ev64260.c	Fri Feb 28 10:31:00 2003
> +++ edited/arch/ppc/platforms/ev64260.c	Tue Jun  3 15:39:57 2003
[snip]
> +static void __init
> +ev64260_setup_arch(void)
[snip]
> @@ -416,14 +481,10 @@
>  		ppc_md.progress("ev64260_setup_arch: Enabling L2 cache", 0);
>
>  	/* Enable L2 and L3 caches (if 745x) */
> -	val = _get_L2CR();
> -	val |= L2CR_L2E;
> -	_set_L2CR(val);
> -
> -	if (PVR_VER(mfspr(PVR)) == PVR_VER(PVR_7450)) {
> -		val = _get_L3CR();
> -		val |= L3CR_L3E;
> -		_set_L3CR(val);
> +	_set_L2CR(_get_L2CR() | L2CR_L2E);
> +
> +	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_L3CR) {
> +		_set_L3CR(_get_L3CR() | L3CR_L3E);
>  	}
>
>  	if ( ppc_md.progress )

Redundant check.  _{get,set}_L3CR check for the appropriate cpufeature
flags.

> @@ -808,7 +789,7 @@
>  {
>  	extern char cmd_line[];
>
> -	cmd_line[0]=0;
> +	cmd_line[0] = '\0';
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	initrd_start=initrd_end=0;
>  	initrd_below_start_ok=0;

Um, is that really needed?  It shouldn't be..

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
