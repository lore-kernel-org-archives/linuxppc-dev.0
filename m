Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 18F8D2C01EA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 08:36:10 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: Re: 3.4.0-rc1: No init found
Date: Thu, 5 Jul 2012 22:36:02 +0000
Message-ID: <CAOZdJXVhtxoiY0kvsC+zgrETgd_MxTR+nf+6JDMV5Y-osqVqaw@mail.gmail.com>
References: <alpine.DEB.2.01.1204030008080.4930@trent.utfs.org>
 <1333440522.3040.9.camel@pasglop>
 <alpine.DEB.2.01.1204030953320.4930@trent.utfs.org>
 <4F7C4058.6090405@in.ibm.com>
In-Reply-To: <4F7C4058.6090405@in.ibm.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Christian Kujau <lists@nerdbynature.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 4, 2012 at 7:36 AM, Suzuki K. Poulose <suzuki@in.ibm.com> wrote=
:

>> Not sure if this is related, but at the end of each kernel compilation,
>> the following messages are printed:
>>
>> ------------
>>    SYSMAP  System.map
>>    SYSMAP  .tmp_System.map
>>    WRAP    arch/powerpc/boot/zImage.pmac
>> INFO: Uncompressed kernel (size 0x6e52f8) overlaps the address of the
>> wrapper(0x400000)
>> INFO: Fixing the link_address of wrapper to (0x700000)
>>    WRAP    arch/powerpc/boot/zImage.coff
>> INFO: Uncompressed kernel (size 0x6e52f8) overlaps the address of the
>> wrapper(0x500000)
>> INFO: Fixing the link_address of wrapper to (0x700000)
>>    WRAP    arch/powerpc/boot/zImage.miboot
>> INFO: Uncompressed kernel (size 0x6d4b80) overlaps the address of the
>> wrapper(0x400000)
>> INFO: Fixing the link_address of wrapper to (0x700000)
>>    Building modules, stage 2.
>>    MODPOST 24 modules
>> ------------
>>
>> I started to see these messages in January (around Linux 3.2.0), but nev=
er
>> investigated what it was since the produced kernels continued to boot ju=
st
>> fine.
>
>
> The above change was added by me. The message is printed when the 'wrappe=
r'
> script finds that decompressed kernel overlaps the 'bootstrap code' which
> does the decompression. So it shifts the 'address' of the bootstrap code =
to
> the next higher MB. As such it is harmless.

I see this message every time when I build the kernel.  I know it's
harmless, but is this something that can be "fixed"?  That is, can we
change some linker script (or whatever) to make 0x700000 the default
value?  Or maybe modify the wrapper script to just automatically find
the right spot without printing a message?

--=20
Timur Tabi
Linux kernel developer at Freescale=
