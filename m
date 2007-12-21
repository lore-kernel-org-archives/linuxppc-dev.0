Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: Time for cell code reshuffle?
Date: Fri, 21 Dec 2007 20:15:43 +0100
References: <200712211522.03841.arnd@arndb.de> <476BF67C.2030405@am.sony.com>
In-Reply-To: <476BF67C.2030405@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712212015.45088.arnd@arndb.de>
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

On Friday 21 December 2007, Geoff Levand wrote:
> Arnd Bergmann wrote:
>
> > arch/powerpc/platforms/cell/spufs -> arch/powerpc/spufs
> > arch/powerpc/platforms/cell/spu_{callbacks,base,syscalls,fault,notify}.[co]
> >  -> arch/powerpc/spufs/{callbacks,base,syscalls,fault,notify}.[co]
> 
> 
> I think we should consider support for SpursEngine.  At the moment I have no
> idea of what it needs, and if no one else does we need to find out.

Hmm, since there is not much documentation available for SpursEngine, it's
rather hard to tell what needs to be done for it.

If we think that it will hit the kernel anytime soon, we could use fs/spufs
instead of arch/powerpc/spufs right away. Interestingly, this is where it was
initially, but got moved to arch/powerpc/platforms/cell/spufs after a lot
of discussion ;-).

> It seems platforms/cell should have the shared and/or generic code, and the other
> stuff moved into a new platform directory, but is it worth the effort? 

There is very little code in platforms/cell that can not be generic, so I think
it's not worth splitting it. The only IBM blade specific files are
cbe_cpufreq_pmi.c and parts of setup.c and pervasive.c. Everything else could
be shared by about any generic implementation without a hypervisor.

	Arnd <><
