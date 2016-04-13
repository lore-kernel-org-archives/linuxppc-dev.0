Return-Path: <themoken@gmail.com>
Received: from mail-ig0-x241.google.com (mail-ig0-x241.google.com
 [IPv6:2607:f8b0:4001:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlWc73qwWzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 03:52:54 +1000 (AEST)
Received: by mail-ig0-x241.google.com with SMTP id qu10so7595495igc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 10:52:54 -0700 (PDT)
MIME-Version: 1.0
Sender: themoken@gmail.com
In-Reply-To: <20160413205112.425444de@kryten>
References: <1460401065-10540-1-git-send-email-jack@codezen.org>
 <1460401065-10540-2-git-send-email-jack@codezen.org>
 <20160413205112.425444de@kryten>
Date: Wed, 13 Apr 2016 12:52:52 -0500
Message-ID: <CAGXwabRb-Wc8W8m0qP4kLb-oR+fZED8urYr4Asw0bq9kAc8C1w@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc: Complete FSCR context switch
From: Jack Miller <jack@codezen.org>
To: Anton Blanchard <anton@samba.org>
Cc: Jack Miller <jack@codezen.org>, linuxppc-dev@lists.ozlabs.org,
 michael.neuling@au1.ibm.com, michaele@au1.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton.

On Wed, Apr 13, 2016 at 5:51 AM, Anton Blanchard <anton@samba.org> wrote:
> Hi Jack,
>
>> Previously we just saved the FSCR, but only restored it in some
>> settings, and never copied it thread to thread. This patch always
>> restores the FSCR and formalizes new threads inheriting its setting so
>> that later we can manipulate FSCR bits in start_thread.
>
> Will this break the existing FSCR_DSCR bit handling?
>
>          if (cpu_has_feature(CPU_FTR_DSCR)) {
>                 u64 dscr = get_paca()->dscr_default;
>                 u64 fscr = old_thread->fscr & ~FSCR_DSCR;
>
>                 if (new_thread->dscr_inherit) {
>                         dscr = new_thread->dscr;
>                         fscr |= FSCR_DSCR;
>                 }
>
>                 if (old_thread->dscr != dscr)
>                         mtspr(SPRN_DSCR, dscr);
>
>                 if (old_thread->fscr != fscr)
>                         mtspr(SPRN_FSCR, fscr);
>         }
>
> If not, we should modify the above so we don't write the FSCR twice.

I think this code is just partially redundant. I think it's trying to
predict the right FSCR value based on this dscr_inherit flag. Now that
we fully switch it, we could skip setting FSCR here, and just set DSCR
if FSCR.DSCR is set (similar to what my patches do with FSCR.LM). In
fact, we might be able to just entirely get rid of the dscr_inherit
flag, but I'd have to look harder at that.

Right now the FSCR switch is conditional on FTR_ARCH_207S which is
more exclusive than FTR_DSCR, but I guess the actual FSCR register is
universal to PPC64 like the fscr field in the thread struct? If so, I
can just move the FSCR save/restore out of the 207 conditional.

Anyway, I'll clean this up a bit, add the little asm tweak from
Segher, and put another spin on the list.

- Jack
