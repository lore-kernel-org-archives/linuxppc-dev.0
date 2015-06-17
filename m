Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06E281A0E20
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 22:05:33 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5BF4514028E
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2015 22:05:32 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Wed, 17 Jun 2015 17:35:29 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 06A2AE005B
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2015 17:38:54 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5HC5MmJ2687272
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2015 17:35:23 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5HC4Efa025863
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2015 17:34:14 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, aik@ozlabs.ru,
 dvaleev@suse.com
Subject: Re: [PATCH SLOF] disk-label: add support for booting from GPT FAT
 partition
In-Reply-To: <87fv5qeeax.fsf@linux.vnet.ibm.com>
References: <1434017929-1792-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150617122248.77211775@thh440s> <87fv5qeeax.fsf@linux.vnet.ibm.com>
Date: Wed, 17 Jun 2015 17:34:13 +0530
Message-ID: <87d20uee2q.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:

> Thomas Huth <thuth@redhat.com> writes:
>>> +\ Check for GPT MSFT BASIC DATA GUID - vfat based
>>> +EBD0A0A2     CONSTANT GPT-BASIC-DATA-PARTITION-1
>>> +B9E5         CONSTANT GPT-BASIC-DATA-PARTITION-2
>>> +4433         CONSTANT GPT-BASIC-DATA-PARTITION-3
>>> +87C0         CONSTANT GPT-BASIC-DATA-PARTITION-4
>>> +68B6B72699C7 CONSTANT GPT-BASIC-DATA-PARTITION-5
>>> +
>>> +: gpt-basic-data-partition? ( -- true|false )
>>> +   block gpt-part-entry>part-type-guid l@-le GPT-BASIC-DATA-PARTITION-=
1 =3D IF
>>> +      block gpt-part-entry>part-type-guid 4 + w@-le
>>> +      GPT-BASIC-DATA-PARTITION-2 =3D IF
>>> +         block gpt-part-entry>part-type-guid 6 + w@-le
>>> +         GPT-BASIC-DATA-PARTITION-3 =3D IF
>>> +            block gpt-part-entry>part-type-guid 8 + w@
>>
>> Don't you have to byte-swap (w@-le) here, too? Looks somehow strange
>> that the other UID parts are read byte-swapped but this one is not?
>
> Interesting observation, I had used code from gpt-prep-partition? and
> did not doubt the validity of it. But that is how I see it in the memory
> though.
>
> 4 >  7e50d000 10 dump=20
> 7e50d000: a2 a0 d0 eb e5 b9 33 44 87 c0 68 b6 b7 26 99 c7  ......3D..h..&=
.. ok
> 4 >

And here the answer for that:

    https://en.wikipedia.org/wiki/GUID_Partition_Table#cite_note-26
=20=20=20=20
    The GUIDs in this table are written assuming a little-endian byte
    order. For example, the GUID for an EFI System partition is written
    as C12A7328-F81F-11D2-BA4B-00A0C93EC93B here, which corresponds to
    the 16 byte sequence 28h 73h 2Ah C1h 1Fh F8h D2h 11h BAh 4Bh 00h A0h
    C9h 3Eh C9h 3Bh =E2=80=93 only the first three blocks are byte-swapped.

"only the first three blocks are byte-swapped"

Regards,
Nikunj
