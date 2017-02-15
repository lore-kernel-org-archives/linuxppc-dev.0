Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNsgn3my7zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 08:22:29 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1FLEQIZ122441
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 16:22:27 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28mstgdbg6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 16:22:27 -0500
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 19:22:24 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 7633E352005F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 16:21:48 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1FLMLcr34537656
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 19:22:21 -0200
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1FLMKqd021115
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 19:22:21 -0200
Subject: Re: [PATCH] powerpc/xmon: Fix an unexpected xmon onoff state change
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <1487144990-5969-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2017 19:22:16 -0200
MIME-Version: 1.0
In-Reply-To: <1487144990-5969-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <e09792c7-585f-783f-7924-19eb4c8af871@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/02/2017 05:49, Pan Xinhui wrote:
> Once xmon is triggered by sysrq-x, it is enabled always afterwards even
> if it is disabled during boot. This will cause a system reset interrut
> fail to dump. So keep xmon in its original state after exit.
> 
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

Patch is fine - minor typo: interrut => interrupt

Feel free to add my:
Tested-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>

Thanks,


Guilherme

> ---
>  arch/powerpc/xmon/xmon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 9c0e17c..721212f 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -76,6 +76,7 @@ static int xmon_gate;
>  #endif /* CONFIG_SMP */
> 
>  static unsigned long in_xmon __read_mostly = 0;
> +static int xmon_off = 0;
> 
>  static unsigned long adrs;
>  static int size = 1;
> @@ -3250,6 +3251,8 @@ static void sysrq_handle_xmon(int key)
>  	/* ensure xmon is enabled */
>  	xmon_init(1);
>  	debugger(get_irq_regs());
> +	if (xmon_off)
> +		xmon_init(0);
>  }
> 
>  static struct sysrq_key_op sysrq_xmon_op = {
> @@ -3266,7 +3269,7 @@ static int __init setup_xmon_sysrq(void)
>  __initcall(setup_xmon_sysrq);
>  #endif /* CONFIG_MAGIC_SYSRQ */
> 
> -static int __initdata xmon_early, xmon_off;
> +static int __initdata xmon_early;
> 
>  static int __init early_parse_xmon(char *p)
>  {
> 
