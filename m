Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssnWh4CkLzDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 15:41:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Commit 1b7898ee276b "powerpc/boot: Use the pre-boot decompression
 API" breaks boot
In-Reply-To: <80c9c42c-45d3-9f24-b3e1-5a5042686b1b@gmail.com>
References: <8db8ecac-4022-7df9-4e81-3d490c50821d@gmail.com>
 <CAOSf1CFVX8j+kyp3SRhRz_gyPiQ3R9x=_nJyq9fr31NyGi3hhg@mail.gmail.com>
 <c19153b9-7554-0280-6d97-750c9e62b3be@gmail.com>
 <80c9c42c-45d3-9f24-b3e1-5a5042686b1b@gmail.com>
Date: Mon, 10 Oct 2016 15:41:14 +1100
Message-ID: <877f9g7r4l.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Am 07.10.2016 um 21:26 schrieb Heiner Kallweit:
>> Am 07.10.2016 um 07:51 schrieb Oliver O'Halloran:
>>> Hi, Heiner
>>>
>>> Could you send me a copy of the kernel .config (or which defconfig)
>>> that you're using, the name of the HW platform that you're using and
>>> if possible the kernel image itself?
>>>
>>> Thanks,
>>> Oliver
>>>
>> Thanks for the quick reply. Attached are .config and cuImage.
>> HW is a TP-Link TL-WDR4900 WiFi router (P1014-based) running OpenWRT.
>> 
> After further checking I think I found the issue. The old gunzip code
> handled uncompressed data transparently whilst the new one bails out
> if it doesn't find a proper gzip header.
> And in my case the actual kernel image is uncompressed.
> With the following patch the system boots fine again (at least for me).

Thanks for testing and tracking it down.

I wonder why the actual image is uncompressed? Or alternately why do we
tell uboot the image is compressed when it's not?

cheers
