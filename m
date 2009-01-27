Return-Path: <Matteo.Fortini@mta.it>
Received: from dig-mailtc.digitek.int (mail-dgt.mta.it [93.63.228.226])
	by ozlabs.org (Postfix) with ESMTP id 31B08DE03E
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 21:03:56 +1100 (EST)
Message-ID: <497EDC08.4080204@mta.it>
Date: Tue, 27 Jan 2009 11:03:52 +0100
From: Matteo Fortini <matteo.fortini@mta.it>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Booting uncompressed kernel image
References: <497D9BC8.0@mta.it> <20090126223645.791B7832E416@gemini.denx.de>
In-Reply-To: <20090126223645.791B7832E416@gemini.denx.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

You're right,
to be precise, the --no-gzip option was given to the wrapper script, the 
option I gave to mkimage was -C none.

The change in the wrapper script was adding:
case "$platform" in
ubootraw)
    rm -f "$ofile"
    mkimage -A ppc -O linux -T kernel -C none -a 00000000 -e 00000000 \
    $uboot_version -d "$vmz" "$ofile"
    if [ -z "$cacheit" ]; then
    rm -f "$vmz"
    fi
    exit 0
    ;;
esac


and I called wrapper as
./arch/powerpc/boot/wrapper  -c -o arch/powerpc/boot/uImage -p ubootraw 
-C "powerpc-e300c3-linux-gnu-" --no-gzip vmlinux

Anyway, I'll check the solution given by Luotao, thanks!

Regards,
Matteo

Wolfgang Denk ha scritto:
> Dear Matteo Fortini,
>
> In message <497D9BC8.0@mta.it> you wrote:
>   
>> I built an uncompressed uImage using mkimage --no-gzip -C none in the 
>> wrapper scripts.
>>     
>
> Hm... you must be using a funny version of mkimage, then. The cod in
> mainline will bail out on "--no-gzip".
>
> Best regards,
>
> Wolfgang Denk
>
>   
