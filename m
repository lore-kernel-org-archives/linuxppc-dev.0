Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E57C32C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 10:02:04 +1100 (EST)
Message-ID: <1381964508.17841.65.camel@pasglop>
Subject: Re: Perf not resolving all symbols, showing 0x7ffffxxx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martin Hicks <mort@bork.org>
Date: Wed, 16 Oct 2013 18:01:48 -0500
In-Reply-To: <CAJUS3Xk6jVHWvWugLGD0LNWgw0+XZeP6z+=U4Xa6_GTGNvObBQ@mail.gmail.com>
References: <CAJUS3Xn4tHKvDK8tzLw09+zsEAJHEScV2DbZhH9KkYL-5iCmUA@mail.gmail.com>
 <CAJUS3X=LVHDMa+CTFS=O=F=DfU1=0cgcNzn-mEvXGaDXEZ+CBA@mail.gmail.com>
 <1381851009.17841.14.camel@pasglop>
 <CAJUS3XmN2WNJ1cnorb5vfas7mB6tdNLxuupFja=u_wYS=cxmdQ@mail.gmail.com>
 <1381866837.17841.21.camel@pasglop>
 <1381868527.7979.713.camel@snotra.buserror.net>
 <1381869590.17841.23.camel@pasglop>
 <CAJUS3Xm6-Mojvu6WkZNT+31oDazcx5HCr3n0asNqv3+uFbO0JQ@mail.gmail.com>
 <1381948928.17841.38.camel@pasglop>
 <CAJUS3Xk6jVHWvWugLGD0LNWgw0+XZeP6z+=U4Xa6_GTGNvObBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-10-16 at 17:16 -0400, Martin Hicks wrote:

> That does fix the problem.  v3.11 with the following:
> 
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index eeae308..e91cf67 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -124,7 +124,7 @@ static inline void power_pmu_bhrb_read(struct
> cpu_hw_events *cpuhw) {}
> 
>  static bool regs_use_siar(struct pt_regs *regs)
>  {
> -       return !!regs->result;
> +       return 0; //!!regs->result;
>  }

Ok, we probably need that function to do that on machines with no
backend :-) Either that or properly clear regs->result always.


I've had a quick look through perf and I admit I'm not sure of all the
ways perf ends up populating "regs" here and how many holes there is
in that scheme :-)

Anton? How do you know for sure regs is always be cooked by your stuff
(for regs->result) ?

Ben.
