Return-Path: <dpmcgee@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
 [209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 716E9B7091
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 09:43:17 +1100 (EST)
Received: by bkbzs8 with SMTP id zs8so27206bkb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2011 15:43:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20111017.175141.1489173261757833533.davem@davemloft.net>
References: <1318882661-26859-1-git-send-email-dpmcgee@gmail.com>
 <20111017.175141.1489173261757833533.davem@davemloft.net>
Date: Mon, 17 Oct 2011 17:43:11 -0500
Message-ID: <CAEik5nPXQXESnNLJCWd48LLiEYsN6MgnjKhd_a4SMHFGHBbm8w@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm: remove hack in mmap randomize layout
From: Dan McGee <dpmcgee@gmail.com>
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 17, 2011 at 4:51 PM, David Miller <davem@davemloft.net> wrote:
> From: Dan McGee <dpmcgee@gmail.com>
> Date: Mon, 17 Oct 2011 15:17:36 -0500
>
>> Since commit 8a0a9bd4db63bc45e301, this comment in mmap_rnd() does not
>> hold true as the value returned by get_random_int() will in fact be
>> different every single call. Remove the comment and simplify the code
>> back to its original desired form.
>>
>> This reverts commit a5adc91a4b44b5d1 which is no longer necessary.
>>
>> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
>
> Can you please fix up all the other architectures which use the same
> logic, because they have simply copied over what powerpc does?
>
> At a minimum, Sparc has two such locations.
Aha, I wasn't aware this was also being done elsewhere as there was no
comment to tip me off. I found the one in
arch/sparc/kernel/sys_sparc_64.c (mmap_rnd) and have fixed that
locally and will resend, but I'm not seeing get_random_int() in use
anywhere else in that architecture so I'm not quite sure where your
second mentioned location is- or did you just mean the two calls 2
lines apart in mmap_rnd()?

I also did a quick glance over every other usage and didn't seen any
other architectures doing anything funky, even in a slightly different
way.

-Dan
