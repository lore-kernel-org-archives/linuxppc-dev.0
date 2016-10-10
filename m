Return-Path: <hkallweit1@gmail.com>
Received: from mail-lf0-x231.google.com (mail-lf0-x231.google.com
 [IPv6:2a00:1450:4010:c07::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssqVh1fltzDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 17:10:36 +1100 (AEDT)
Received: by mail-lf0-x231.google.com with SMTP id l131so108025534lfl.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Oct 2016 23:10:36 -0700 (PDT)
Subject: Re: Commit 1b7898ee276b "powerpc/boot: Use the pre-boot decompression
 API" breaks boot
To: Michael Ellerman <mpe@ellerman.id.au>, Oliver O'Halloran <oohall@gmail.com>
References: <8db8ecac-4022-7df9-4e81-3d490c50821d@gmail.com>
 <CAOSf1CFVX8j+kyp3SRhRz_gyPiQ3R9x=_nJyq9fr31NyGi3hhg@mail.gmail.com>
 <c19153b9-7554-0280-6d97-750c9e62b3be@gmail.com>
 <80c9c42c-45d3-9f24-b3e1-5a5042686b1b@gmail.com>
 <877f9g7r4l.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <62241a1e-51c0-c1cd-1ecd-fa54a3842da0@gmail.com>
Date: Mon, 10 Oct 2016 08:10:23 +0200
MIME-Version: 1.0
In-Reply-To: <877f9g7r4l.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 10.10.2016 um 06:41 schrieb Michael Ellerman:
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
> 
> I wonder why the actual image is uncompressed? Or alternately why do we
> tell uboot the image is compressed when it's not?
> 
Uboot is provided with a compressed image, but what gets compressed is
not the pure kernel image but the resulting image incl. boot wrapper code,
see this part of the wrapper script:

cuboot*)
    gzip -n -f -9 "$ofile"
    ${MKIMAGE} -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
            $uboot_version -d "$ofile".gz "$ofile"

And this resulting image is decompressed by uboot already during boot.
Therefore the boot wrapper code sees an uncompressed kernel image.

IMHO in case of using cuboot no CONFIG_KERNEL_<COMPR TYPE> config option
should be set and Makefile + code in arch/powerpc/boot should be able
to deal with this situation:
- don't copy and build the decompression stuff
- use an alternative version of prep_kernel() in main.c which doesn't
  attempt to decompress the kernel image

This should be a cleaner solution than probing the kernel image whether
it's compressed or not.

Rgds, Heiner
