Return-Path: <avorontsov@ru.mvista.com>
Date: Fri, 30 May 2008 16:28:13 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/4] [POWERPC] 85xx: support for the TQM8548 module
	using the big Flash
Message-ID: <20080530122813.GA13407@polina.dev.rtsoft.ru>
References: <1212130188-28835-1-git-send-email-wg@grandegger.com>
	<1212130188-28835-2-git-send-email-wg@grandegger.com>
	<1212130188-28835-3-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1212130188-28835-3-git-send-email-wg@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 30, 2008 at 08:49:46AM +0200, Wolfgang Grandegger wrote:
> Some TQM85xx boards could be equipped with up to 1 GiB (NOR) flash
> memory and therefore a modified memory map is required and setup by
> the board loader. This patch adds an appropriate DTS file.
> 
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
[...]
> +/* NAND support must be enabled in U-Boot before Linux can use it

nand/fsl_upm.c can detect this in run-time. That is, if BRx/ORx aren't
configured, fsl_upm_find() will return ENODEV/ENOENT/EINVAL, depending
on what exactly is mis-configured.

> +		upm@3,0 {
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			compatible = "fsl,upm-nand";
> +			reg = <3 0x0 0x800>;
> +			fsl,upm-addr-offset = <0x10>;
> +			fsl,upm-cmd-offset = <0x08>;
> +			chip-delay = <25>; // in micro-seconds
> +
> +			nand@0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				partition@0 {
> +					    label = "fs";
> +					    reg = <0x00000000 0x01000000>;
> +				};
> +			};
> +		};
> +*/
> +	};

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
