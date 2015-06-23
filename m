Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 030871A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 16:06:40 +1000 (AEST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4ECEA140157
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2015 16:06:39 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Tue, 23 Jun 2015 11:36:29 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 57537E0054
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2015 11:40:03 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5N66QCX6226330
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2015 11:36:27 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5N66Psb031458
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2015 11:36:26 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, thuth@redhat.com, aik@ozlabs.ru, dvaleev@suse.com
Subject: Re: [PATCH SLOF 3/5] disk-label: introduce helper to check fat
 filesystem
In-Reply-To: <20150622193555.GD19845@gate.crashing.org>
References: <1434959987-8530-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1434959987-8530-4-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150622193555.GD19845@gate.crashing.org>
Date: Tue, 23 Jun 2015 11:36:24 +0530
Message-ID: <87fv5jdkm7.fsf@linux.vnet.ibm.com>
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


Hi Segher,

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Mon, Jun 22, 2015 at 01:29:45PM +0530, Nikunj A Dadhania wrote:
>> +: has-fat-filesystem ( block -- true | false )
>> +   \ block 0 byte 0-2 is a jump instruction in all FAT
>> +   \ filesystems.
>
> "block" there is not a block number, just a host address.  So it's not
> a good name.  Maybe do a better name for this word as well, something
> saying it looks at a disk block.

Sure.

>
>> +   \ e9 and eb are jump instructions in x86 assembler.
>> +   dup c@ e9 <> IF
>> +      dup c@ eb <> swap
>> +      2+  c@ 90 <> or
>> +      IF false EXIT THEN
>> +   ELSE DROP THEN
>> +   TRUE
>> +;
>
> Don't write DROP and TRUE in caps please.  The purpose of having the
> structure words in caps is to make them stand out more, to make things
> more readable; putting other things in caps as well destroys that.

Sure, will take care.

> Since you factored this, it becomes more readable if you invert the
> conditions:

Sure.

> : fat-bootblock? ( addr -- flag )
>    \ byte 0-2 of the bootblock is a jump instruction in
>    \ all FAT filesystems.
>    \ e9 and eb are jump instructions in x86 assembler.
>    dup c@ e9 = IF drop true EXIT THEN
>    dup c@ eb = swap 2+ c@ 90 = and ;
>
> (not tested, etc.)
Will test.

Regards,
Nikunj
