Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1F880B70CB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 09:30:36 +1100 (EST)
Subject: Re: [RFC] [PATCH] allow low HZ values?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tim Pepper <lnxninja@linux.vnet.ibm.com>
In-Reply-To: <20101011201121.GA953@tpepper-t61p.dolavim.us>
References: <20101011201121.GA953@tpepper-t61p.dolavim.us>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Oct 2010 09:30:12 +1100
Message-ID: <1286836212.5220.19.camel@pasglop>
Mime-Version: 1.0
Cc: Marcio Saito <marcio@cyclades.com>, Jiri Slaby <jirislaby@gmail.com>,
	John Stultz <johnstul@us.ibm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	Avantika Mathur <mathur@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-10-11 at 13:11 -0700, Tim Pepper wrote:
> I'm not necessarily wanting to open up the age old question of "what is
> a good HZ", but we were doing some testing on timer tick overheads for
> HPC applications and this came up...

Note that this is also very useful when working on CPU prototypes
implemented in FPGAs and running at something like 12Mhz :-)

Cheers,
Ben.

> Below is a minimal hack at enabling lower HZ values.  The kernel builds
> and boots for me on x86_64 (simple laptop and kvm configs) and ppc64
> (misc. IBM System p) with each of the added HZ options.
> 
> There's explicit code checking HZ down to 12, but HZ<100 wasn't a config
> option.  We collected some data at 10, 12 and 25.  There'd been some
> question of whether 10 would even work or not but it looks fine in the
> relatively minimal testing we did.  We tried 12 since the code seemed
> to allow for it.  And 25 as a "safe" lower value.  The only difference
> observed under load (ie: no no idle HZ in play) was the expected timer
> tick happening less often.  There was definitely surprise that nothing
> else seemed to break anywhere, especially at 10.
> 
> Do people feel it is reasonable to have Kconfig bits to allow some lower
> HZ values?
> 
> If so, then there's the question of what breaks.  It's reasonable to
> think there are other going to be subtleties buried in code around
> assumptions on the likely range of HZ:
> 
> - I'm not sure that what I did in inet_timewait_sock.h and jiffies.h is
>   reasonable.
> - arch/x86/kernel/i8253.c throws a warning at line 43 (v2.6.36-rc7):
>       warning: large integer implicitly truncated to unsigned type
> - drivers/char/cyclades.c's cy_ioctl() warns:
>       drivers/char/cyclades.c:2761: warning: division by zero
> - drivers, drivers, drivers across all the arch's could use sanity checking
> 
