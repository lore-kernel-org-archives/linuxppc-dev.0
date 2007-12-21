Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <476BF67C.2030405@am.sony.com>
Date: Fri, 21 Dec 2007 09:23:08 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Time for cell code reshuffle?
References: <200712211522.03841.arnd@arndb.de>
In-Reply-To: <200712211522.03841.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> We've been discussing in the past a few times where we should best put
> the spufs code, and when to do it. Since Jeremy and I now have all the
> current patches in powerpc.git, maybe we should do it now.
> 
> To the question, where what it should go, I'd leave the decision to
> Jeremy, but my current idea would be:
> 
> arch/powerpc/platforms/cell/spufs -> arch/powerpc/spufs
> arch/powerpc/platforms/cell/spu_{callbacks,base,syscalls,fault,notify}.[co]
>  -> arch/powerpc/spufs/{callbacks,base,syscalls,fault,notify}.[co]


I think we should consider support for SpursEngine.  At the moment I have no
idea of what it needs, and if no one else does we need to find out.


> If we do it in git now, that should result in a minimal breakage of patches.
> 
> A related question is what to do about the location of the other cell
> related files. platforms/ps3 is already pretty self-contained once we have
> spufs outside of platforms/cell, but there is still some code shared between
> platforms/cell and platforms/celleb, and each of these directories also contains
> code that is only relevant for a subset of the platforms.


It seems platforms/cell should have the shared and/or generic code, and the other
stuff moved into a new platform directory, but is it worth the effort? 

-Geoff
