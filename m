Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6E59CDE0DC
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 11:50:39 +1000 (EST)
Date: Thu, 10 Apr 2008 18:50:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] powerpc TLF_RESTORE_SIGMASK
Message-Id: <20080410185029.ef80d5f9.akpm@linux-foundation.org>
In-Reply-To: <20080411013635.1F4B126F992@magilla.localdomain>
References: <20080403210842.6C88C26F98D@magilla.localdomain>
	<20080409235156.33ee33f2.akpm@linux-foundation.org>
	<20080411013635.1F4B126F992@magilla.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 Apr 2008 18:36:35 -0700 (PDT) Roland McGrath <roland@redhat.com> wrote:

> > This crashes my powerpc mac g5.
> 
> It worked fine on mine.
> 
> > It happens after the boot, during the first login-over-ssh.
> 
> Mine did lots of stuff fine.
> 
> > This is with most of the rest of the -mm poopile applied.  i386 and x86_64
> > seem OK.
> 
> I had only tested with Linus's tree plus the small handful of post-2.6.25
> cleanup patches I've posted in the last few weeks.  To be precise it was
> 9597362d354f8655ece324b01d0c640a0e99c077 plus several of my cleanup patches
> (that are probably all in -mm, but I'm not sure off hand).
> 
> I'd rebased my tree today to 783e391b7b5b273cd20856d8f6f4878da8ec31b3
> anyway.  I just tried the new kernel with the sigmask cleanups and only 
> a few other patches, and have no problems.
> 
> The details of your crash make it look pretty unrelated to this code.
> Off hand I would guess that it's some other bug from other -mm patches
> that just happens only to bite you on powerpc.  If the crash is not
> intermittent and you bisected it to this one change, then I am at a
> loss to see what might be happening.  I'd have to leave it to Paul et
> al to figure out if there is some strange powerpc juju going on.

It's 100% repeatable and I bisected it to this change.

I expect you could repeat it by applying it to
http://userweb.kernel.org/~akpm/mmotm/ (or to -rc6-mm2, if I ever manage to
get it to boot on something) and using
http://userweb.kernel.org/~akpm/config-g5.txt
