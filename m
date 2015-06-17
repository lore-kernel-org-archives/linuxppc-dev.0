Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E98741A0E20
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 21:59:46 +1000 (AEST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4D68D14028F
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2015 21:59:45 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Wed, 17 Jun 2015 17:29:42 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 667B2125805B
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2015 17:32:13 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5HBxJPl49217630
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2015 17:29:21 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5HB007e008651
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2015 16:30:00 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, aik@ozlabs.ru,
 dvaleev@suse.com
Subject: Re: [PATCH SLOF] disk-label: add support for booting from GPT FAT
 partition
In-Reply-To: <20150617122248.77211775@thh440s>
References: <1434017929-1792-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150617122248.77211775@thh440s>
Date: Wed, 17 Jun 2015 17:29:18 +0530
Message-ID: <87fv5qeeax.fsf@linux.vnet.ibm.com>
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

Thomas Huth <thuth@redhat.com> writes:

> On Thu, 11 Jun 2015 15:48:49 +0530
> Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
>
>> For a GPT+LVM combination disk, older bootloader that does not support
>> LVM, cannot load kernel from LVM.
>> 
>> The patch add support to read from BASIC_DATA UUID
>> partition. Installer has installed CHRP-BOOT config on a FAT file
>> system.
>> 
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> ---
>>  slof/fs/packages/disk-label.fs | 72 ++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 70 insertions(+), 2 deletions(-)
>> 
>> diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
>> index fe1c25e..bf5fb5c 100644
>> --- a/slof/fs/packages/disk-label.fs
>> +++ b/slof/fs/packages/disk-label.fs
>> @@ -266,7 +266,7 @@ CONSTANT /gpt-part-entry
>>  
>>  : try-dos-partition ( -- okay? )
>>     \ Read partition table and check magic.
>> -   no-mbr? IF cr ." No DOS disk-label found." cr false EXIT THEN
>> +   no-mbr? IF false EXIT THEN
>
> Maybe keep the output when "debug-disk-label?" is set?

Sure.

>
>>     count-dos-logical-partitions TO dos-logical-partitions
>>  
>> @@ -408,6 +408,73 @@ AA26         CONSTANT GPT-PREP-PARTITION-4
>>     FALSE
>>  ;
>>  
>> +\ Check for GPT MSFT BASIC DATA GUID - vfat based
>> +EBD0A0A2     CONSTANT GPT-BASIC-DATA-PARTITION-1
>> +B9E5         CONSTANT GPT-BASIC-DATA-PARTITION-2
>> +4433         CONSTANT GPT-BASIC-DATA-PARTITION-3
>> +87C0         CONSTANT GPT-BASIC-DATA-PARTITION-4
>> +68B6B72699C7 CONSTANT GPT-BASIC-DATA-PARTITION-5
>> +
>> +: gpt-basic-data-partition? ( -- true|false )
>> +   block gpt-part-entry>part-type-guid l@-le GPT-BASIC-DATA-PARTITION-1 = IF
>> +      block gpt-part-entry>part-type-guid 4 + w@-le
>> +      GPT-BASIC-DATA-PARTITION-2 = IF
>> +         block gpt-part-entry>part-type-guid 6 + w@-le
>> +         GPT-BASIC-DATA-PARTITION-3 = IF
>> +            block gpt-part-entry>part-type-guid 8 + w@
>
> Don't you have to byte-swap (w@-le) here, too? Looks somehow strange
> that the other UID parts are read byte-swapped but this one is not?

Interesting observation, I had used code from gpt-prep-partition? and
did not doubt the validity of it. But that is how I see it in the memory
though.

4 >  7e50d000 10 dump 
7e50d000: a2 a0 d0 eb e5 b9 33 44 87 c0 68 b6 b7 26 99 c7  ......3D..h..&.. ok
4 >



>
>> +            GPT-BASIC-DATA-PARTITION-4 = IF
>> +               block gpt-part-entry>part-type-guid a + w@
>> +               block gpt-part-entry>part-type-guid c + l@ swap lxjoin
>
> dito ... here again no byteswap?
>
>> +               GPT-BASIC-DATA-PARTITION-5 = IF
>> +                   TRUE EXIT
>> +               THEN
>> +            THEN
>> +         THEN
>> +      THEN
>> +   THEN
>> +   FALSE
>> +;
>
> I'm not a fan of deep nesting, so I'd maybe write this function rather
> like this instead:

Sure, looks much simpler.

>
> : gpt-basic-data-partition? ( -- true|false )
>    block gpt-part-entry>part-type-guid
>    dup l@-le GPT-BASIC-DATA-PARTITION-1 <> IF FALSE EXIT THEN
>    dup 4 + w@-le GPT-BASIC-DATA-PARTITION-2 <> IF FALSE EXIT THEN
>    dup 6 + w@-le GPT-BASIC-DATA-PARTITION-3 <> IF FALSE EXIT THEN
>    ...
>    TRUE
> ;
>
> ... but that's just cosmetics.
>
>> +: try-gpt-vfat-partition ( -- okay? )
>> +   \ Read partition table and check magic.
>> +   no-gpt? IF cr ." No GPT disk-label found." cr false EXIT THEN
>
> Not directly related to this patch, but "no-gpt?" seems somewhat
> imprecise to me ... what if the whole MBR is accidentially filled
> with EE for example? That certainly does not indicate a valid GPT,
> does it?
>
> I might be wrong, but as far as I can say that function should also
> check for the aa55 magic at the end of the MBR, shouldn't it?
>
> Also I wonder whether you should check gpt>signature somewhere, either
> in "no-gpt?" or here before touching gpt>part-entry-lba entry below?
> I think that would contribute to the robustness of the code.

Sure, we can make this changes.

>> +   1 read-sector block gpt>part-entry-lba l@-le
>
> gpt>part-entry-lba seems to be an 8-bytes field ... so shouldn't you
> access it with "x@ xbflip" instead?

I will verfy this and make appropriate changes.

>
> By the way, it might be a good idea to add a "x@-le" helper for this to
> little-endian.fs.
>
>> +   block-size * to seek-pos
>> +   block gpt>part-entry-size l@-le to gpt-part-size
>> +   block gpt>num-part-entry l@-le dup 0= IF FALSE EXIT THEN
>> +   1+ 1 ?DO
>> +      seek-pos 0 seek drop
>> +      block gpt-part-size read drop
>
> Can you be sure that gpt-part-size is only smaller than 4096 bytes
> here? If not, you might overflow the block array, don't you?

True.

>> +      gpt-basic-data-partition? IF
>> +         debug-disk-label? IF
>> +            ." GPT LINUX DATA partition found " cr
>> +         THEN
>> +         block gpt-part-entry>first-lba x@ xbflip
>> +         dup to part-start
>> +         block gpt-part-entry>last-lba x@ xbflip
>> +         over - 1+                 ( addr offset len )
>> +         dup block-size * to part-size
>> +         swap                      ( addr len offset )
>> +         block-size * to part-offset
>> +         0 0 seek
>> +         block block-size read
>> +         3drop
>> +         \ block 0 byte 0-2 is a jump instruction in all FAT
>> +         \ filesystems.
>> +         \ e9 and eb are jump instructions in x86 assembler.
>> +         block c@ e9 <> IF
>> +            block c@ eb <>
>> +            block 2+ c@ 90 <> or
>> +            IF false EXIT THEN
>> +         THEN
>
> That's a copy of the code in try-dos-files ... could you please factor
> out that stuff into a separate function to avoid duplicate code? Thanks!
> (especially you also lack a UNLOOP before above EXIT otherwise, I
> think)

Yes.

>
>> +         TRUE
>> +         UNLOOP EXIT
>> +      THEN
>> +      seek-pos gpt-part-size i * + to seek-pos
>> +    LOOP
>> +    FALSE
>> +;
>> +
>>  \ Extract the boot loader path from a bootinfo.txt file
>>  \ In: address and length of buffer where the bootinfo.txt has been loaded to.
>>  \ Out: string address and length of the boot loader (within the input buffer)
>> @@ -493,7 +560,7 @@ AA26         CONSTANT GPT-PREP-PARTITION-4
>>  
>>     debug-disk-label? IF ." Trying CHRP boot " .s cr THEN
>>     1 disk-chrp-boot !
>> -   dup load-chrp-boot-file ?dup 0 <> IF .s cr nip EXIT THEN
>> +   dup load-chrp-boot-file ?dup 0 <> IF nip EXIT THEN
>>     0 disk-chrp-boot !
>>  
>>     debug-disk-label? IF ." Trying GPT boot " .s cr THEN
>> @@ -600,6 +667,7 @@ AA26         CONSTANT GPT-PREP-PARTITION-4
>>  
>>  : try-partitions ( -- found? )
>>     try-dos-partition IF try-files EXIT THEN
>> +   try-gpt-vfat-partition IF try-files EXIT THEN
>>     \ try-iso9660-partition IF try-files EXIT THEN
>>     \ ... more partition types here...
>>     false
>
>  Thomas

Regards
Nikunj
