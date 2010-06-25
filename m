Return-Path: <kyle@moffetthome.net>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by ozlabs.org (Postfix) with ESMTP id 58660B6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Jun 2010 14:03:11 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id e21so122146fga.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Jun 2010 21:03:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTilxKwgVu_XdO3UwRtiRo1S9xJJuaeCsA7MyNOVn@mail.gmail.com>
References: <AANLkTilxKwgVu_XdO3UwRtiRo1S9xJJuaeCsA7MyNOVn@mail.gmail.com>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Fri, 25 Jun 2010 00:02:48 -0400
Message-ID: <AANLkTimdcD_nAKZzPhZzOQo1v4fwVgIYDhHMzc7zrGX1@mail.gmail.com>
Subject: Re: New P2020-based board (mpc85xx) gets "Processor 1 is stuck" on
	2.6.34, not on 2.6.32
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oops, put the old linuxppc list on the CC, sorry!

On Thu, Jun 24, 2010 at 23:32, Kyle Moffett <kyle@moffetthome.net> wrote:
> Hello,
>
> I'm working on a new board port for a P2020-based board, and I'm
> having problems with my second core not starting up on 2.6.34, even
> though it starts up fine on 2.6.32.
>
> In adding various debugs to mpc85xx_kick_cpu(), it looks like the
> virtual address is detected as 0x7ffff280 on both, and it seems to
> ioremap it to the same address. =C2=A0Furthermore, both of them get the
> "ack" from the other CPU almost immediately (within 1ms).
> Unfortunately, after that the second core fails to rendezvous
> elsewhere in the SMP code and as a result I get "Processor 1 is
> stuck".
>
> Unfortunately I've had no luck looking through "git log
> v2.6.32..v2.6.34 -- arch/powerpc/" by hand, and there are enough
> mechanical merge conflicts with my patchset to make "bisection" very
> painful (IE: git bisect, git cherry-pick, test, git reset --hard
> HEAD^, repeat)
>
> Any additional suggestions on where to look would be much appreciated.
>
> Cheers,
> Kyle Moffett
>
