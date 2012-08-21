Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 139D22C007B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 17:14:16 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 4/8] time: Condense timekeeper.xtime into xtime_sec
References: <1342156917-25092-1-git-send-email-john.stultz@linaro.org>
 <1342156917-25092-5-git-send-email-john.stultz@linaro.org>
 <m2fw7ilhnm.fsf@igel.home> <503288ED.10306@linaro.org>
 <m2fw7h4ab5.fsf@igel.home> <503296C1.4070906@linaro.org>
 <m2boi549ed.fsf@igel.home> <5033029A.2030201@linaro.org>
Date: Tue, 21 Aug 2012 09:14:06 +0200
In-Reply-To: <5033029A.2030201@linaro.org> (John Stultz's message of "Mon, 20
 Aug 2012 20:38:02 -0700")
Message-ID: <m2d32kemyp.fsf@igel.home>
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

> @@ -115,6 +115,7 @@ static void tk_xtime_add(struct timekeeper *tk, const struct timespec *ts)
>  {
>  	tk->xtime_sec += ts->tv_sec;
>  	tk->xtime_nsec += (u64)ts->tv_nsec << tk->shift;
> +	tk_normalize_xtime(tk);
>  }

Yes, that does it.  Failure to normalize is always bad.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
