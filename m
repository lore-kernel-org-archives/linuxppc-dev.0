Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7h941PMxzDqFb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 11:28:55 +1000 (AEST)
Message-ID: <1492651720.25766.139.camel@kernel.crashing.org>
Subject: Re: [bug report] powerpc/xive: Native exploitation of the XIVE
 interrupt controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 20 Apr 2017 11:28:40 +1000
In-Reply-To: <20170420012031.k4vx75eqrm2aborg@mwanda>
References: <20170420012031.k4vx75eqrm2aborg@mwanda>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-20 at 04:20 +0300, Dan Carpenter wrote:
> Hello Benjamin Herrenschmidt,
> 
> The patch 243e25112d06: "powerpc/xive: Native exploitation of the
> XIVE interrupt controller" from Apr 5, 2017, leads to the following
> static checker warning:
> 
> 	arch/powerpc/sysdev/xive/native.c:184
> __xive_native_disable_queue()
> 	info: ignoring unreachable code.
> 
> arch/powerpc/sysdev/xive/native.c
>    176  static void __xive_native_disable_queue(u32 vp_id, struct
> xive_q *q, u8 prio)
>    177  {
>    178          s64 rc;
>    179  
>    180          /* Disable the queue in HW */
>    181          for (;;) {
>    182                  rc = opal_xive_set_queue_info(vp_id, prio, 0,
> 0, 0);
>    183                          break;
> 
> This should be "if (!rc) break;"

Thanks, for some reason that line got accidentally dropped... oops.

> 
>    184                  msleep(1);
>    185          }
>    186          if (rc)
> 
> But we need some kind of timeout to ever print this error message.
> 
>    187                  pr_err("Error %lld disabling queue for prio
> %d\n", rc, prio);
>    188  }
> 
> regards,
> dan carpenter
