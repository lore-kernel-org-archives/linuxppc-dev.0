Return-Path: <arndbergmann@gmail.com>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JxRk4CM6zF3Fg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 07:00:18 +1000 (AEST)
Received: by mail-qt1-f196.google.com with SMTP id e9-v6so10697538qtp.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 14:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
 <1536913980-4811-3-git-send-email-firoz.khan@linaro.org>
 <CAK8P3a1PCnHy1JX4T21LjOr3ZGAVLdqxQaPYfLHAgM-9Y5yxVg@mail.gmail.com>
 <CALxhOngVYQRwbcUg6c_3LcKAEoBwyN1B478LqRGmWEGL004--w@mail.gmail.com>
In-Reply-To: <CALxhOngVYQRwbcUg6c_3LcKAEoBwyN1B478LqRGmWEGL004--w@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 24 Sep 2018 22:59:59 +0200
Message-ID: <CAK8P3a2hi-Ndh7X-9r3NhBUJXQBTBFsTU==GbHesy6YD9idCJA@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: Add system call table generation support
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxram@us.ibm.com, leitao@debian.org,
 Boqun Feng <boqun.feng@gmail.com>, gregkh <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 18, 2018 at 2:15 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> On 14 September 2018 at 15:31, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Sep 14, 2018 at 10:33 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> >> ---
> >>  arch/powerpc/kernel/syscalls/Makefile       |  51 ++++
> >>  arch/powerpc/kernel/syscalls/syscall_32.tbl | 378 ++++++++++++++++++++++++++++
> >>  arch/powerpc/kernel/syscalls/syscall_64.tbl | 372 +++++++++++++++++++++++++++
> >>  arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
> >>  arch/powerpc/kernel/syscalls/syscalltbl.sh  |  38 +++
> >
> > I think you should only need a single .tbl  input file here.
>
> Yes, we can do that way also.As I mentioned, it will add
> more complexity in the script.
>
>  The script has to be smart enough to parse the
> .tbl if we add more thing in the .tble file. It need more
> logic in the scripts. This is not common. So if you keep
> separate .tbl we can avoid this.

But all three existing architectures (x86, s390 and arm) already
have the capability to parse the table and generate different output
from that.

> ABI flag is serving *nothing* in all other architecture including
> SPARC.

If you don't use it in sparc, I think that's a bug, see e.g.

#ifdef __32bit_syscall_numbers__
#define __NR_setresuid32        108 /* Linux Specific, sigvec under
SunOS          */
#else
#define __NR_setresuid          108 /* Linux Specific, sigvec under
SunOS          */
#endif

> But as I told in the cover letter, I followed x86/arm/
> s390 architecture's system table generation implementation.
> They are keeping ABI flag. In our case we can delete this
> flag completely from all architectures.
>
> Most of the architecture these 32/64 similarity is absent.
> So it would be better keep separate files to maintain a
> generic script across all architecture.

There are a couple of architectures that definitely need it:
ARM for oabi, x86 for x32, s390, parisc and sparc for compat,
asm-generic for compat, powerpc for compat and spu,
and arm64 if we want to share the arm32 syscall table
for compat mode later.

      Arnd
