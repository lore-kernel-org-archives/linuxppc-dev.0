Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Gcjx3JQ9zF1qT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 06:19:01 +1000 (AEST)
Received: by mail-oi0-x242.google.com with SMTP id q71-v6so20456078oic.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 13:19:01 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <20180329180246.Horde.AZE7BIRE2MuhcbAJb5Gg0A3@messagerie.si.c-s.fr>
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-16-malat@debian.org>
 <bd4be06c-b5f5-2516-1c1d-d2b6d7861090@c-s.fr>
 <CA+7wUsyRSSkwgpBodKkPjhUxiHy-t1q2Q7nsorfRoL=wfxgyFQ@mail.gmail.com>
 <20180329180246.Horde.AZE7BIRE2MuhcbAJb5Gg0A3@messagerie.si.c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 4 Apr 2018 22:18:38 +0200
Message-ID: <CA+7wUsz6KU3bk6hkKzEhn0HqxYQ3M5OEjcfZj2kKPXhSY=PDOg@mail.gmail.com>
Subject: Re: [PATCH 15/19] powerpc: Add missing prototype
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 29, 2018 at 6:02 PM, LEROY Christophe
<christophe.leroy@c-s.fr> wrote:
> Mathieu Malaterre <malat@debian.org> a =C3=A9crit :
>
>
>> On Fri, Mar 23, 2018 at 1:20 PM, christophe leroy
>> <christophe.leroy@c-s.fr> wrote:
>>>
>>>
>>>
>>> Le 22/03/2018 =C3=A0 21:20, Mathieu Malaterre a =C3=A9crit :
>>>>
>>>>
>>>> Add one missing prototype for function rh_dump_blk. Fix warning treate=
d
>>>> as
>>>> error in W=3D1:
>>>>
>>>>    arch/powerpc/lib/rheap.c:740:6: error: no previous prototype for
>>>> =E2=80=98rh_dump_blk=E2=80=99 [-Werror=3Dmissing-prototypes]
>>>>
>>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>>> ---
>>>>   arch/powerpc/include/asm/rheap.h | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/rheap.h
>>>> b/arch/powerpc/include/asm/rheap.h
>>>> index 172381769cfc..e75d96de19a0 100644
>>>> --- a/arch/powerpc/include/asm/rheap.h
>>>> +++ b/arch/powerpc/include/asm/rheap.h
>>>> @@ -83,6 +83,9 @@ extern int rh_get_stats(rh_info_t * info, int what,
>>>> int
>>>> max_stats,
>>>>   /* Simple dump of remote heap info */
>>>>   extern void rh_dump(rh_info_t * info);
>>>>   +/* Simple dump of remote info block */
>>>> +extern void rh_dump_blk(rh_info_t *info, rh_block_t *blk);
>>>> +
>>>
>>>
>>>
>>> Only used in one place, should be static
>>
>>
>> Well here is what I see over here:
>>
>> $ git grep rh_dump_blk
>> ...
>> arch/powerpc/lib/rheap.c:EXPORT_SYMBOL_GPL(rh_dump_blk);
>
>
> If it was really used by anybody in a module, it would already be in a .h=
 so
> I think we should simply delete the function
>

Sent a v3 without the extern keyword. I did not feel bold enough to
remove completely a function. Could one of the maintainers confirm
removal of the function ?

> Christophe
>
>
>>
>>
>>
>>> Christophe
>>>
>>>>   /* Set owner of taken block */
>>>>   extern int rh_set_owner(rh_info_t * info, unsigned long start, const
>>>> char *owner);
>>>>
>>>
>>>
>>> ---
>>> L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=
=C3=A9rifi=C3=A9e par le
>>> logiciel antivirus Avast.
>>> https://www.avast.com/antivirus
>>>
>
>
