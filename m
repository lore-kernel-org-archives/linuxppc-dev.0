Return-Path: <arndbergmann@gmail.com>
Received: from mail-qt0-x22f.google.com (mail-qt0-x22f.google.com
 [IPv6:2607:f8b0:400d:c0d::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40V08M0lJczDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 18:32:50 +1000 (AEST)
Received: by mail-qt0-x22f.google.com with SMTP id h2-v6so4650466qtp.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 01:32:50 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180423081114.1813726-2-arnd@arndb.de>
References: <20180423081114.1813726-1-arnd@arndb.de>
 <20180423081114.1813726-2-arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 23 Apr 2018 10:32:47 +0200
Message-ID: <CAK8P3a1V6QfUE8rZKyUUOmBfNC181mHJF8KiQi1GD=JJ4JfEOA@mail.gmail.com>
Subject: Re: [PATCH 2/5] powerpc: rtas: clean up time handling
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
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

> @@ -307,17 +307,17 @@ static ssize_t ppc_rtas_poweron_write(struct file *file,
>                 const char __user *buf, size_t count, loff_t *ppos)
>  {
>         struct rtc_time tm;
> -       unsigned long nowtime;
> +       time64_t nowtime;
>         int error = parse_number(buf, count, &nowtime);
>         if (error)
>                 return error;
>
>         power_on_time = nowtime; /* save the time */
>
> -       to_tm(nowtime, &tm);
> +       rtc_time64_to_tm(nowtime, 0, &tm);
>

Here was the other obvious typo: I had originally changed this to
'time64_to_tm()', which has slightly different calling conventions to
'rtc_time64_to_tm()', and messed it up when I changed it back
after it turned out I needed to select RTC_LIB anyway.

v2 coming.

        Arnd
