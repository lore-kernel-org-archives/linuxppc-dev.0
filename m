Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sz4MM6kWCzDt0c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 06:07:27 +1100 (AEDT)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Paul Burton <paul.burton@imgtec.com>
Cc: <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Petr Mladek <pmladek@suse.com>,
 "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
 Borislav Petkov <bp@suse.de>, Tejun Heo <tj@kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] console: use first console if stdout-path device doesn't
 appear
References: <87oa2ij2mq.fsf@linux-m68k.org>
 <20161018091852.14776-1-paul.burton@imgtec.com>
Date: Tue, 18 Oct 2016 20:58:49 +0200
In-Reply-To: <20161018091852.14776-1-paul.burton@imgtec.com> (Paul Burton's
 message of "Tue, 18 Oct 2016 10:18:52 +0100")
Message-ID: <87mvi1cwly.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Okt 18 2016, Paul Burton <paul.burton@imgtec.com> wrote:

> If a device tree specified a preferred device for kernel console output
> via the stdout-path or linux,stdout-path chosen node properties there's
> no guarantee that it will have specified a device for which we have a
> driver. It may also be the case that we do have a driver but it doesn't
> call of_console_check() to register as a preferred console (eg. offb
> driver as used on powermac systems). In these cases try to ensure that
> we provide some console output by enabling the first console in the
> console_drivers list.
>
> As I don't have access to an affected system this has only been build
> tested - testing would be most appreciated.

Unfortunately that doesn't work.  The initial console still cannot be
opened.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
