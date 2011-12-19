Return-Path: <pku.leo@gmail.com>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D62EFB702E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2011 22:05:31 +1100 (EST)
Received: by eekb57 with SMTP id b57so4994755eek.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2011 03:05:26 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <4EEB8704.8030201@freescale.com>
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
 <4EDEAEB9.6020703@freescale.com> <1323724195.2297.11.camel@koala>
 <4EE66EFE.1050608@freescale.com> <1323724784.2297.20.camel@koala>
 <4EE6725C.3050706@freescale.com> <4EE6BC9B.4000602@freescale.com>
 <4EE8612C.9050104@freescale.com> <4EE903CE.1010903@freescale.com>
 <4EEAB076.30000@freescale.com> <4EEB8704.8030201@freescale.com>
Date: Mon, 19 Dec 2011 19:05:26 +0800
Message-ID: <CADRPPNT-akj5KBQKdRaFrA2XpLU6-xtuRduzDYEWjv_dzVmTAA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
From: Li Yang <leoli@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Artem.Bityutskiy@nokia.com, dedekind1@gmail.com,
 linuxppc-dev@lists.ozlabs.org, LiuShuo <b35362@freescale.com>,
 linux-kernel@vger.kernel.org, shuo.liu@freescale.com,
 linux-mtd@lists.infradead.org, akpm@linux-foundation.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 17, 2011 at 1:59 AM, Scott Wood <scottwood@freescale.com> wrote=
:
> On 12/15/2011 08:44 PM, LiuShuo wrote:
>> hi Artem,
>> Could this patch be applied now and we make a independent patch for =C2=
=A0bad
>> block information
>> migration later?
>
> This patch is not safe to use without migration.

Hi Scott,

We agree it's not entirely safe without migrating the bad block flag.
But let's consider two sides of the situation.

Firstly, it's only unsafe when there is a need to re-built the Bad
Block Table from scratch(old BBT broken).  But currently there is no
easy way to do that(re-build BBT on demand), which means it's not a
common problem that we can easily address now.

Secondly, even if the previous said problem happens(BBT broken).  We
can still recover all the data if we overrule the bad block flag.
Only the card is not so good to be used again, however, it can be used
if we take the risk of losing data from errors that ECC can't
notice(low possibility too).

Finally, I don't think this is a blocker issue but a better to have enhance=
ment.

- Leo
