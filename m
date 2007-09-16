Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <1189940011152-git-send-email-tnt@246tNt.com>
References: <11899400103383-git-send-email-tnt@246tNt.com>
	<1189940011152-git-send-email-tnt@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <03B2F809-EF9E-4B98-BC93-2E98A2DBD225@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/7] powerpc: Changes the config mechanism for rheap
Date: Sun, 16 Sep 2007 10:59:34 -0500
To: Sylvain Munaut <tnt@246tNt.com>
Cc: Grant Likely <glikely@gmail.com>, Paul Mackerras <paulus@samba.org>,
	PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 16, 2007, at 5:53 AM, Sylvain Munaut wrote:

> Instead of having in the makefile all the option that
> requires rheap, we define a configuration symbol
> and when needed we make sure it's selected.
>
> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> ---
>  arch/powerpc/Kconfig                   |    2 ++
>  arch/powerpc/lib/Kconfig               |    3 +++
>  arch/powerpc/lib/Makefile              |    5 +----
>  arch/powerpc/platforms/Kconfig         |    2 ++
>  arch/powerpc/platforms/Kconfig.cputype |    1 +
>  5 files changed, 9 insertions(+), 4 deletions(-)
>  create mode 100644 arch/powerpc/lib/Kconfig

This probably breaks arch/ppc in that you'll need to add the proper  
select PPC_LIB_RHEAP to its Kconfig(s) for 8xx & CPM2.

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 00099ef..76063b9 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -634,6 +634,8 @@ source "fs/Kconfig"
>
>  source "arch/powerpc/sysdev/qe_lib/Kconfig"
>
> +source "arch/powerpc/lib/Kconfig"
> +
>  source "lib/Kconfig"
>
>  menu "Instrumentation Support"
> diff --git a/arch/powerpc/lib/Kconfig b/arch/powerpc/lib/Kconfig
> new file mode 100644
> index 0000000..f383ad4

why not just stick this in the toplevel powerpc/Kconfig

> --- /dev/null
> +++ b/arch/powerpc/lib/Kconfig
> @@ -0,0 +1,3 @@
> +config PPC_LIB_RHEAP
> +	bool
> +	default n

Please add a help description here.

[snip]

- k
