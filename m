Return-Path: <keescook@google.com>
Received: from mail-vc0-x233.google.com (mail-vc0-x233.google.com
 [IPv6:2607:f8b0:400c:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 380251A0008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 05:06:03 +1100 (AEDT)
Received: by mail-vc0-f179.google.com with SMTP id la4so15583505vcb.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2015 11:06:00 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20150309161912.GW8656@n2100.arm.linux.org.uk>
References: <1425435025-30284-1-git-send-email-keescook@chromium.org>
 <20150309161912.GW8656@n2100.arm.linux.org.uk>
Date: Mon, 9 Mar 2015 11:06:00 -0700
Message-ID: <CAGXu5jK=bEQDao+QZN7AZuVi0FB_+AsT4LAPodVZg3VTK=Pi-A@mail.gmail.com>
Subject: Re: [PATCH v3 0/10] split ET_DYN ASLR from mmap ASLR
From: Kees Cook <keescook@chromium.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Arun Chandran <achandran@mvista.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 Min-Hua Chen <orca.chen@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Ismael Ripoll <iripoll@upv.es>, Yann Droneaud <ydroneaud@opteya.com>,
 linux-s390@vger.kernel.org, Andrey Ryabinin <a.ryabinin@samsung.com>,
 Behan Webster <behanw@converseincode.com>, "x86@kernel.org" <x86@kernel.org>,
 Hector Marco-Gisbert <hecmargi@upv.es>, "David A. Long" <dave.long@linaro.org>,
 Ben Hutchings <ben@decadent.org.uk>, Will Deacon <will.deacon@arm.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Dan McGee <dpmcgee@gmail.com>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jeff Bailey <jeffbailey@google.com>, Paul Burton <paul.burton@imgtec.com>,
 LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
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

On Mon, Mar 9, 2015 at 9:19 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Mar 03, 2015 at 06:10:15PM -0800, Kees Cook wrote:
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
> Hmm, do you want to wrap my acks up to your previous one into this set?
> What about my tested-by?
>
> I'd rather not waste time testing this version if my previous test is
> still valid (or if there's yet another version of this patch set which
> is later than this set.)
>
> Unless I hear anything, I'll assume that it's broadly the same as the
> previous patch set and requires no action.

Yeah, it's broadly the same. I tweaked a few minor things, so I'm
comfortable retaining the acks and tested-bys. Thank you for the
reviews and tests!

-Kees

-- 
Kees Cook
Chrome OS Security
