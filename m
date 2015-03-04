Return-Path: <keescook@google.com>
Received: from mail-vc0-x234.google.com (mail-vc0-x234.google.com
 [IPv6:2607:f8b0:400c:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24A581A0006
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 08:58:17 +1100 (AEDT)
Received: by mail-vc0-f180.google.com with SMTP id le20so10077403vcb.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2015 13:58:14 -0800 (PST)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20150304215437.GA22254@gmail.com>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
 <20150304215437.GA22254@gmail.com>
Date: Wed, 4 Mar 2015 13:58:14 -0800
Message-ID: <CAGXu5jJTGms38aWJgFerjaAxPLDkXuGAx69ihzUrcWZ0BMbpqg@mail.gmail.com>
Subject: Re: [PATCH v4 0/10] split ET_DYN ASLR from mmap ASLR
From: Kees Cook <keescook@chromium.org>
To: Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Arun Chandran <achandran@mvista.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, Min-Hua Chen <orca.chen@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Ismael Ripoll <iripoll@upv.es>,
 Yann Droneaud <ydroneaud@opteya.com>, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>,
 Andrey Ryabinin <a.ryabinin@samsung.com>, "x86@kernel.org" <x86@kernel.org>,
 Hector Marco-Gisbert <hecmargi@upv.es>, Ingo Molnar <mingo@redhat.com>,
 "David A. Long" <dave.long@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Borislav Petkov <bp@suse.de>,
 Ben Hutchings <ben@decadent.org.uk>, Will Deacon <will.deacon@arm.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jeff Bailey <jeffbailey@google.com>, Paul Burton <paul.burton@imgtec.com>,
 Oleg Nesterov <oleg@redhat.com>, Ralf Baechle <ralf@linux-mips.org>,
 Andy Lutomirski <luto@amacapital.net>, Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <dl9pf@gmx.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Alex Smith <alex@alex-smith.me.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 4, 2015 at 1:54 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Kees Cook <keescook@chromium.org> wrote:
>
>> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
>> ASLR from mmap ASLR, as already done on s390. The architectures
>> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
>> and x86), have their various forms of arch_mmap_rnd() made available
>> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
>> arch_randomize_brk() is collapsed as well.
>>
>> This is an alternative to the solutions in:
>> https://lkml.org/lkml/2015/2/23/442
>>
>> I've been able to test x86 and arm, and the buildbot (so far) seems
>> happy with building the rest.
>
> Ok, this looks really good - for all patches:
>
>    Reviewed-by: Ingo Molnar <mingo@kernel.org>

Great! Thanks for the suggestions and reviews. :)

-Kees

-- 
Kees Cook
Chrome OS Security
