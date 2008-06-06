Return-Path: <dgibson@ozlabs.org>
Date: Fri, 6 Jun 2008 13:59:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3 1/4] [POWERPC] 85xx: correct vendor prefix in DTS
	files for TQM85xx modules
Message-ID: <20080606035911.GB6506@yookeroo.seuss>
References: <48481DFE.6030405@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48481DFE.6030405@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 05, 2008 at 07:10:22PM +0200, Wolfgang Grandegger wrote:
> Like for the TQM5200, the vendor prefix "tqc," is now used for all
> TQM85xx modules from TQ-Components GmbH (http://www.tqc.de) in the
> corresponding DTS files.
> 
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
>  arch/powerpc/boot/dts/tqm8540.dts     |    4 ++--
>  arch/powerpc/boot/dts/tqm8541.dts     |    4 ++--
>  arch/powerpc/boot/dts/tqm8555.dts     |    4 ++--
>  arch/powerpc/boot/dts/tqm8560.dts     |    4 ++--
>  arch/powerpc/platforms/85xx/tqm85xx.c |    8 ++++----
>  5 files changed, 12 insertions(+), 12 deletions(-)
> 
> Index: linux-2.6-galak/arch/powerpc/boot/dts/tqm8540.dts
> ===================================================================
> --- linux-2.6-galak.orig/arch/powerpc/boot/dts/tqm8540.dts
> +++ linux-2.6-galak/arch/powerpc/boot/dts/tqm8540.dts
> @@ -12,8 +12,8 @@
>  /dts-v1/;
>  
>  / {
> -	model = "tqm,8540";
> -	compatible = "tqm,8540", "tqm,85xx";
> +	model = "tqc,8540";
> +	compatible = "tqc,8540", "tqc,85xx";

Hrm.  compatible strings with "xx" type wildcards in them should be
avoided.  Keeping them for compatibility with existing code or trees
is fine, but given that you're changing the name anyway, you should
get rid of the 85xx reference.  Either just dropping it, if it's not
actually used, or replacing with a defined name or the specific model
of the earliest board this series is compatible with.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
