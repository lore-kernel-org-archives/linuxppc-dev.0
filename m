Return-Path: <themoken@gmail.com>
Received: from mail-ig0-x244.google.com (mail-ig0-x244.google.com
 [IPv6:2607:f8b0:4001:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qm8bW2wLXzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 04:39:35 +1000 (AEST)
Received: by mail-ig0-x244.google.com with SMTP id fn8so89393igb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 11:39:35 -0700 (PDT)
MIME-Version: 1.0
Sender: themoken@gmail.com
In-Reply-To: <1460591377.30121.3.camel@neuling.org>
References: <1460401065-10540-1-git-send-email-jack@codezen.org>
 <1460401065-10540-2-git-send-email-jack@codezen.org>
 <20160413205112.425444de@kryten>
 <CAGXwabRb-Wc8W8m0qP4kLb-oR+fZED8urYr4Asw0bq9kAc8C1w@mail.gmail.com>
 <1460591377.30121.3.camel@neuling.org>
Date: Thu, 14 Apr 2016 13:39:32 -0500
Message-ID: <CAGXwabSNfXNPZ1-N9f0MnNRVbarHYQY2bfvCsnvGbbQDE4qTRQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc: Complete FSCR context switch
From: Jack Miller <jack@codezen.org>
To: Michael Neuling <mikey@neuling.org>
Cc: Jack Miller <jack@codezen.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, michael@ozlabs.au.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I'm not sure that works on processes before power8.
>
> There DSCR SPR number 0x11 will always trap and emulate from userspace
> (see arch/powerpc/kernel/traps.c:emulate_instruction()).  That is not
> controlled by FSCR and should work on POWER7 where FSCR is not
> present.  We need to set the inherit bit there too.
>
> DSCR SPR number 0x3 is controlled by fscr, but it's only avaliable on
> POWER8.
>
>> Right now the FSCR switch is conditional on FTR_ARCH_207S which is
>> more exclusive than FTR_DSCR, but I guess the actual FSCR register is
>> universal to PPC64 like the fscr field in the thread struct? If so, I
>> can just move the FSCR save/restore out of the 207 conditional.
>
> FSCR was only introduced in power8, so it needs to be 207 conditional
>

So on P6/P7 (which have FTR_DSCR) set we're potentially mtspr'ing to a
non-existent register? Yuck. Can at least strip that logic out thanks
to the full context switch, I think, even if dscr_inherit actually has
a use.

- Jack
