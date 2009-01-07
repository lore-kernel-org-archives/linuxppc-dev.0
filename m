Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 510BEDE4B9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 15:04:23 +1100 (EST)
Date: Wed, 7 Jan 2009 07:04:20 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/7] powerpc/64/kdump: Use ppc_save_regs() in
	crash_setup_regs()
Message-ID: <20090107040420.GA19317@oksana.dev.rtsoft.ru>
References: <20081217200610.GA31887@oksana.dev.rtsoft.ru>
	<20081217200935.GG4624@oksana.dev.rtsoft.ru>
	<1231298165.14860.56.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1231298165.14860.56.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 07, 2009 at 02:16:05PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2008-12-17 at 23:09 +0300, Anton Vorontsov wrote:
> > The patch replaces internal registers dump implementation with
> > ppc_save_regs(). From now on PPC64 and PPC32 are using the same
> > code for crash_setup_regs().
> > 
> > NOTE: The old regs dump implementation was capturing SP (r1) directly
> > as is, so you could see crash_kexec() function on top of the back-trace.
> > But ppc_save_regs() goes up one stack frame, so you'll not see it
> > anymore, at the top-level you'll see who actually triggered the crash
> > dump instead.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> 
> Note that ppc_save_regs() for some obscure reason isn't saving r1...
> 
> Is that a problem for you ? I think we should fix ppc_save_regs()
> anyway, it doesn't matter for xmon to save one more register and it will
> avoid nasty surprises in the long run.

AFAICS it saves r1:

       PPC_STL r0,0*SZL(r3)
       PPC_STL r2,2*SZL(r3)
       PPC_STL r3,3*SZL(r3)
       ...
       /* go up one stack frame for SP */
       PPC_LL  r4,0(r1)
       PPC_STL r4,1*SZL(r3)

This fact is mentioned in the patch description:

 NOTE: The old regs dump implementation was capturing SP (r1) directly
 as is, so you could see crash_kexec() function on top of the back-trace.
 But ppc_save_regs() goes up one stack frame, so you'll not see it
 anymore, at the top-level you'll see who actually triggered the crash
 dump instead.

Do you see anything wrong in such behaviour?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
