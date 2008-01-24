Return-Path: <joe@perches.com>
Received: from mail.perches.com (136-022.dsl.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 59DD8DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 11:57:54 +1100 (EST)
Subject: Re: [PATCH][ppc] logical/bitand typo in powerpc/boot/4xx.c
From: Joe Perches <joe@perches.com>
To: Roel Kluin <12o3l@tiscali.nl>
In-Reply-To: <4797D968.1030101@tiscali.nl>
References: <4797C1AD.3040307@tiscali.nl>
	<1201129527.4988.69.camel@localhost>  <4797D968.1030101@tiscali.nl>
Content-Type: text/plain
Date: Wed, 23 Jan 2008 16:39:36 -0800
Message-Id: <1201135176.4988.80.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-01-24 at 01:18 +0100, Roel Kluin wrote:
> when you use git-grep -n "\(&&\|||\)${s}0x\([A-Z0-9]*\|[a-z0-9]*\)",
> (with s="[[:space:]]*") there will be false positives []
> so i'd propose to change that to
> +# Check for bitwise tests written as boolean
> +		if ($line =~ /(?:(?:\(|\&\&|\|\|)\s*0[xX]\s*(?:&&|\|\|)|
> +				(?:\&\&|\|\|)\s*0[xX]\s*(?:\)|&&|\|\|))/) {
> +			WARN("boolean test with hexadecimal, perhaps just 1 \& or \|?\n" . $herecurr);
> +		}
> +

All 13 false positives are "hex_constant logical_test variable".
I think that Linus would say that they are all poor style.

Still, fine by me.  cheers, Joe
