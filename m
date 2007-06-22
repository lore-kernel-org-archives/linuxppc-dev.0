Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 4A8BEDDEC0
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 16:10:48 +1000 (EST)
Date: Fri, 22 Jun 2007 16:10:47 +1000
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC] clocksouce implementation for powerpc
Message-ID: <20070622061047.GW9768@bakeyournoodle.com>
References: <20070616101126.296384219@inhelltoy.tec.linutronix.de>
	<20070616101637.107940593@inhelltoy.tec.linutronix.de>
	<1182009083.11539.369.camel@imap.mvista.com>
	<20070620065710.GR9768@bakeyournoodle.com>
	<46795B9B.2020401@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <46795B9B.2020401@ru.mvista.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: Andrew Morton <akpm@osdl.org>, Daniel Walker <dwalker@mvista.com>,
	john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2007 at 08:53:47PM +0400, Sergei Shtylyov wrote:

Hi Sergei,
	Thanks for taking the time to look over my patch.

>    I guess it's been based on the prior work by John Stultz (and me too :-)?

At some level I guess so.  John did send me a patch a while ago.
 
>    If you mean the init. part, this has been already done by me -- I've 
> implemented read_persistent_clock() and got rid of xtime setting. What's 
> left is to implemet update_persistent_clock() and get rid of 
> timer_check_rtc()...

Actually I think that comment is redundant.  and should be removed
sorry.

>    Perhaps we even need to raise the rating to 300 or 400 -- according to 
> what <linux/clocksource.h> says?

Sure.
 
> >+	.flags        = CLOCK_SOURCE_IS_CONTINUOUS,
> >+	.mask         = CLOCKSOURCE_MASK(64),
> >+	.shift        = 22,
> 
>    PPC64 has issues with the fixed shift value, see:
> 
> http://patchwork.ozlabs.org/linuxppc/patch?id=11125

Thanks!
 
> >+	.mult         = 0,	/* To be filled in */
> >+	.read         = NULL,   /* To be filled in */
> >+	.settimeofday = NULL,   /* To be filled in */
> 
>    I don't quite understand why not just init them right away?  The values 
> are fixed anyways.

Well at least mult needs to be calculated at runtime, and I prefer to
have the structure near the top of the file at which stage the
read/settimeofday functions aren't defined.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
