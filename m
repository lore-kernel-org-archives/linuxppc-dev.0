Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id E6D6FDDDB6
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 06:23:43 +1100 (EST)
Date: Tue, 17 Mar 2009 22:23:41 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wolfgang Grandegegr <wg@grandegger.com>
Subject: Re: [PATCH 4/4] powerpc/85xx: TQM8548: Update DTS file for
	multi-chip support
Message-ID: <20090317192341.GB4287@oksana.dev.rtsoft.ru>
References: <1237281143-8768-1-git-send-email-wg@grandegger.com>
	<1237281143-8768-2-git-send-email-wg@grandegger.com>
	<1237281143-8768-3-git-send-email-wg@grandegger.com>
	<1237281143-8768-4-git-send-email-wg@grandegger.com>
	<1237281143-8768-5-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1237281143-8768-5-git-send-email-wg@grandegger.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 17, 2009 at 10:12:22AM +0100, Wolfgang Grandegegr wrote:
> From: Wolfgang Grandegger <wg@grandegger.com>
> 
> This patch adds multi-chip support for the Micron MT29F8G08FAB NAND
> flash memory on the TQM8548 modules.
> 
> This patch should go through the powerpc/85xx channel.
> 
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
>  arch/powerpc/boot/dts/tqm8548.dts |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
> index 81d3fbb..e5c3c67 100644
> --- a/arch/powerpc/boot/dts/tqm8548.dts
> +++ b/arch/powerpc/boot/dts/tqm8548.dts
> @@ -389,6 +389,11 @@
>  			reg = <3 0x0 0x800>;
>  			fsl,upm-addr-offset = <0x10>;
>  			fsl,upm-cmd-offset = <0x08>;
> +			wait-flags = <0x05>;

Should be at least fsl,upm-wait-flags. (And the flags should
be documented in dts-bindings ;-).

> +			/* Multi-chip device */
> +			fsl,upm-mar-chip-offset = <0x200>;
> +			max-chips = <2>;

num-chips would be more appropriate, no?

> +			chip-offset = <0x200>;

I believe this is from some old code...


Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
