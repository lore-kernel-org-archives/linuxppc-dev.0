Return-Path: <drow@nevyn.them.org>
Received: from nevyn.them.org (nevyn.them.org [66.93.172.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE7DB68854
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2005 03:34:08 +1100 (EST)
Date: Tue, 29 Nov 2005 10:53:46 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: David Woodhouse <dwmw2@infradead.org>
Message-ID: <20051129155346.GA25431@nevyn.them.org>
References: <1133225007.31573.86.camel@baythorne.infradead.org>
	<1133225852.31573.115.camel@baythorne.infradead.org>
	<438BE48B.9060908@kolumbus.fi>
	<1133260923.31573.131.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1133260923.31573.131.camel@baythorne.infradead.org>
Cc: drepper@redhat.com, linuxppc-dev@ozlabs.org,
	Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3/3 Generic sys_rt_sigsuspend
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 29, 2005 at 10:42:03AM +0000, David Woodhouse wrote:
> I believe not. The previous versions would loop until do_signal()
> returned non-zero; i.e. until a signal was actually delivered.
> By returning -ERESTARTNOHAND we achieve the same effect. If there's a
> signal delivered, that gets magically converted to -EINTR, but if
> there's no signal delivered, the syscall gets restarted.

And, crazy coincidence, I think this will fix the recently reported
ptrace attach bug.  Right now if you ptrace a process stuck in
sigsuspend, you can't easily force it to return to userspace.
I'll test that if these patches are merged.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
