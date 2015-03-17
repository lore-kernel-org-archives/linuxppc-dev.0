Return-Path: <keescook@google.com>
Received: from mail-vc0-x22f.google.com (mail-vc0-x22f.google.com
 [IPv6:2607:f8b0:400c:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BADBE1A012C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 02:19:23 +1100 (AEDT)
Received: by mail-vc0-f175.google.com with SMTP id hy4so198096vcb.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 08:19:21 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20150317144702.GN8399@arm.com>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
 <1425503454-7531-4-git-send-email-keescook@chromium.org>
 <20150317144702.GN8399@arm.com>
Date: Tue, 17 Mar 2015 08:19:20 -0700
Message-ID: <CAGXu5jKHPL1V81wQ-gLAmGeMD9miM73X-QAL_RHbt+6hAEaAKg@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] arm64: standardize mmap_rnd() usage
From: Kees Cook <keescook@chromium.org>
To: Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 Min-Hua Chen <orca.chen@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Arun Chandran <achandran@mvista.com>, Paul Mackerras <paulus@samba.org>,
 Ismael Ripoll <iripoll@upv.es>, Yann Droneaud <ydroneaud@opteya.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Russell King <linux@arm.linux.org.uk>,
 Andrey Ryabinin <a.ryabinin@samsung.com>, "x86@kernel.org" <x86@kernel.org>,
 Hector Marco-Gisbert <hecmargi@upv.es>, Ingo Molnar <mingo@redhat.com>,
 "David A. Long" <dave.long@linaro.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Borislav Petkov <bp@suse.de>,
 Ben Hutchings <ben@decadent.org.uk>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jeff Bailey <jeffbailey@google.com>, Paul Burton <paul.burton@imgtec.com>,
 Oleg Nesterov <oleg@redhat.com>, Ralf Baechle <ralf@linux-mips.org>,
 Andy Lutomirski <luto@amacapital.net>, Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <dl9pf@gmx.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Alex Smith <alex@alex-smith.me.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 17, 2015 at 7:47 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Mar 04, 2015 at 09:10:47PM +0000, Kees Cook wrote:
>> In preparation for splitting out ET_DYN ASLR, this refactors the use of
>> mmap_rnd() to be used similarly to arm and x86. This additionally enables
>> mmap ASLR on legacy mmap layouts, which appeared to be missing on arm64,
>> and was already supported on arm. Additionally removes a copy/pasted
>> declaration of an unused function.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/arm64/include/asm/elf.h |  1 -
>>  arch/arm64/mm/mmap.c         | 18 +++++++++++-------
>>  2 files changed, 11 insertions(+), 8 deletions(-)
>
> Looks fine to me:
>
>   Acked-by: Will Deacon <will.deacon@arm.com>
>
> Do you want me to pick this up, or are you taking it along with the rest of
> your series (it doesn't have any obvious dependencies to me)?

Thanks! Right now akpm is carrying it, since the series ends with
changes that depend on all the per-arch refactoring.

-Kees

-- 
Kees Cook
Chrome OS Security
