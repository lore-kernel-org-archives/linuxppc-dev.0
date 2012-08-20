Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7DC9F2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 05:45:32 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 4/8] time: Condense timekeeper.xtime into xtime_sec
References: <1342156917-25092-1-git-send-email-john.stultz@linaro.org>
 <1342156917-25092-5-git-send-email-john.stultz@linaro.org>
 <m2fw7ilhnm.fsf@igel.home> <503288ED.10306@linaro.org>
Date: Mon, 20 Aug 2012 21:45:18 +0200
In-Reply-To: <503288ED.10306@linaro.org> (John Stultz's message of "Mon, 20
 Aug 2012 11:58:53 -0700")
Message-ID: <m2fw7h4ab5.fsf@igel.home>
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

> I'm not very familiar w/ the iBook hardware, but does it use a 
> clocksource, or does it use arch_gettimeoffset()?

clocksource: timebase mult[3640e38e] shift[24] registered

> I suspect that the casting has avoided clipping some strange values from 
> the persistent clock.

That's my guess as well.

> Could you try with the following patch against Linus' HEAD? I suspect it 
> will let the box resume (although it will seem as though no time was 
> spent in resume) and then let me know what the JDB lines print out?

JDB: suspend_time: 1345491706:0  resume_time: 1345491737:0
JDB: Trying to add: 31:0

(Looks reasonable.)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
