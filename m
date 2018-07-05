Return-Path: <labbott@redhat.com>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
 [209.85.216.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41M6pB3TrSzF1kV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 05:08:34 +1000 (AEST)
Received: by mail-qt0-f195.google.com with SMTP id h4-v6so8029212qtj.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jul 2018 12:08:34 -0700 (PDT)
Subject: Re: [PATCHv5 2/4] x86: Add build salt to the vDSO
To: Andy Lutomirski <luto@kernel.org>
Cc: Mark Wielaard <mjw@fedoraproject.org>, "H . J . Lu"
 <hjl.tools@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Nick Clifton <nickc@redhat.com>,
 Cary Coutant <ccoutant@gmail.com>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
References: <20180703233430.14416-1-labbott@redhat.com>
 <20180703233430.14416-3-labbott@redhat.com>
 <CALCETrVZi2WYbBSifaNV4wajj52PyG-w7z9DekfJvSuZAKi1nA@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <2abd8138-0f62-79a5-5a2c-8e08aee171b8@redhat.com>
Date: Thu, 5 Jul 2018 12:08:28 -0700
MIME-Version: 1.0
In-Reply-To: <CALCETrVZi2WYbBSifaNV4wajj52PyG-w7z9DekfJvSuZAKi1nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/2018 08:58 AM, Andy Lutomirski wrote:
> On Tue, Jul 3, 2018 at 4:34 PM, Laura Abbott <labbott@redhat.com> wrote:
>>
>> The vDSO needs to have a unique build id in a similar manner
>> to the kernel and modules. Use the build salt macro.
>>
> 
> Looks good to me.  I have no idea whose tree these would go through.
> 

I was intending this to go through kbuild tree. Can I take this
as an Ack?

>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> v5: Switched to using the single line BUILD_SALT macro
>> ---
>>   arch/x86/entry/vdso/vdso-note.S   | 3 +++
>>   arch/x86/entry/vdso/vdso32/note.S | 3 +++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/entry/vdso/vdso-note.S b/arch/x86/entry/vdso/vdso-note.S
>> index 79a071e4357e..79423170118f 100644
>> --- a/arch/x86/entry/vdso/vdso-note.S
>> +++ b/arch/x86/entry/vdso/vdso-note.S
>> @@ -3,6 +3,7 @@
>>    * Here we can supply some information useful to userland.
>>    */
>>
>> +#include <linux/build-salt.h>
>>   #include <linux/uts.h>
>>   #include <linux/version.h>
>>   #include <linux/elfnote.h>
>> @@ -10,3 +11,5 @@
>>   ELFNOTE_START(Linux, 0, "a")
>>          .long LINUX_VERSION_CODE
>>   ELFNOTE_END
>> +
>> +BUILD_SALT
>> diff --git a/arch/x86/entry/vdso/vdso32/note.S b/arch/x86/entry/vdso/vdso32/note.S
>> index 9fd51f206314..e78047d119f6 100644
>> --- a/arch/x86/entry/vdso/vdso32/note.S
>> +++ b/arch/x86/entry/vdso/vdso32/note.S
>> @@ -4,6 +4,7 @@
>>    * Here we can supply some information useful to userland.
>>    */
>>
>> +#include <linux/build-salt.h>
>>   #include <linux/version.h>
>>   #include <linux/elfnote.h>
>>
>> @@ -14,6 +15,8 @@ ELFNOTE_START(Linux, 0, "a")
>>          .long LINUX_VERSION_CODE
>>   ELFNOTE_END
>>
>> +BUILD_SALT
>> +
>>   #ifdef CONFIG_XEN
>>   /*
>>    * Add a special note telling glibc's dynamic linker a fake hardware
>> --
>> 2.17.1
>>
