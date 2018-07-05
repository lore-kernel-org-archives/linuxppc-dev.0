Return-Path: <labbott@redhat.com>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
 [209.85.216.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41M6ky34tJzF1kV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 05:05:45 +1000 (AEST)
Received: by mail-qt0-f195.google.com with SMTP id y20-v6so8022455qto.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jul 2018 12:05:44 -0700 (PDT)
Subject: Re: [PATCHv5 4/4] arm64: Add build salt to the vDSO
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Mark Wielaard <mjw@fedoraproject.org>, "H . J . Lu"
 <hjl.tools@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20180703233430.14416-1-labbott@redhat.com>
 <20180703233430.14416-5-labbott@redhat.com>
 <CAK7LNARxwNkzkUif9dj1oVFGYP4J41C+t=W4YFVxM+J94siGvA@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <33c28c0a-e429-51ea-0428-26fcfafa61bb@redhat.com>
Date: Thu, 5 Jul 2018 12:05:38 -0700
MIME-Version: 1.0
In-Reply-To: <CAK7LNARxwNkzkUif9dj1oVFGYP4J41C+t=W4YFVxM+J94siGvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2018 08:55 PM, Masahiro Yamada wrote:
> Hi.
> 
> 2018-07-04 8:34 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>>
>> The vDSO needs to have a unique build id in a similar manner
>> to the kernel and modules. Use the build salt macro.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> v5: I was previously focused on x86 only but since powerpc gave a patch,
>> I figured I would do arm64 since the changes were also fairly simple.
>> ---
>>   arch/arm64/kernel/vdso/note.S | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/vdso/note.S b/arch/arm64/kernel/vdso/note.S
>> index b82c85e5d972..2c429dfd3f45 100644
>> --- a/arch/arm64/kernel/vdso/note.S
>> +++ b/arch/arm64/kernel/vdso/note.S
>> @@ -22,7 +22,10 @@
>>   #include <linux/uts.h>
>>   #include <linux/version.h>
>>   #include <linux/elfnote.h>
>> +#include <linux/build-salt.h>
>>
>>   ELFNOTE_START(Linux, 0, "a")
>>          .long LINUX_VERSION_CODE
>>   ELFNOTE_END
>> +
>> +BUILD_SALT;
> 
> 
> 
> I think this works, but
> I prefer no-semicolon in assembly files.
> 
> For coding consistency,
> I want ';' as statement delimiter in .c files.
> But, only new line after each statement in .S files.
> 
> For example, in arch/x86/xen/xen-head.S
> I see no semicolon after ELFNOTE().
> 
> I found this:
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0473k/dom1359731141352.html
> It says ';' starts a comment line
> although it is not the case of GAS.
> 
> 
> Same for 3/4.
> 
> 
> 

Yes, that was a typo out of habit. Will fix.
