Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sL4nt3yWnzDrcM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 12:32:33 +1000 (AEST)
Message-ID: <1472178736.25630.288.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Alessio Igor Bogani
 <alessio.bogani@elettra.eu>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 25 Aug 2016 21:32:16 -0500
In-Reply-To: <b843cd6d-b9df-a5b2-4015-042c7894313f@c-s.fr>
References: <CAPk1OjHu7SZ_eOrUx5MQGBTenKAQCUENFeYWVyqWoemqnvo7eA@mail.gmail.com>
 <1468965129.25630.15.camel@buserror.net>
 <601d732a-a137-3ba9-550d-19c7eb10337a@c-s.fr>
 <ed8c66dd-c567-35df-4a51-6bb3434fdc2b@c-s.fr>
 <CAPk1OjGR0gTAXvSUw=QUqkOrOZbmXCnd71Fu0mm5Pfrg46uc5w@mail.gmail.com>
 <b843cd6d-b9df-a5b2-4015-042c7894313f@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Suspected regression?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-08-23 at 13:34 +0200, Christophe Leroy wrote:
> 
> Le 23/08/2016 à 11:20, Alessio Igor Bogani a écrit :
> > 
> > Hi Christophe,
> > 
> > Sorry for delay in reply I was on vacation.
> > 
> > On 6 August 2016 at 11:29, christophe leroy <christophe.leroy@c-s.fr>
> > wrote:
> > > 
> > > Alessio,
> > > 
> > > 
> > > Le 05/08/2016 à 09:51, Christophe Leroy a écrit :
> > > > 
> > > > 
> > > > 
> > > > 
> > > > Le 19/07/2016 à 23:52, Scott Wood a écrit :
> > > > > 
> > > > > 
> > > > > On Tue, 2016-07-19 at 12:00 +0200, Alessio Igor Bogani wrote:
> > > > > > 
> > > > > > 
> > > > > > Hi all,
> > > > > > 
> > > > > > I have got two boards MVME5100 (MPC7410 cpu) and MVME7100
> > > > > > (MPC8641D
> > > > > > cpu) for which I use the same cross-compiler (ppc7400).
> > > > > > 
> > > > > > I tested these against kernel HEAD to found that these don't boot
> > > > > > anymore (PID 1 crash).
> > > > > > 
> > > > > > Bisecting results in first offending commit:
> > > > > > 7aef4136566b0539a1a98391181e188905e33401
> > > > > > 
> > > > > > Removing it from HEAD make boards boot properly again.
> > > > > > 
> > > > > > A third system based on P2010 isn't affected at all.
> > > > > > 
> > > > > > Is it a regression or I have made something wrong?
> > > > > 
> > > > > I booted both my next branch, and Linus's master on MPC8641HPCN and
> > > > > didn't see
> > > > > this -- though possibly your RFS is doing something
> > > > > different.  Maybe
> > > > > that's
> > > > > the difference with P2010 as well.
> > > > > 
> > > > > Is there any way you can debug the cause of the crash?  Or send me a
> > > > > minimal
> > > > > RFS that demonstrates the problem (ideally with debug symbols on the
> > > > > userspace
> > > > > binaries)?
> > > > > 
> > > > I got from Alessio the below information:
> > > > 
> > > > systemd[1]: Caught <BUS>, core dump failed (child 137, code=killed,
> > > > status=7/BUS).
> > > > systemd[1]: Freezing execution.
> > > > 
> > > > 
> > > > What can generate SIGBUS ?
> > > > And shouldn't we also get some KERN_ERR trace, something like
> > > > "unhandled
> > > > signal 7 at ....." ?
> > > > 
> > > As far as I can see, SIGBUS is mainly generated from alignment
> > > exception.
> > > According to 7410 Reference Manual, alignment exception can happen in
> > > the
> > > following cases:
> > > * An operand of a dcbz instruction is on a page that is write-through or
> > > cache-inhibited for a virtual mode access.
> > > * An attempt to execute a dcbz instruction occurs when the cache is
> > > disabled
> > > or locked.
> > > 
> > > Could try with below patch to check if the dcbz insn is causing the
> > > SIGBUS ?
> > Unfortunately that patch doesn't solve the problem.
> > 
> > Is there a chance that cache behavior could settled by board firmware
> > (PPCBug on the MPC7410 board and MotLoad on the MPC8641D one)?
> > In that case what do you suggest me to looking for?
> If the removal of dcbz doesn't solve the issue, I don't think it is a 
> cache related issue.
> As far as I understood, your init gets a SIGBUS signal, right ? Then we 
> must identify the reason for that sigbus.

My guess would be errors demand-loading a page via NFS.

One approach might be to hack up the code so that both versions of
csum_partial_copy_generic() are present, and call both each time.  If the
results differ or the copied bytes are wrong, then spit out a dump of the
details.

-Scott
