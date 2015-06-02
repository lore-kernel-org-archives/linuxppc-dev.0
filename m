Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E7171A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 20:30:50 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Tue, 2 Jun 2015 20:30:48 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 850CB2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 20:30:45 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52AUaU940042562
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 20:30:45 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52AUCu1031554
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 20:30:12 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Dinar Valeev <k0da@opensuse.org>
Cc: linuxppc-dev@lists.ozlabs.org, Thomas Huth <thuth@redhat.com>,
 Dinar Valeev <dvaleev@suse.com>
Subject: Re: [PATCH] Fix function keys sequence on USB
In-Reply-To: <CADqALGSZ4-SLEjjLcjC+diw7P0TgctjaqtRtXDOUOPxmvtqVqQ@mail.gmail.com>
References: <1432906201-25009-1-git-send-email-k0da@opensuse.org>
 <87iob6jvau.fsf@linux.vnet.ibm.com>
 <CADqALGSZ4-SLEjjLcjC+diw7P0TgctjaqtRtXDOUOPxmvtqVqQ@mail.gmail.com>
Date: Tue, 02 Jun 2015 15:59:46 +0530
Message-ID: <87fv6ajtd1.fsf@linux.vnet.ibm.com>
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

Dinar Valeev <k0da@opensuse.org> writes:

> On Tue, Jun 2, 2015 at 11:47 AM, Nikunj A Dadhania
> <nikunj@linux.vnet.ibm.com> wrote:
>> Dinar valeev <k0da@opensuse.org> writes:
>>> @@ -262,7 +258,7 @@ static void check_key_code(uint8_t *buf)
>>>                               case 0x43:
>>>                                       write_key(0x1b);               /* F10 */
>>>                                       write_key(0x5b);
>>> -                                     write_key(0x31);
>>> +                                     write_key(0x32);
>>>                                       write_key(0x31);
>>>                                       write_key(0x7e);
>>>                                       break;
>>
>> Does F10 work for you? doesn't work for me ?
> It does. But then menu entry is expanded to openSUSE, with Linux 4.0.1-1-default
> entering edit mode and pressing f10 finally boots it.
>
> xterm sequence is ^[[21~

I had used following in TCG:

qemu-system-ppc64 -machine pseries -m 2G -serial stdio -cdrom distro.iso \
-vnc :1

>
>
>>
>>> @@ -270,7 +266,7 @@ static void check_key_code(uint8_t *buf)
>>>                               case 0x44:
>>>                                       write_key(0x1b);               /* F11 */
>>>                                       write_key(0x5b);
>>> -                                     write_key(0x31);
>>> +                                     write_key(0x32);
>>>                                       write_key(0x33);
>>>                                       write_key(0x7e);
>>>                                       break;
>>> @@ -278,7 +274,7 @@ static void check_key_code(uint8_t *buf)
>>>                               case 0x45:
>>>                                       write_key(0x1b);               /* F12 */
>>>                                       write_key(0x5b);
>>> -                                     write_key(0x31);
>>> +                                     write_key(0x32);
>>>                                       write_key(0x34);
>>>                                       write_key(0x7e);
>>>                                       break;
>>> @@ -290,36 +286,34 @@ static void check_key_code(uint8_t *buf)
>>>                               case 0x49:
>>>                                       write_key(0x1b);               /* INS */
>>>                                       write_key(0x5b);
>>> -                                     write_key(0x31);
>>> +                                     write_key(0x32);
>>>                                       write_key(0x7e);
>>>                                       break;
>>>
>>>                               case 0x4a:
>>>                                       write_key(0x1b);              /* HOME */
>>>                                       write_key(0x5b);
>>> -                                     write_key(0x32);
>>> -                                     write_key(0x7e);
>>> +                                     write_key(0x48);
>>
>> Looking at accept.fs - handle-ESC-5b ...
>>
>> : handle-ESC-5b
>>    key
>>    dup 31 = IF \ HOME
>>       key drop ( drops closing 7e ) handle-^A
>>    ELSE
>>       dup 33 = IF \ DEL
>>          key drop handle-^D
>>       ELSE
>>          dup 34 = IF \ END
>>             key drop handle-^E
>>          ELSE
>>             dup 1f and handle-CSI
>>          THEN
>>       THEN
>>    THEN drop
>> ;
>>
>>
>> ... following change is sufficient:
>> -                                       write_key(0x32);
>> +                                       write_key(0x31);
>>
> Home sequence for me is: ^[[H

Can you check the above change in your setup ?

>>
>>>                                       break;
>>>
>>>                               case 0x4b:
>>>                                       write_key(0x1b);              /* PgUp */
>>>                                       write_key(0x5b);
>>> -                                     write_key(0x33);
>>> +                                     write_key(0x35);
>>>                                       write_key(0x7e);
>>>                                       break;
>>>
>>>                               case 0x4c:
>>>                                       write_key(0x1b);               /* DEL */
>>>                                       write_key(0x5b);
>>> -                                     write_key(0x34);
>>> +                                     write_key(0x33);
>>
>> Right.
>>
>>>                                       write_key(0x7e);
>>>                                       break;
>>>
>>>                               case 0x4d:
>>>                                       write_key(0x1b);               /* END */
>>>                                       write_key(0x5b);
>>> -                                     write_key(0x35);
>>> -                                     write_key(0x7e);
>>> +                                     write_key(0x46);
>>
>> I tried using: 0x34, but somehow it does not work.
> ^[[F works for me.
>
> All changes are tested in openSUSE's grub2 with -vga std. Note we
> don't have any special patches here..
>
> Tested with -vga none -nographic. Home, End works with patched SLOF

Ok.

Regards
Nikunj
