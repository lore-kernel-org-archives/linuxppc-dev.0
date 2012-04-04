Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 65228B6FD2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2012 22:36:58 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Wed, 4 Apr 2012 18:06:51 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q34CantE4456456
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Apr 2012 18:06:49 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q34I7HB6005242
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Apr 2012 04:07:18 +1000
Message-ID: <4F7C4058.6090405@in.ibm.com>
Date: Wed, 04 Apr 2012 18:06:40 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: 3.4.0-rc1: No init found
References: <alpine.DEB.2.01.1204030008080.4930@trent.utfs.org>
 <1333440522.3040.9.camel@pasglop>
 <alpine.DEB.2.01.1204030953320.4930@trent.utfs.org>
In-Reply-To: <alpine.DEB.2.01.1204030953320.4930@trent.utfs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/03/2012 10:48 PM, Christian Kujau wrote:
> On Tue, 3 Apr 2012 at 18:08, Benjamin Herrenschmidt wrote:
>> I have observed this randomly on the G5 ... sometimes, if I try again,
>> it works... it's very very odd. There is some kind of race maybe with
>> async startup ? Or a problem with the vfs path walking ? It's certainly
>> not easily reproducable for me, it goes away from one boot to the next.
>
> It's 100% reproducible for me. This PowerBook G4 (1.25Ghz) is not the
> fastes though, maybe a race triggers more easily here...?
>
>>> PS: Unfortunately I cannot boot into the old (3.3-rc7) kernel
>>>      right now (which is still installed via "yaboot" and present in
>>>      /boot), because of this:
>>>      http://nerdbynature.de/bits/3.4.0-rc1/init/mac-invalid-memory.JPG
>>>      Booting into Debian's "squeeze" kernel (2.6.32) which resides in
>>>      the same /boot directory succeeds.
>>
>> Hrm, did it used to boot ?
>
> I'm using the "backup" kernel only when the new one has an issue, so I
> have not tested it for a while, but it used to work, for sure.
>
>> Can you do printenv in OF and tell me what
>> your load-base, real-base, virt-base etc... are ?
>
> load-base is 0x800000, real-base and virt-base is set to "-1", please see
> http://nerdbynature.de/bits/3.4.0-rc1/init/printenv-1.JPG
>
> Not sure if this is related, but at the end of each kernel compilation,
> the following messages are printed:
>
> ------------
>    SYSMAP  System.map
>    SYSMAP  .tmp_System.map
>    WRAP    arch/powerpc/boot/zImage.pmac
> INFO: Uncompressed kernel (size 0x6e52f8) overlaps the address of the wrapper(0x400000)
> INFO: Fixing the link_address of wrapper to (0x700000)
>    WRAP    arch/powerpc/boot/zImage.coff
> INFO: Uncompressed kernel (size 0x6e52f8) overlaps the address of the wrapper(0x500000)
> INFO: Fixing the link_address of wrapper to (0x700000)
>    WRAP    arch/powerpc/boot/zImage.miboot
> INFO: Uncompressed kernel (size 0x6d4b80) overlaps the address of the wrapper(0x400000)
> INFO: Fixing the link_address of wrapper to (0x700000)
>    Building modules, stage 2.
>    MODPOST 24 modules
> ------------
>
> I started to see these messages in January (around Linux 3.2.0), but never
> investigated what it was since the produced kernels continued to boot just
> fine.

The above change was added by me. The message is printed when the 
'wrapper' script finds that decompressed kernel overlaps the 'bootstrap 
code' which does the decompression. So it shifts the 'address' of the 
bootstrap code to the next higher MB. As such it is harmless.


Thanks
Suzuki
