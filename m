Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AEB21A003D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 01:15:42 +1100 (AEDT)
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com
 [IPv6:2607:f8b0:4002:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AADFA1402C4
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Feb 2016 01:15:40 +1100 (AEDT)
Received: by mail-yw0-x243.google.com with SMTP id c124so2748561ywe.0
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 06:15:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1455002269-26543-2-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1455002269-26543-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1455002269-26543-2-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Thu, 11 Feb 2016 17:15:38 +0300
Message-ID: <CAOJe8K0-XZA5pc6jSAizi8HJuvaE5rO9Aewy9qpb32oetSo_ag@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] powerpc/xmon: add command to dump OPAL msglog
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, stewart@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/9/16, Andrew Donnellan <andrew.donnellan@au1.ibm.com> wrote:
> Add the 'do' command to dump the OPAL msglog in xmon.
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

I think it would be better to create system-specific files under
 powerpc/xmon/ directory, in this case something like xmon_powernv.c.

There are some many macros there.

Current code already looks very ugly, look at the cell-specific spu* stuff
for example.

> ---
>  arch/powerpc/xmon/xmon.c | 60
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 07a8508..48b75ae 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -47,6 +47,11 @@
>  #include <asm/debug.h>
>  #include <asm/hw_breakpoint.h>
>
> +#ifdef CONFIG_PPC_POWERNV
> +#include <asm/opal.h>
> +#include <asm/firmware.h>
> +#endif
> +
>  #ifdef CONFIG_PPC64
>  #include <asm/hvcall.h>
>  #include <asm/paca.h>
> @@ -119,6 +124,11 @@ static void dump(void);
>  static void prdump(unsigned long, long);
>  static int ppc_inst_dump(unsigned long, long, int);
>  static void dump_log_buf(void);
> +
> +#ifdef CONFIG_PPC_POWERNV
> +static void dump_opal_msglog(void);
> +#endif
> +
>  static void backtrace(struct pt_regs *);
>  static void excprint(struct pt_regs *);
>  static void prregs(struct pt_regs *);
> @@ -202,6 +212,10 @@ Commands:\n\
>    df	dump float values\n\
>    dd	dump double values\n\
>    dl    dump the kernel log buffer\n"
> +#ifdef CONFIG_PPC_POWERNV
> +  "\
> +  do    dump the OPAL message log\n"
> +#endif
>  #ifdef CONFIG_PPC64
>    "\
>    dp[#]	dump paca for current cpu, or cpu #\n\
> @@ -2253,6 +2267,12 @@ dump(void)
>  		last_cmd = "di\n";
>  	} else if (c == 'l') {
>  		dump_log_buf();
> +	} else if (c == 'o') {
> +#ifdef CONFIG_PPC_POWERNV
> +		dump_opal_msglog();
> +#else
> +		printf("Machine is not running OPAL firmware.\n");
> +#endif
>  	} else if (c == 'r') {
>  		scanhex(&ndump);
>  		if (ndump == 0)
> @@ -2395,6 +2415,46 @@ dump_log_buf(void)
>  	catch_memory_errors = 0;
>  }
>
> +#ifdef CONFIG_PPC_POWERNV
> +void
> +dump_opal_msglog(void)
> +{
> +	unsigned char buf[128];
> +	ssize_t res;
> +	loff_t pos = 0;
> +
> +	if (!firmware_has_feature(FW_FEATURE_OPAL)) {
> +		printf("Machine is not running OPAL firmware.\n");
> +		return;
> +	}
> +
> +	if (setjmp(bus_error_jmp) != 0) {
> +		printf("Error dumping OPAL msglog!\n");
> +		return;
> +	}
> +
> +	catch_memory_errors = 1;
> +	sync();
> +
> +	xmon_start_pagination();
> +	while ((res = opal_msglog_copy(buf, pos, sizeof(buf) - 1))) {
> +		if (res < 0) {
> +			printf("Error dumping OPAL msglog! Error: %zd\n", res);
> +			break;
> +		}
> +		buf[res] = '\0';
> +		printf("%s", buf);
> +		pos += res;
> +	}
> +	xmon_end_pagination();
> +
> +	sync();
> +	/* wait a little while to see if we get a machine check */
> +	__delay(200);
> +	catch_memory_errors = 0;
> +}
> +#endif
> +
>  /*
>   * Memory operations - move, set, print differences
>   */
> --
> Andrew Donnellan              Software Engineer, OzLabs
> andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
> +61 2 6201 8874 (work)        IBM Australia Limited
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
