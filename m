Return-Path: <dinarv@gmail.com>
Received: from mail-wg0-x231.google.com (mail-wg0-x231.google.com
 [IPv6:2a00:1450:400c:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA14C1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 20:43:41 +1000 (AEST)
Received: by wgv5 with SMTP id 5so136451449wgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2015 03:43:37 -0700 (PDT)
MIME-Version: 1.0
Sender: dinarv@gmail.com
In-Reply-To: <87fv6ajtd1.fsf@linux.vnet.ibm.com>
References: <1432906201-25009-1-git-send-email-k0da@opensuse.org>
 <87iob6jvau.fsf@linux.vnet.ibm.com>
 <CADqALGSZ4-SLEjjLcjC+diw7P0TgctjaqtRtXDOUOPxmvtqVqQ@mail.gmail.com>
 <87fv6ajtd1.fsf@linux.vnet.ibm.com>
From: Dinar Valeev <k0da@opensuse.org>
Date: Tue, 2 Jun 2015 12:43:16 +0200
Message-ID: <CADqALGRXOQnsd0x9pWfdnUphS+PafxAF-X3bNS9HVYdx4dP0qA@mail.gmail.com>
Subject: Re: [PATCH] Fix function keys sequence on USB
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: Dinar Valeev <dvaleev@suse.com>, Thomas Huth <thuth@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 2, 2015 at 12:29 PM, Nikunj A Dadhania
<nikunj@linux.vnet.ibm.com> wrote:
> Dinar Valeev <k0da@opensuse.org> writes:
>
>> On Tue, Jun 2, 2015 at 11:47 AM, Nikunj A Dadhania
>> <nikunj@linux.vnet.ibm.com> wrote:
>>> Dinar valeev <k0da@opensuse.org> writes:
>>>> @@ -262,7 +258,7 @@ static void check_key_code(uint8_t *buf)
>>>>                               case 0x43:
>>>>                                       write_key(0x1b);               /* F10 */
>>>>                                       write_key(0x5b);
>>>> -                                     write_key(0x31);
>>>> +                                     write_key(0x32);
>>>>                                       write_key(0x31);
>>>>                                       write_key(0x7e);
>>>>                                       break;
>>>
>>> Does F10 work for you? doesn't work for me ?
>> It does. But then menu entry is expanded to openSUSE, with Linux 4.0.1-1-default
>> entering edit mode and pressing f10 finally boots it.
>>
>> xterm sequence is ^[[21~
>
> I had used following in TCG:
>
> qemu-system-ppc64 -machine pseries -m 2G -serial stdio -cdrom distro.iso \
> -vnc :1
>
>>
>>
>>>
>>>> @@ -270,7 +266,7 @@ static void check_key_code(uint8_t *buf)
>>>>                               case 0x44:
>>>>                                       write_key(0x1b);               /* F11 */
>>>>                                       write_key(0x5b);
>>>> -                                     write_key(0x31);
>>>> +                                     write_key(0x32);
>>>>                                       write_key(0x33);
>>>>                                       write_key(0x7e);
>>>>                                       break;
>>>> @@ -278,7 +274,7 @@ static void check_key_code(uint8_t *buf)
>>>>                               case 0x45:
>>>>                                       write_key(0x1b);               /* F12 */
>>>>                                       write_key(0x5b);
>>>> -                                     write_key(0x31);
>>>> +                                     write_key(0x32);
>>>>                                       write_key(0x34);
>>>>                                       write_key(0x7e);
>>>>                                       break;
>>>> @@ -290,36 +286,34 @@ static void check_key_code(uint8_t *buf)
>>>>                               case 0x49:
>>>>                                       write_key(0x1b);               /* INS */
>>>>                                       write_key(0x5b);
>>>> -                                     write_key(0x31);
>>>> +                                     write_key(0x32);
>>>>                                       write_key(0x7e);
>>>>                                       break;
>>>>
>>>>                               case 0x4a:
>>>>                                       write_key(0x1b);              /* HOME */
>>>>                                       write_key(0x5b);
>>>> -                                     write_key(0x32);
>>>> -                                     write_key(0x7e);
>>>> +                                     write_key(0x48);
>>>
>>> Looking at accept.fs - handle-ESC-5b ...
>>>
>>> : handle-ESC-5b
>>>    key
>>>    dup 31 = IF \ HOME
>>>       key drop ( drops closing 7e ) handle-^A
>>>    ELSE
>>>       dup 33 = IF \ DEL
>>>          key drop handle-^D
>>>       ELSE
>>>          dup 34 = IF \ END
>>>             key drop handle-^E
>>>          ELSE
>>>             dup 1f and handle-CSI
>>>          THEN
>>>       THEN
>>>    THEN drop
>>> ;
>>>
>>>
>>> ... following change is sufficient:
>>> -                                       write_key(0x32);
>>> +                                       write_key(0x31);
>>>
>> Home sequence for me is: ^[[H
>
> Can you check the above change in your setup ?
That works as well.
>
>>>
>>>>                                       break;
>>>>
>>>>                               case 0x4b:
>>>>                                       write_key(0x1b);              /* PgUp */
>>>>                                       write_key(0x5b);
>>>> -                                     write_key(0x33);
>>>> +                                     write_key(0x35);
>>>>                                       write_key(0x7e);
>>>>                                       break;
>>>>
>>>>                               case 0x4c:
>>>>                                       write_key(0x1b);               /* DEL */
>>>>                                       write_key(0x5b);
>>>> -                                     write_key(0x34);
>>>> +                                     write_key(0x33);
>>>
>>> Right.
>>>
>>>>                                       write_key(0x7e);
>>>>                                       break;
>>>>
>>>>                               case 0x4d:
>>>>                                       write_key(0x1b);               /* END */
>>>>                                       write_key(0x5b);
>>>> -                                     write_key(0x35);
>>>> -                                     write_key(0x7e);
>>>> +                                     write_key(0x46);
>>>
>>> I tried using: 0x34, but somehow it does not work.
>> ^[[F works for me.
>>
>> All changes are tested in openSUSE's grub2 with -vga std. Note we
>> don't have any special patches here..
>>
>> Tested with -vga none -nographic. Home, End works with patched SLOF
>
> Ok.
>
> Regards
> Nikunj
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
