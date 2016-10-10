Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x233.google.com (mail-qk0-x233.google.com
 [IPv6:2607:f8b0:400d:c09::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssph53NJlzDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 16:33:41 +1100 (AEDT)
Received: by mail-qk0-x233.google.com with SMTP id o68so90657792qkf.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Oct 2016 22:33:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <877f9g7r4l.fsf@concordia.ellerman.id.au>
References: <8db8ecac-4022-7df9-4e81-3d490c50821d@gmail.com>
 <CAOSf1CFVX8j+kyp3SRhRz_gyPiQ3R9x=_nJyq9fr31NyGi3hhg@mail.gmail.com>
 <c19153b9-7554-0280-6d97-750c9e62b3be@gmail.com>
 <80c9c42c-45d3-9f24-b3e1-5a5042686b1b@gmail.com>
 <877f9g7r4l.fsf@concordia.ellerman.id.au>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Mon, 10 Oct 2016 16:33:38 +1100
Message-ID: <CAOSf1CEa-BRMqedOECJFrg3b9Q_mwJE6A5wR4bYZoL6J2HdP7g@mail.gmail.com>
Subject: Re: Commit 1b7898ee276b "powerpc/boot: Use the pre-boot decompression
 API" breaks boot
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 10, 2016 at 3:41 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Heiner Kallweit <hkallweit1@gmail.com> writes:
>
>> Am 07.10.2016 um 21:26 schrieb Heiner Kallweit:
>>> Am 07.10.2016 um 07:51 schrieb Oliver O'Halloran:
>>>> Hi, Heiner
>>>>
>>>> Could you send me a copy of the kernel .config (or which defconfig)
>>>> that you're using, the name of the HW platform that you're using and
>>>> if possible the kernel image itself?
>>>>
>>>> Thanks,
>>>> Oliver
>>>>
>>> Thanks for the quick reply. Attached are .config and cuImage.
>>> HW is a TP-Link TL-WDR4900 WiFi router (P1014-based) running OpenWRT.
>>>
>> After further checking I think I found the issue. The old gunzip code
>> handled uncompressed data transparently whilst the new one bails out
>> if it doesn't find a proper gzip header.
>> And in my case the actual kernel image is uncompressed.
>> With the following patch the system boots fine again (at least for me).
>
> Thanks for testing and tracking it down.

Yeah thanks for that. I was putting off looking at it until Monday :)

>
> I wonder why the actual image is uncompressed? Or alternately why do we
> tell uboot the image is compressed when it's not?

The uboot payload (wrapper, kernel, initrd) as a whole is compressed
as a single blob. Modern uboot can just decompress the payload and
jump straight into the kernel and I'd assumed that all uboot platforms
did this. The problem is that the compatible uboot (cuboot) images do
use the wrapper and the vmlinux baked into the wrapper is
uncompressed.

Oliver
