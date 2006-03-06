Return-Path: <olh@suse.de>
Date: Mon, 6 Mar 2006 20:38:17 +0100
From: Olaf Hering <olh@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] change compat shmget size arg to signed
Message-ID: <20060306193817.GA3214@suse.de>
References: <20060224101644.548b0c24.sfr@canb.auug.org.au>
	<20060223232717.GB29454@suse.de>
	<20060224111242.08f14bd9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060224111242.08f14bd9.sfr@canb.auug.org.au>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Feb 24, Stephen Rothwell wrote:

> On Fri, 24 Feb 2006 00:27:17 +0100 Olaf Hering <olh@suse.de> wrote:
> >
> >  On Fri, Feb 24, Stephen Rothwell wrote:
> > 
> > > Does the ltp test fail on a standard kernel(where SHMMAX is 0x2000000), or
> > > only on a SLES kernel (where SHMMAX is ULONG_MAX)?
> > 
> > It fails with SLES9 and SLES10. SLES9 has 0x2000000 as default.
> 
> So what was shm_ctlmax set to when the test was run.
> 
> I am trying to figure out why this test:
> 
> if (size < SHMMIN || size > shm_ctlmax)
>                 return -EINVAL;
> 
> Doesn't return -EINVAL for size == 0xffffffff if shm_ctlmax is 0x2000000?

shm_ctlmax is a sysctrl, so it can have anything. The ltp test is
invalid. shmget02 dos not fail after:
echo $(( 0x2000000 )) > /proc/sys/kernel/shmmax 
