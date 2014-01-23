Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0237.outbound.protection.outlook.com [207.46.163.237])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2CF2E2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2014 11:44:34 +1100 (EST)
Message-ID: <1390437863.24905.549.camel@snotra.buserror.net>
Subject: Re: [PATCH] clk: corenet: Update the clock bindings
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian <Yuantian.Tang@freescale.com>
Date: Wed, 22 Jan 2014 18:44:23 -0600
In-Reply-To: <1390269732-22798-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1390269732-22798-1-git-send-email-Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: b07421@freescale.com, b32579@freescale.com, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-01-21 at 10:02 +0800, Tang Yuantian wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
> 
> Main changs include:
> 	- Clarified the clock nodes' version number
> 	- Fixed a issue in example
> 
> Singed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
>  Documentation/devicetree/bindings/clock/corenet-clock.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/corenet-clock.txt b/Documentation/devicetree/bindings/clock/corenet-clock.txt
> index 24711af..d6cadef 100644
> --- a/Documentation/devicetree/bindings/clock/corenet-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/corenet-clock.txt
> @@ -54,6 +54,8 @@ Required properties:
>  		It takes parent's clock-frequency as its clock.
>  	* "fsl,qoriq-sysclk-2.0": for input system clock (v2.0).
>  		It takes parent's clock-frequency as its clock.
> +	Note: v1.0 and v2.0 are clock version which should align to
> +	clockgen node's they belong to which is chassis version.

Instead, how about a note like this near the top of the file:

All references to "1.0" and "2.0" refer to the QorIQ chassis version to
which the chip complies.

Chassis Version		Example Chips
---------------		-------------
1.0			p4080, p5020, p5040
2.0			t4240, b4860, t1040


BTW, this binding and the associated driver really should be called
"qoriq-clock", not "corenet-clock".  This would match the compatible
string, and it doesn't really have much to do with corenet (which is
part of the QorIQ chassis v1 and v2, but not *this* part).  Do you know
if the chassis v3 clock interface will be similar enough to share a
driver?

-Scott
