Return-Path: <richardcochran@gmail.com>
Received: from mail-wi0-x22d.google.com (mail-wi0-x22d.google.com
 [IPv6:2a00:1450:400c:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1FA41A0D2B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 20:11:24 +1000 (AEST)
Received: by widdi4 with SMTP id di4so171354914wid.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 03:11:21 -0700 (PDT)
Date: Wed, 22 Apr 2015 12:11:14 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Y2038] [PATCH 04/11] posix timers:Introduce the 64bit methods
 with timespec64 type for k_clock structure
Message-ID: <20150422101114.GA5527@localhost.localdomain>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
 <3231171.5TrYVVBLh4@wuerfel>
 <alpine.DEB.2.11.1504211701140.13914@nanos>
 <2819798.f0KhjY3UAe@wuerfel>
 <alpine.DEB.2.11.1504212204130.13914@nanos>
 <alpine.DEB.2.11.1504220946460.13914@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.11.1504220946460.13914@nanos>
Cc: pang.xunlei@linaro.org, Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 cl@linux.com, Ingo Molnar <mingo@kernel.org>, heenasirwani@gmail.com,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, y2038@lists.linaro.org,
 rafael.j.wysocki@intel.com, ahh@google.com,
 Frederic Weisbecker <fweisbec@gmail.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, pjt@google.com,
 riel@redhat.com, Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
 John Stultz <john.stultz@linaro.org>, rth@twiddle.net,
 Baolin Wang <baolin.wang@linaro.org>, gregkh@linuxfoundation.org,
 LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 22, 2015 at 10:45:23AM +0200, Thomas Gleixner wrote:
> So we could save one translation step if we implement new syscalls
> which have a scalar nsec interface instead of the timespec/timeval
> cruft and let user space do the translation to whatever it wants.

+1

> I personally would welcome such an interface as it makes user space
> programming simpler. Just (re)arming a periodic nanosleep based on
> absolute expiry time is horrible stupid today:

Jup.

> Thoughts?

Current user space example: The linuxptp programs are doing ns64 to
timespec conversions to call into the kernel, which then does timespec
to ns64 to talk to the hardware.  I would bet that most (all?) use
cases are better served with 64 bit nanosecond system calls.

Thanks,
Richard
