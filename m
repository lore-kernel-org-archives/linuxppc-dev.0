Return-Path: <arndbergmann@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40V03R07zkzF24L
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 18:28:34 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id s2-v6so16722040qti.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 01:28:34 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180423081114.1813726-3-arnd@arndb.de>
References: <20180423081114.1813726-1-arnd@arndb.de>
 <20180423081114.1813726-3-arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 23 Apr 2018 10:28:31 +0200
Message-ID: <CAK8P3a30fo0mviQMgg3OXivbVCkC9vBp2R7NfuLKq=si_O0X_w@mail.gmail.com>
Subject: Re: [PATCH 3/5] powerpc: use time64_t in read_persistent_clock
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 Vitaly Bordug <vitb@kernel.crashing.org>, Geoff Levand <geoff@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 23, 2018 at 10:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> @@ -170,7 +170,6 @@ unsigned long __init maple_get_boot_time(void)
>         request_resource(&ioport_resource, &rtc_iores);
>
>         maple_get_rtc_time(&tm);
> -       return mktime(tm.tm_year+1900, tm.tm_mon+1, tm.tm_mday,
> -                     tm.tm_hour, tm.tm_min, tm.tm_sec);
> +       return rtc_tm_to_time66(&tm);
>  }

No, it's not rtc_tm_to_time66 ;(

I did some build testing over the weekend to make sure I find all the stupid
bugs, but then sent out the version without the two fixes. Please ignore all
five patches, will follow up with v2 that fixes this one and another equally
trivial bug.

       Arnd
