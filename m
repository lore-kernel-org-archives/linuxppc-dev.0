Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 813EBB708F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2011 07:05:13 +1100 (EST)
Received: from mail184-ch1 (localhost.localdomain [127.0.0.1])	by
 mail184-ch1-R.bigfish.com (Postfix) with ESMTP id 333701CA050E	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 20:05:00 +0000 (UTC)
Received: from CH1EHSMHS014.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.245])	by mail184-ch1.bigfish.com (Postfix) with ESMTP id
 AA2607A804F	for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 20:04:56
 +0000 (UTC)
Message-ID: <4EB4456F.9020005@freescale.com>
Date: Fri, 4 Nov 2011 15:05:03 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH 5/7] fsl_pmc: update device bindings
References: <1320410207-14537-1-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1320410207-14537-1-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/04/2011 07:36 AM, Zhao Chenhui wrote:
> From: Li Yang <leoli@freescale.com>
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/pmc.txt        |   63 +++++++++++--------
>  1 files changed, 36 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt b/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
> index 07256b7..d84b4f8 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
> @@ -9,22 +9,27 @@ Properties:
>  
>    "fsl,mpc8548-pmc" should be listed for any chip whose PMC is
>    compatible.  "fsl,mpc8536-pmc" should also be listed for any chip
> -  whose PMC is compatible, and implies deep-sleep capability.
> +  whose PMC is compatible, and implies deep-sleep capability and
> +  wake on user defined packet(wakeup on ARP).

Why does the PMC care?  This is an ethernet controller feature, the PMC
is just keeping the wakeup-relevant parts of the ethernet controller
alive (whatever they happen to be).

Do we have any chips that have ethernet controller support for wake on
user-defined packet, but a sleep mode that doesn't let it be used?

BTW, please remove fsl,mpc8536-pmc from the p1023rds device tree -- it
was wrong before (no deep sleep, though it does appear to have jog
mode...), and is even more wrong with this provision (it has a different
ethernet controller).

> +  "fsl,p1022-pmc" should be listed for any chip whose PMC is
> +  compatible, and implies lossless Ethernet capability during sleep.
>  
>    "fsl,mpc8641d-pmc" should be listed for any chip whose PMC is
>    compatible; all statements below that apply to "fsl,mpc8548-pmc" also
>    apply to "fsl,mpc8641d-pmc".
>  
>    Compatibility does not include bit assignments in SCCR/PMCDR/DEVDISR; these
> -  bit assignments are indicated via the sleep specifier in each device's
> -  sleep property.
> +  bit assignments are indicated via the clock nodes.  Device which has a
> +  controllable clock source should have a "clk-handle" property pointing
> +  to the clock node.

Do we have any code to use this?

Normally that shouldn't matter, but we already an unused binding for
this. :-)

Please provide rationale for doing it this way.  Ideally it should
probably use whatever http://devicetree.org/ClockBindings ends up being.

>  - reg: For devices compatible with "fsl,mpc8349-pmc", the first resource
>    is the PMC block, and the second resource is the Clock Configuration
>    block.
>  
> -  For devices compatible with "fsl,mpc8548-pmc", the first resource
> -  is a 32-byte block beginning with DEVDISR.
> +  For devices compatible with "fsl,mpc8548-pmc", the second resource
> +  is a 32-byte block beginning with DEVDISR if supported.

Huh?

-Scott
