Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJXTD5GhzzDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 09:12:32 +1000 (AEST)
Message-ID: <1464649951.16938.5.camel@ellerman.id.au>
Subject: Re: [PATCH V10 00/28] Add new powerpc specific ELF core notes
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, davem@davemloft.net, peterz@infradead.org,
 palves@redhat.com, shuahkh@osg.samsung.com, oleg@redhat.com,
 dhowells@redhat.com,  Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com,
 tglx@linutronix.de,  davej@redhat.com, akpm@linux-foundation.org,
 sukadev@linux.vnet.ibm.com,  emachado@linux.vnet.ibm.com,
 sam.bobroff@au1.ibm.com, cyrilbur@gmail.com
Date: Tue, 31 May 2016 09:12:31 +1000
In-Reply-To: <5748004F.7040408@linux.vnet.ibm.com>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <57062722.5090706@linux.vnet.ibm.com>
 <5EA48413-85A1-4CB7-8843-CE22B2BB1F08@ellerman.id.au>
 <570B54EB.90507@linux.vnet.ibm.com>
 <1460524468.30704.5.camel@ellerman.id.au>
 <5718F901.6010104@linux.vnet.ibm.com> <5748004F.7040408@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-05-27 at 10:07 +0200, Laurent Dufour wrote:

> On 21/04/2016 18:00, Laurent Dufour wrote:

> > On 13/04/2016 07:14, Michael Ellerman wrote:

> > > On Mon, 2016-04-11 at 09:40 +0200, Laurent Dufour wrote:

> > > > On 07/04/2016 23:49, Michael Ellerman wrote:

> > > > > On 7 April 2016 7:23:46 pm AEST, Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:

> > > > > > This series is required to handle TM state in CRIU.
> > > > > > Is there a chance to get it upstream soon ?
> > > > > 
> > > > > We were waiting on the gdb support to make sure it had some testing. If it's working for CRIU that would be a good data point, have you actually tested it with CRIU?
> > > > 
> > > > I just started integrating it in CRIU, my basic tests didn't report any
> > > > issue with the new ptrace API, but I can't state that it is bug free ;)
> > > 
> > > Sure. But if it's working for CRIU that's at least postive :)
> > 
> > I did additional tests and the Anshuman's series is working fine for
> > CRIU's support with the attached patch applied.
> > 
> > Michael, could you please applied the attached patch among the
> > Anshuman's series ?
> 
> Hi Michael,
> 
> Is there any chance we get this series pushed in 4.7 ?

Hi Laurent,

Sorry no. My next branch closed for 4.7 about 3 weeks ago.

This series has been blocked for a long time on the gdb support, but that is
now working. However it still doesn't pass its own selftests, and I had some
disagreements with the implementation - it duplicates a lot of code rather
than refactoring things.

I'm waiting on a patch from Cyril which will rework how the TM FP state is
handled, and that should make this series easier to implement.

The plan is that both should go into 4.8.

cheers
