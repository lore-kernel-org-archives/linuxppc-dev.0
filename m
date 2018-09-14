Return-Path: <groeck7@gmail.com>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BjFc1bKyzF31F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 03:29:56 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id s7-v6so4725850pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 10:29:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 14 Sep 2018 10:29:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Radu Rendec <radu.rendec@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: watchdog: add mpc8xxx-wdt support
Message-ID: <20180914172953.GF26861@roeck-us.net>
References: <5edda1a360cf7867b98a72a1dfa22db3bd5ed7b4.1536931725.git.christophe.leroy@c-s.fr>
 <e68ed01cdfba5b7610559607a3c706b294a216fc.1536931725.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e68ed01cdfba5b7610559607a3c706b294a216fc.1536931725.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2018 at 01:32:03PM +0000, Christophe Leroy wrote:
> Add description of DT bindings for mpc8xxx-wdt driver which
> handles the CPU watchdog timer on the mpc83xx, mpc86xx and mpc8xx.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  .../devicetree/bindings/watchdog/mpc8xxx-wdt.txt   | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt b/Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
> new file mode 100644
> index 000000000000..1d99e1e4d306
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
> @@ -0,0 +1,25 @@
> +* Freescale mpc8xxx watchdog driver (For 83xx, 86xx and 8xx)
> +
> +Required properties:
> +- compatible: Shall contain one of the following:
> +	"mpc83xx_wdt" for an mpc83xx
> +	"fsl,mpc8610-wdt" for an mpc86xx
> +	"fsl,mpc823-wdt" for an mpc8xx
> +- reg: base physical address and length of the area hosting the
> +       watchdog registers.
> +		On the 83xx, "Watchdog Timer Registers" area:	<0x200 0x100>
> +		On the 86xx, "Watchdog Timer Registers" area:	<0xe4000 0x100>
> +		On the 8xx, "General System Interface Unit" area: <0x0 0x10>
> +

Note for Rob: The above has been implemented for several years.
This is merely to document the current implementation.
Maybe "mpc83xx_wdt" should be deprecated and replaced, but I think
that should be a separate patch.

> +Optional properties:
> +- reg: additionnal physical address and length (4) of location of the

s/additionnal/additional/

> +       Reset Status Register (called RSTRSCR on the mpc86xx)
> +       		On the 83xx, it is located at offset 0x910
> +       		On the 86xx, it is located at offset 0xe0094
> +       		On the 8xx, it is located at offset 0x288
> +
> +Example:
> +		WDT: watchdog@0 {
> +		    compatible = "fsl,mpc823-wdt";
> +		    reg = <0x0 0x10 0x288 0x4>;
> +		};
> -- 
> 2.13.3
> 
