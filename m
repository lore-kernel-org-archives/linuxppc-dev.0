Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 29E4BDDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 23:26:58 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Masakazu Mokuno <mokuno@sm.sony.co.jp>
Subject: Re: [PATCH] PS3: fix the bug the major version part is not compared
References: <20070828211415.C2B5.MOKUNO@sm.sony.co.jp>
Date: Tue, 28 Aug 2007 15:26:50 +0200
In-Reply-To: <20070828211415.C2B5.MOKUNO@sm.sony.co.jp> (Masakazu Mokuno's
	message of "Tue\, 28 Aug 2007 21\:32\:29 +0900")
Message-ID: <jehcmj3i3p.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Masakazu Mokuno <mokuno@sm.sony.co.jp> writes:

> Fix the bug that the major version part of the firmware 
> is not compared.
>
> Signed-off-by: Masakazu Mokuno <mokuno@sm.sony.co.jp>
> CC: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
>  arch/powerpc/platforms/ps3/setup.c |    2 +-
>  include/asm-powerpc/ps3.h          |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --- a/arch/powerpc/platforms/ps3/setup.c
> +++ b/arch/powerpc/platforms/ps3/setup.c
> @@ -54,7 +54,7 @@ void ps3_get_firmware_version(union ps3_
>  }
>  EXPORT_SYMBOL_GPL(ps3_get_firmware_version);
>  
> -int ps3_compare_firmware_version(u16 major, u16 minor, u16 rev)
> +s64 ps3_compare_firmware_version(u16 major, u16 minor, u16 rev)
>  {
>  	union ps3_firmware_version x;
>  

Better yet: normalize the return value.

	return (ps3_firmware_version.raw > x.raw) -
               (ps3_firmware_version.raw < x.raw);

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
