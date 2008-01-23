Return-Path: <joe@perches.com>
Received: from mail.perches.com (136-022.dsl.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id C26BEDDDF2
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 10:34:26 +1100 (EST)
Subject: Re: [PATCH][ppc] logical/bitand typo in powerpc/boot/4xx.c
From: Joe Perches <joe@perches.com>
To: Roel Kluin <12o3l@tiscali.nl>, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <4797C1AD.3040307@tiscali.nl>
References: <4797C1AD.3040307@tiscali.nl>
Content-Type: text/plain
Date: Wed, 23 Jan 2008 15:05:27 -0800
Message-Id: <1201129527.4988.69.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-01-23 at 23:37 +0100, Roel Kluin wrote:
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> ---
> diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
> index ebf9e21..dcfb459 100644
> --- a/arch/powerpc/boot/4xx.c
> +++ b/arch/powerpc/boot/4xx.c
> @@ -104,7 +104,7 @@ void ibm4xx_denali_fixup_memsize(void)
>  	val = DDR_GET_VAL(val, DDR_CS_MAP, DDR_CS_MAP_SHIFT);
>  	cs = 0;
>  	while (val) {
> -		if (val && 0x1)
> +		if (val & 0x1)
>  			cs++;
>  		val = val >> 1;

I think this pattern should be added to checkpatch

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 579f50f..147e573 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1337,6 +1337,11 @@ sub process {
 			}
 		}
 
+# Check for bitwise tests written as boolean
+		if ($line =~ /\&\&\s*0[xX]/) {
+			WARN("boolean test with hexadecimal, perhaps just 1 \&?\n" . $herecurr);
+		}
+
 # if and else should not have general statements after it
 		if ($line =~ /^.\s*(?:}\s*)?else\b(.*)/ &&
 		    $1 !~ /^\s*(?:\sif|{|\\|$)/) {
