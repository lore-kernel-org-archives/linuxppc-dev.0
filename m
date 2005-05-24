Return-Path: <mlei30@yahoo.com>
Received: from web61025.mail.yahoo.com (web61025.mail.yahoo.com
	[209.73.179.19]) by ozlabs.org (Postfix) with SMTP id 2B859679FD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 May 2005 08:30:05 +1000 (EST)
Message-ID: <20050524223004.64081.qmail@web61025.mail.yahoo.com>
Date: Tue, 24 May 2005 15:30:03 -0700 (PDT)
From: ming lei <mlei30@yahoo.com>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MMUCR on ppc440 GP/GX
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Matt,

At your suggestion, I downloaded the latest
linuxppc_2_4_devel source code and also checked the
online code repository, and found this link:

http://ppc.bkbits.net:8080/linuxppc_2_4_devel/diffs/arch/ppc/kernel/head_440.S@1.4?nav=index.html|src/.|src/arch|src/arch/ppc|src/arch/ppc/kernel|hist/arch/ppc/kernel/head_440.S

which was submitted 4 years ago with comments as "Fix
MMUCR/tlbsx handling and set TS corrently in TLB
entries".

If this is the one you talked about the fix three
years ago, fortunately my ppc440 code already has the
fix, I compared it with latest linuxppc_2_4_devel
source code and it's the same.

I think the problem I have now is different, it's the
icbi call from user space code that caused DataStorage
exception if the corresponding bit in MMUCR is set,
however, ppc440 code doesnt handle it.

Any thought, or correction?

Thanks
Ming


--- Matt Porter <mporter@kernel.crashing.org> wrote:
> On Tue, May 24, 2005 at 11:36:50AM -0700, ming lei
> wrote:
> > 
> > what's the latest ppc440 linux code that I can
> take
> > look at?
> 
> Grab the current kernel.org 2.6 release. I suggest
> you use
> dirdiff another recent 2.4 kernel and then analyze
> the 2.6 stuff
> as it is different yet.  There are countless bug
> fixes that have
> gone in over the last 3 years.  I sincerely hope you
> aren't
> trying to use that old kernel with experimental
> PPC440 support
> for production work.
>  
> > BTW, what's the problem three years ago prompted
> to
> > change the code regarding mmucr handling?
> 
> The problem was that the initial code would crash
> apps regularly. I
> put the code out in our development tree at the time
> since it was
> taking a long time to find the bug...and you could
> mostly run a
> system.  The MMUCR was not having the TID set
> properly during
> a tlbie() and a couple other spots in head_440.S.
> 
> -Matt
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
