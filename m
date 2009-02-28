Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A9936DDDA0
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 04:24:29 +1100 (EST)
Date: Sat, 28 Feb 2009 09:23:36 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
In-Reply-To: <20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
Message-ID: <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mips@linux-mips.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Fri, 27 Feb 2009, Roland McGrath wrote:
> 
> I don't know any other arch well enough to be sure that TIF_32BIT isn't the
> wrong test there too.  I'd like to leave that worry to the arch maintainers.

Agreed - it may be that others will want to not use TIF_32BIT too. It 
really does make much more sense to have it as a thread-local status flag 
than as an atomic (and thus expensive to modify) thread-flag, not just on 
x86.

But I think other architectures will find it easier to see what's going on 
if the code is straightforward and they can just fix their 
'is_compat_task()' function. And:

> But here is the patch you asked for.

Yes, this looks much more straightforward. 

And I guess the seccomp interaction means that this is potentially a 
2.6.29 thing. Not that I know whether anybody actually _uses_ seccomp. It 
does seem to be enabled in at least Fedora kernels, but it might not be 
used anywhere.

		Linus
