Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE98E1A054D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 22:36:39 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 11 Jun 2014 18:06:35 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 706E4E0066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 18:07:33 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5BCajOt53346444
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 18:06:45 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5BCaWZu017113
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 18:06:32 +0530
Message-ID: <53984D4F.6040808@linux.vnet.ibm.com>
Date: Wed, 11 Jun 2014 20:36:31 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michal Marek <mmarek@suse.cz>
Subject: Re: Kernel build fail with "Circular xxxx <- xxxx dependency dropped"
References: <5397F0E9.8060305@linux.vnet.ibm.com> <53981238.8010007@suse.cz>
 <20140611122104.GA24569@pobox.suse.cz> <539849F6.8010501@suse.cz>
In-Reply-To: <539849F6.8010501@suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Sam Ravnborg <sam@ravnborg.org>, linuxppc <linuxppc-dev@lists.ozlabs.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michal,

after ally you patch, it also has some issue, see below:

WARNING: 1 bad relocations
c000000001455040 R_PPC64_ADDR64    uprobes_fetch_type_table
arch/powerpc/boot/Makefile:336: target 
`arch/powerpc/boot/zImage.pseries' given more than once in the same rule.
gcc -m32 -Wp,-MD,arch/powerpc/boot/.zImage.lds.d  -nostdinc -isystem 
/usr/lib/gcc/ppc64-redhat-linux/4.7.2/include -I./arch/powerpc/include 
-Iarch/powerpc/include/generated -Iinclude -I./arch/powe
rpc/include/uapi -Iarch/powerpc/include/generated/uapi -I./include/uapi 
-Iinclude/generated/uapi -include ./include/linux/kconfig.h -D__KERNEL__ 
-Iarch/powerpc      -E -Wp,-MD,arch/powerpc/boot/.zI
mage.lds.d -P -Upowerpc \
         -D__ASSEMBLY__ -DLINKER_SCRIPT -o arch/powerpc/boot/zImage.lds 
arch/powerpc/boot/zImage.lds.S
   WRAP    arch/powerpc/boot/zImage.pseries
   WRAP    arch/powerpc/boot/zImage.epapr
   MODPOST 1853 modules
INFO: Uncompressed kernel (size 0x14d0db8) overlaps the address of the 
wrapper(0x400000)
INFO: Fixing the link_address of wrapper to (0x1500000)
ld: cannot find arch/powerpc/boot/vmlinux.o: No such file or directory
make[1]: *** [arch/powerpc/boot/zImage.pseries] Error 1
make[1]: *** Waiting for unfinished jobs....
INFO: Uncompressed kernel (size 0x14d0db8) overlaps the address of the 
wrapper(0x400000)
INFO: Fixing the link_address of wrapper to (0x1500000)
ld: cannot find arch/powerpc/boot/vmlinux.o: No such file or directory
make[1]: *** [arch/powerpc/boot/zImage.epapr] Error 1
make: *** [zImage] Error 2
make: *** Waiting for unfinished jobs....

Thanks
Mike

On 06/11/2014 08:22 PM, Michal Marek wrote:
> Dne 11.6.2014 14:21, Michal Marek napsal(a):
>> On Wed, Jun 11, 2014 at 10:24:24AM +0200, Michal Marek wrote:
>>> Dne 11.6.2014 08:02, Mike Qiu napsal(a):
>>>> make[1]: Circular arch/powerpc/boot/zImage.lds.S <-
>>>> arch/powerpc/boot/zImage.lds dependency dropped.
>>>> make[1]: Circular arch/powerpc/boot/zImage.coff.lds.S <-
>>>> arch/powerpc/boot/zImage.lds dependency dropped.
>>>> make[1]: Circular arch/powerpc/boot/zImage.coff.lds.S <-
>>>> arch/powerpc/boot/zImage.coff.lds dependency dropped.
>>>> make[1]: Circular arch/powerpc/boot/zImage.ps3.lds.S <-
>>>> arch/powerpc/boot/zImage.lds dependency dropped.
>>>> make[1]: Circular arch/powerpc/boot/zImage.ps3.lds.S <-
>>>> arch/powerpc/boot/zImage.coff.lds dependency dropped.
>>>> make[1]: Circular arch/powerpc/boot/zImage.ps3.lds.S <-
>>>> arch/powerpc/boot/zImage.ps3.lds dependency dropped.
>>>>    WRAP    arch/powerpc/boot/zImage.ps3.lds.S
>>>> INFO: Uncompressed kernel (size 0x14d0db8) overlaps the address of the
>>>> wrapper(0x400000)
>>>> INFO: Fixing the link_address of wrapper to (0x1500000)
>>>> ld: cannot open linker script file arch/powerpc/boot/zImage.lds: No such
>>>> file or directory
>>>> make[1]: *** [arch/powerpc/boot/zImage.ps3.lds.S] Error 1
>>>> make: *** [zImage] Error 2
>>>> make: *** Waiting for unfinished jobs....
>>>>    MODPOST 1853 modules
>>>>
>>>> I use git bisect to find out the possible commits to lead this problem:
>>>> 7e1c04779efd51154baf652e653ceb24ce68939b kbuild: Use relative path for
>>>> $(objtree)
>>>> 890676c65d699db3ad82e7dddd0cf8fb449031af kbuild: Use relative path when
>>>> building in the source tree
>>>> 9da0763bdd82572be243fcf5161734f11568960f kbuild: Use relative path when
>>>> building in a subdir of the source tree
>>> Thanks for the report, I'll have a look. If I do not come up with a
>>> solution soon, I'll revert the series.
>> I have yet to test this, but can you try the patch below?
>>
>> Thanks!
>> Michal
>>
>>
>>  From 7f8336f4c7f2131efbe82543580dda3ec1988609 Mon Sep 17 00:00:00 2001
>> From: Michal Marek <mmarek@suse.cz>
>> Date: Wed, 11 Jun 2014 13:53:48 +0200
>> Subject: [PATCH] powerpc: Avoid circular dependency with zImage.%
>>
>> The rule to create the final images uses a zImage.% pattern.
>> Unfortunately, this also matches the names of the zImage.*.lds linker
>> scripts, which appear as a dependency of the final images. This somehow
>> worked when $(srctree) used to be an absolute path, but now the pattern
>> matches too much. List only the images from $(image-y) as the target of
>> the rule, to avoid the circular dependency.
>>
> If merged, this should of course have a Reported-by: Mike Qiu
> <qiudayu@linux.vnet.ibm.com>
>
> Michal
>
>
