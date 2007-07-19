Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 86BFFDDFB8
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 08:16:30 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so840170wag
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 15:16:29 -0700 (PDT)
Message-ID: <fa686aa40707191516s2a468cf9ka07d1f4369ac4b0e@mail.gmail.com>
Date: Thu, 19 Jul 2007 16:16:29 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Geoff Levand" <geoffrey.levand@am.sony.com>
Subject: Re: PS3: Fix build with 32-bit toolchains
In-Reply-To: <469FDBDC.5030700@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <fa686aa40707191249r1e73f6f7s7f2aa4502919e98a@mail.gmail.com>
	<469FDBDC.5030700@am.sony.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/19/07, Geoff Levand <geoffrey.levand@am.sony.com> wrote:
> The PS3 bootwrapper files use instructions only available on
> 64-bit CPUs.  Add the code generation directive '.machine "ppc64"'
> for toolchains configured for 32-bit CPUs.
>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> Paul,
>
> Please apply for 2.6.23-rc1.
>
>  arch/powerpc/boot/ps3-head.S   |    2 ++
>  arch/powerpc/boot/ps3-hvcall.S |    2 ++
>  2 files changed, 4 insertions(+)
>
> --- a/arch/powerpc/boot/ps3-head.S
> +++ b/arch/powerpc/boot/ps3-head.S
> @@ -20,6 +20,8 @@
>
>  #include "ppc_asm.h"
>
> +       .machine "ppc64"
> +
>         .text
>
>  /*
> --- a/arch/powerpc/boot/ps3-hvcall.S
> +++ b/arch/powerpc/boot/ps3-hvcall.S
> @@ -20,6 +20,8 @@
>
>  #include "ppc_asm.h"
>
> +       .machine "ppc64"
> +
>  /*
>   * The PS3 hypervisor uses a 64 bit "C" language calling convention.
>   * The routines here marshal arguments between the 32 bit wrapper
>
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
