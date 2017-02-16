Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP42T0BwKzDqD2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 16:09:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 gpiccoli@linux.vnet.ibm.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/xmon: Fix an unexpected xmon onoff state change
In-Reply-To: <1487144990-5969-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1487144990-5969-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Date: Thu, 16 Feb 2017 16:09:18 +1100
Message-ID: <87shnek9hd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pan Xinhui <xinhui.pan@linux.vnet.ibm.com> writes:

> Once xmon is triggered by sysrq-x, it is enabled always afterwards even
> if it is disabled during boot. This will cause a system reset interrut
> fail to dump. So keep xmon in its original state after exit.
>
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
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

I don't think this is right.

xmon_off is only true if you boot with xmon=off on the command line.

So if you boot with CONFIG_XMON_DEFAULT=n, and nothing on the command
line, then enter xmon via sysrq, then exit, xmon will still be enabled.

cheers
