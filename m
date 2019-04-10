Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D34C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 20:32:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CDE20830
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 20:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXQu1STQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CDE20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fbRx6JgxzDqMr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 06:32:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::943; helo=mail-ua1-x943.google.com;
 envelope-from=adhemerval.zanella@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="PXQu1STQ"; 
 dkim-atps=neutral
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com
 [IPv6:2607:f8b0:4864:20::943])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fbH11W8wzDqM6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 06:24:25 +1000 (AEST)
Received: by mail-ua1-x943.google.com with SMTP id c6so1252382uan.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 13:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GYgdiYXpWWt6Z2xzjZHtK+FCFWDIPgvuLmf0dKXa+wU=;
 b=PXQu1STQ07ci5zU9ps+vNIw3ru9QeExrFrU0pW19XwPAtt+TR7QNdhtNEps1hn8QU0
 VhhdueTeSpObcn873kE5tSmjgxZNjpZ9VfBy6EwwLAzrK5dK+SeLmfdamFFf2oTp1O8s
 E2r8dF33BJKHTAGFD+kevXtb9VLDPl/gTQ9L5A1GlaAVaOOhyZTlDbqDQ1IozP3vup7I
 VBPCnd5k+M2mhf9x2ZAVCC0ytPKE5EUDWnQOveqIn2iG/V/CrTD98gm5HSFMej0meUkr
 3rGZkxMLM9tEapLUipmGwc2D3T/8LJTlzkSAJLFlDh7IPZoMMHaQduaiPlvt1zVzN07x
 U+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GYgdiYXpWWt6Z2xzjZHtK+FCFWDIPgvuLmf0dKXa+wU=;
 b=etf4xXGqwEq5bN4XOP+icKtVceKgwF8DgcL+O6rjrxvl211U5yu/mf81YaHr00284c
 EVZx8J73nvNt4b2IecRt9bNHPEm9LNwqIzlj646LLoUViav5LBaWiCmZqRQUUSNsu3jI
 wafthIXLO7V8eCymUTTdxc1nuevA+/7urafhCA/7GQV+CNE0lnsX16TFeRLkyZUtE61V
 ncL8QdB2zJ5/j8otm5yzX6vtQzYMozQQB2s8wEU1CsJ5ff8ccKWwDX4ssZMwgapPmovS
 TFphX6Zmx4a5mPIvCJSBxF+zFjVs/QKzUIhh2XsTRN/uoDqxacx6hvIju8V339q9nYcm
 8qRA==
X-Gm-Message-State: APjAAAVVOnOrLKopqzSOZTb7VqWJ7VjJIMtwu9T6Esly+XwnU1dNNm0i
 1sz1r5dGHIijtLD4pKXxI+BsSmmv6i0=
X-Google-Smtp-Source: APXvYqzGKeGZ1qg4MRF6+5yZMtr4IVeIgBYZZMsNP73RumnuNcedlID5dVUIEnFbx85RnBflSbeXaA==
X-Received: by 2002:ab0:714a:: with SMTP id k10mr3715030uao.82.1554927859878; 
 Wed, 10 Apr 2019 13:24:19 -0700 (PDT)
Received: from [192.168.1.132] ([177.194.125.152])
 by smtp.googlemail.com with ESMTPSA id j42sm13138963uag.17.2019.04.10.13.24.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Apr 2019 13:24:19 -0700 (PDT)
To: Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org
References: <875zrnlakd.fsf@oldenburg2.str.redhat.com>
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=adhemerval.zanella@linaro.org; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] Linux: Define struct termios2 in <termios.h> under
 _GNU_SOURCE [BZ #10339]
Message-ID: <284e9c76-2411-b8f4-c4bc-c25c60c04cf7@linaro.org>
Date: Wed, 10 Apr 2019 17:24:17 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <875zrnlakd.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, hpa@zytor.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 09/04/2019 07:47, Florian Weimer wrote:
> struct termios2 is required for setting arbitrary baud rates on serial
> ports.  <sys/ioctl.h> and <linux/termios.h> have conflicting
> definitions in the existing termios definitions, which means that it
> is currently very difficult to use TCGETS2/TCSETS2 and struct termios2
> with glibc.  Providing a definition within glibc resolves this problem.
> 
> This does not completely address bug 10339, but it at least exposes
> the current kernel functionality in this area.
> 
> Support for struct termios2 is architecture-specific in the kernel.
> Support on alpha was only added in Linux 4.20.  POWER support is
> currently missing.  The expectation is that the kernel will eventually
> use the generic UAPI definition for struct termios2.

I still think the better strategy, from both BZ#10339 and recent thread
discussion about the issue on libc-alpha, is rather to:

  1. Start to use termios2 ioctl kabi instead of termios1.  The only
     missing spot is alpha pre linux 4.20.

  2. Adjust sparc and mips to add c_ispeed and c_ospeed along with
     compat symbols to use termios1.  This will allow also some cleanup
     to remove _HAVE_STRUCT_TERMIOS_C_{O,I}SPEED.

  3. Use the compat symbols for alpha pre-4.20.

  4. With termios Linux ABI being essentially the same for all supported
     architectures (with support for c_ospeed and c_ispeed) we can move 
     forward to adapt the current cfgetospeed, cfgetispeed, cfsetospeed,
     cfsetispeed to work with arbitrary values.

     The POSIX and Linux extended BXX values will need to be handled 
     exceptionally.  It means their integers values will be reserved and
     mapped to the termios2 values.  The code resulting code for cfsetospeed,
     for instance, would be:

     ---
     static inline speed_t
     c_ispeed (tcflag_t c_cflag)
     {
       return (c_cflag >> IBSHIFT) & CBAUD;
     }

     /*
      * The top four bits in speed_t are reserved for future use, and *currently*
      * the equivalent values are the only valid baud_t values.
      */
     static inline bool         
     invalid_speed (speed_t x)
     {
       return x > 0x0fffffff;
     } 

     /* Set the output baud rate stored in *TERMIOS_P to the symbol SPEED */
     int
     cfsetospeed (struct termios *termios_p, speed_t speed)
     {
       if (invalid_speed (speed))
         {
           __set_errno (EINVAL); 
           return -1;
         }

       termios_p->c_ospeed = speed_kernel_from_user (speed);
       if ( c_ispeed (termios_p->c_cflag) == B0 )
         termios_p->c_ispeed = termios_p->c_ospeed;
  
       if ( (speed & ~CBAUD) != 0 || speed > _MAX_BAUD )
         speed = BOTHER;

       /*
        * Don't set the input flags here; the B0 in c_cflag indicates that
        * the input speed is tied to the output speed.
        */
       termios_p->c_cflag = (termios_p->c_cflag & ~CBAUD) | speed;
       return 0;
     } 
     ---

This allows us to adjust the baud rates to non-standard values using termios
interfaces without to resorting to add new headers and use a different API
(ioctl).

As Peter Anvin has indicated, he create a POC [1] with the aforementioned
new interfaces.  It has not been rebased against master, more specially against
my termios refactor to simplify the multiple architecture header definitions,
but I intend to use as a base.

> 
> 2019-04-09  Florian Weimer  <fweimer@redhat.com>
> 
> 	[BZ #10339]
> 	Linux: Define struct termios2 in <termios.h> under _GNU_SOURCE.
> 	* sysdeps/unix/sysv/linux/Makefile [$(subdir) == termios] (tests):
> 	Add tst-termios2.
> 	* sysdeps/unix/sysv/linux/tst-termios2.c: New file.
> 	* sysdeps/unix/sysv/linux/bits/termios2-struct.h: Likewise.
> 	* sysdeps/unix/sysv/linux/bits/termios.h [__USE_GNU]: Include it.
> 	* sysdeps/unix/sysv/linux/alpha/bits/termios2-struct.h: New file.
> 	* sysdeps/unix/sysv/linux/sparc/bits/termios2-struct.h: Likewise.
> 
> diff --git a/NEWS b/NEWS
> index b58e2469d4..5e6ecb9c7d 100644
> --- a/NEWS
> +++ b/NEWS
> @@ -18,6 +18,9 @@ Major new features:
>  
>  * On Linux, the gettid function has been added.
>  
> +* On Linux, <termios.h> now provides a definition of struct termios2 with
> +  the _GNU_SOURCE feature test macro.
> +
>  * Minguo (Republic of China) calendar support has been added as an
>    alternative calendar for the following locales: zh_TW, cmn_TW, hak_TW,
>    nan_TW, lzh_TW.
> diff --git a/sysdeps/unix/sysv/linux/Makefile b/sysdeps/unix/sysv/linux/Makefile
> index 52ac6ad484..4cb5e4f0d2 100644
> --- a/sysdeps/unix/sysv/linux/Makefile
> +++ b/sysdeps/unix/sysv/linux/Makefile
> @@ -156,6 +156,7 @@ endif
>  
>  ifeq ($(subdir),termios)
>  sysdep_headers += termio.h
> +tests += tst-termios2
>  endif
>  
>  ifeq ($(subdir),posix)
> diff --git a/sysdeps/unix/sysv/linux/alpha/bits/termios2-struct.h b/sysdeps/unix/sysv/linux/alpha/bits/termios2-struct.h
> new file mode 100644
> index 0000000000..5f09445e23
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/alpha/bits/termios2-struct.h
> @@ -0,0 +1,33 @@
> +/* struct termios2 definition.  Linux/alpha version.
> +   Copyright (C) 2019 Free Software Foundation, Inc.
> +   This file is part of the GNU C Library.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Lesser General Public
> +   License as published by the Free Software Foundation; either
> +   version 2.1 of the License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Lesser General Public License for more details.
> +
> +   You should have received a copy of the GNU Lesser General Public
> +   License along with the GNU C Library.  If not, see
> +   <http://www.gnu.org/licenses/>.  */
> +
> +#ifndef _TERMIOS_H
> +# error "Never include <bits/termios2-struct.h> directly; use <termios.h> instead."
> +#endif
> +
> +struct termios2
> +{
> +  tcflag_t c_iflag;
> +  tcflag_t c_oflag;
> +  tcflag_t c_cflag;
> +  tcflag_t c_lflag;
> +  cc_t c_cc[NCCS];
> +  cc_t c_line;
> +  speed_t c_ispeed;
> +  speed_t c_ospeed;
> +};
> diff --git a/sysdeps/unix/sysv/linux/bits/termios.h b/sysdeps/unix/sysv/linux/bits/termios.h
> index 997231cd03..45ac7affdf 100644
> --- a/sysdeps/unix/sysv/linux/bits/termios.h
> +++ b/sysdeps/unix/sysv/linux/bits/termios.h
> @@ -25,6 +25,10 @@ typedef unsigned int	speed_t;
>  typedef unsigned int	tcflag_t;
>  
>  #include <bits/termios-struct.h>
> +#ifdef __USE_GNU
> +# include <bits/termios2-struct.h>
> +#endif
> +
>  #include <bits/termios-c_cc.h>
>  #include <bits/termios-c_iflag.h>
>  #include <bits/termios-c_oflag.h>
> diff --git a/sysdeps/unix/sysv/linux/bits/termios2-struct.h b/sysdeps/unix/sysv/linux/bits/termios2-struct.h
> new file mode 100644
> index 0000000000..5a48e45ef3
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/bits/termios2-struct.h
> @@ -0,0 +1,33 @@
> +/* struct termios2 definition.  Linux/generic version.
> +   Copyright (C) 2019 Free Software Foundation, Inc.
> +   This file is part of the GNU C Library.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Lesser General Public
> +   License as published by the Free Software Foundation; either
> +   version 2.1 of the License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Lesser General Public License for more details.
> +
> +   You should have received a copy of the GNU Lesser General Public
> +   License along with the GNU C Library.  If not, see
> +   <http://www.gnu.org/licenses/>.  */
> +
> +#ifndef _TERMIOS_H
> +# error "Never include <bits/termios2-struct.h> directly; use <termios.h> instead."
> +#endif
> +
> +struct termios2
> +{
> +  tcflag_t c_iflag;
> +  tcflag_t c_oflag;
> +  tcflag_t c_cflag;
> +  tcflag_t c_lflag;
> +  cc_t c_line;
> +  cc_t c_cc[NCCS];
> +  speed_t c_ispeed;
> +  speed_t c_ospeed;
> +};
> diff --git a/sysdeps/unix/sysv/linux/sparc/bits/termios2-struct.h b/sysdeps/unix/sysv/linux/sparc/bits/termios2-struct.h
> new file mode 100644
> index 0000000000..7c889e575c
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/sparc/bits/termios2-struct.h
> @@ -0,0 +1,33 @@
> +/* struct termios2 definition.  Linux/sparc version.
> +   Copyright (C) 2019 Free Software Foundation, Inc.
> +   This file is part of the GNU C Library.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Lesser General Public
> +   License as published by the Free Software Foundation; either
> +   version 2.1 of the License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Lesser General Public License for more details.
> +
> +   You should have received a copy of the GNU Lesser General Public
> +   License along with the GNU C Library.  If not, see
> +   <http://www.gnu.org/licenses/>.  */
> +
> +#ifndef _TERMIOS_H
> +# error "Never include <bits/termios2-struct.h> directly; use <termios.h> instead."
> +#endif
> +
> +struct termios2
> +{
> +  tcflag_t c_iflag;
> +  tcflag_t c_oflag;
> +  tcflag_t c_cflag;
> +  tcflag_t c_lflag;
> +  cc_t c_line;
> +  cc_t c_cc[NCCS + 2];
> +  speed_t c_ispeed;
> +  speed_t c_ospeed;
> +};
> diff --git a/sysdeps/unix/sysv/linux/tst-termios2.c b/sysdeps/unix/sysv/linux/tst-termios2.c
> new file mode 100644
> index 0000000000..82326a1288
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/tst-termios2.c
> @@ -0,0 +1,48 @@
> +/* Minimal test of struct termios2 definition.
> +   Copyright (C) 2019 Free Software Foundation, Inc.
> +   This file is part of the GNU C Library.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Lesser General Public
> +   License as published by the Free Software Foundation; either
> +   version 2.1 of the License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Lesser General Public License for more details.
> +
> +   You should have received a copy of the GNU Lesser General Public
> +   License along with the GNU C Library.  If not, see
> +   <http://www.gnu.org/licenses/>.  */
> +
> +#include <termios.h>
> +#include <sys/ioctl.h>
> +
> +/* This function is never executed, but must be compiled successfully.
> +   Accessing serial ports in the test suite is problematic because
> +   they likely correspond with low-level system functionality.  */
> +void
> +not_executed (int fd)
> +{
> +  /* Avoid a compilation failure if TCGETS2, TCSETS2 are not
> +     defined.  */
> +#if defined (TCGETS2) && defined (TCSETS2)
> +  struct termios2 ti;
> +  ioctl (fd, TCGETS2, &ti);
> +  ioctl (fd, TCSETS2, &ti);
> +#endif
> +}
> +
> +static int
> +do_test (void)
> +{
> +  /* Fail at run time if TCGETS2 or TCSETS2 is not defined.  */
> +#if defined (TCGETS2) && defined (TCSETS2)
> +  return 0;
> +#else
> +  return 1;
> +#endif
> +}
> +
> +#include <support/test-driver.c>
> 
