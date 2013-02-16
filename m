Return-Path: <phileas-fogg@mail.ru>
Received: from smtp40.i.mail.ru (smtp40.i.mail.ru [94.100.177.100])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8CBE32C0040
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2013 04:52:01 +1100 (EST)
Message-ID: <511FD54C.7000808@mail.ru>
Date: Sat, 16 Feb 2013 19:51:56 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Phileas Fogg <phileas-fogg@mail.ru>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
References: <1360365046.495584377@f356.mail.ru>
In-Reply-To: <1360365046.495584377@f356.mail.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Phileas Fogg wrote:
>
> Hi,
>
> i'm using OpenWRT petitboot bootloader on my PS3 to boot FreeBSD loader which is a simple PPC32 ELF file.
> I haven't had any issues with it and OpenWRT based on Linux 3.3.8.
> Recently i built an OpenWRT image with Linux 3.7, i have no issues at all with kexec and any Linux kernels starting with 2.6 but
> FreeBSD loader won't boot and just hangs. The same issue with OpenWRT based on Linux 3.6 kernel.
> So, i started to analyze this problem and found out where it hangs.
>
> It seems that the purgatory code from kexec-tools loops endlessly if SHA256 verification of the loaded segments
> fails.
>
> See
>    http://git.kernel.org/?p=utils/kernel/kexec/kexec-tools.git;a=blob_plain;f=purgatory/purgatory.c;hb=566ca8a12145196b00ad37939cfd58a97f96ba89
>
> Because the function _verify_sha256_digest fails, the function _purgatory_ loops endlessly.
> This problem occurs only with Linux 3.6 or Linux 3.7 and FreeBSD loader.
> I killed the endless loop and could boot the FreeBSD loader on Linux 3.7 too.
>
> Any idea what could cause this problem ?
>
> Thanks.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

Found another strange problem. I'm not able to boot FreeBSD LiveCD with
OpenWRT + Linux 3.8 (or Linux 3.7), the same CD which boots on
OpenWRT + Linux 3.3.8.

The LiveCD just panics and the PS3 console shuts down. Very odd.
The problem is probably connected with the kexec issue i'm having
and happens only with the recent Linux kernels.

regards
