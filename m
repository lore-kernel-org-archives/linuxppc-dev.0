Return-Path: <arndbergmann@gmail.com>
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42K9RM2Rt1zF31R
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 16:00:46 +1000 (AEST)
Received: by mail-qk1-f193.google.com with SMTP id b19-v6so12813619qkc.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 23:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
 <1536913980-4811-3-git-send-email-firoz.khan@linaro.org>
 <CAK8P3a1PCnHy1JX4T21LjOr3ZGAVLdqxQaPYfLHAgM-9Y5yxVg@mail.gmail.com>
 <CALxhOngVYQRwbcUg6c_3LcKAEoBwyN1B478LqRGmWEGL004--w@mail.gmail.com>
 <CAK8P3a2hi-Ndh7X-9r3NhBUJXQBTBFsTU==GbHesy6YD9idCJA@mail.gmail.com>
 <87efdi5rm6.fsf@concordia.ellerman.id.au>
In-Reply-To: <87efdi5rm6.fsf@concordia.ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 25 Sep 2018 08:00:28 +0200
Message-ID: <CAK8P3a2=kxoum6hcPR2UN_St2PaFtZud_NNVkK9rHaf=N7ym-g@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: Add system call table generation support
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Firoz Khan <firoz.khan@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxram@us.ibm.com,
 leitao@debian.org, Boqun Feng <boqun.feng@gmail.com>,
 gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
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

On Tue, Sep 25, 2018 at 2:48 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Tue, Sep 18, 2018 at 2:15 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> >> On 14 September 2018 at 15:31, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Fri, Sep 14, 2018 at 10:33 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > But all three existing architectures (x86, s390 and arm) already
> > have the capability to parse the table and generate different output
> > from that.
>
> Yeah, we want that on powerpc too.
>
> If the script needs to be more complex that's fine, if it can't be
> shared across arches that's fine, the main thing for me is that wiring
> up a syscall can be done by adding a single line in a single file.

Yes, that's definitely the idea, we want to make it easier for everyone.
We need at least a special case for mips, which needs three separate
input files (the tables are completely different) to generate four versions
of the output, plus a future extension to use the generic table for their
new one.

For powerpc, I'm hoping that both the table format and script can be
completely generic and not need a special case that is different
from the others, but if we need some extra magic to handle the SPU
syscalls, we can still do that with a private script.

      Arnd
