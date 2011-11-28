Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id CD2B8B6F7E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 23:12:42 +1100 (EST)
Received: by vcbfl15 with SMTP id fl15so4983796vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 04:12:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111127173748.9f235741.acrux_it@libero.it>
References: <20111127173748.9f235741.acrux_it@libero.it>
Date: Mon, 28 Nov 2011 07:12:38 -0500
Message-ID: <CA+5PVA592G1RVdj_C+NMFQ8nHx=0-eaF9Hn3NZ8VabpCTQGi1Q@mail.gmail.com>
Subject: Re: sam460ex, sm501 incorrect device id with kernel >=linux-2.6.39
From: Josh Boyer <jwboyer@gmail.com>
To: acrux <acrux_it@libero.it>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 27, 2011 at 11:37 AM, acrux <acrux_it@libero.it> wrote:
>
> Acube Sam460ex has SM502 as onboard video.
> I got this with any kernel newer than 2.6.38.x thus the framebuffer is lost too:
>
> root@sam4x0:~# diff dmesg-2.6.38.8 dmesg-2.6.39.4
> 1,2c1,3
> < Using PowerPC 44x Platform machine description
> < Linux version 2.6.38.8-Sam460ex (root@sam4x0) (gcc version 4.5.3 (CRUX PPC) ) #1 Fri Nov 11 22:07:53 CET 2011
> ---
>> Using Canyonlands machine description
>> Initializing cgroup subsys cpu

You seem to have switched from using the generic PowerPC 44x platform,
to using a Canyonlands kernel and/or DTB.  Not sure why that is, but
it's probably not helping your issues at all.

>> Linux version 2.6.39.4-Sam460ex (root@sam4x0) (gcc version 4.5.3 (CRUX PPC) ) #1 Fri Nov 11 19:06:02 CET 2011
> 17c18
> [cut]
> 161,179c165,167
> < sm501 0001:00:06.0: SM501 At f5480000: Version 050100c0, 64 Mb, IRQ 19

> ---
>> sm501 0001:00:06.0: incorrect device id c0000105

Something is reading the device ID in the wrong endian (and probably
everything else).

josh
