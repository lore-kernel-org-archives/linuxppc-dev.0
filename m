Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 71F232C0086
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2012 07:02:41 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 4/8] time: Condense timekeeper.xtime into xtime_sec
References: <1342156917-25092-1-git-send-email-john.stultz@linaro.org>
 <1342156917-25092-5-git-send-email-john.stultz@linaro.org>
Date: Sun, 19 Aug 2012 23:02:21 +0200
In-Reply-To: <1342156917-25092-5-git-send-email-john.stultz@linaro.org> (John
 Stultz's message of "Fri, 13 Jul 2012 01:21:53 -0400")
Message-ID: <m2fw7ilhnm.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Prarit Bhargava <prarit@redhat.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Richard Cochran <richardcochran@gmail.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

John Stultz <john.stultz@linaro.org> writes:

> The timekeeper struct has a xtime_nsec, which keeps the
> sub-nanosecond remainder.  This ends up being somewhat
> duplicative of the timekeeper.xtime.tv_nsec value, and we
> have to do extra work to keep them apart, copying the full
> nsec portion out and back in over and over.
>
> This patch simplifies some of the logic by taking the timekeeper
> xtime value and splitting it into timekeeper.xtime_sec and
> reuses the timekeeper.xtime_nsec for the sub-second portion
> (stored in higher res shifted nanoseconds).
>
> This simplifies some of the accumulation logic. And will
> allow for more accurate timekeeping once the vsyscall code
> is updated to use the shifted nanosecond remainder.

This (together with b44d50d "time: Fix casting issue in tk_set_xtime and
tk_xtime_add") is causing resume to hang on the iBook (PowerBook6,7).
The fact that the add-on commit is needed to uncover the bug might give
a hint, but I'm unable to decipher it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
