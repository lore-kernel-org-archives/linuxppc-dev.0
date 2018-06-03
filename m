Return-Path: <SRS0=GHQf=IV=linuxfoundation.org=gregkh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zCJQ4S48zF143
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Jun 2018 19:22:10 +1000 (AEST)
Date: Sun, 3 Jun 2018 11:21:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4.14 2/4] powerpc/mm/slice: create header files dedicated
 to slices
Message-ID: <20180603092145.GA10556@kroah.com>
References: <170bd2b5b5cb1e474599165e8f21f121225a2df9.1527755908.git.christophe.leroy@c-s.fr>
 <798b787d74d94b5d29f1c0279bad157b6b5df7ec.1527755908.git.christophe.leroy@c-s.fr>
 <20180602132107.GH31493@kroah.com>
 <f18dc860-6007-9955-8c73-25faf43097e8@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f18dc860-6007-9955-8c73-25faf43097e8@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 02, 2018 at 10:55:31PM +0200, Christophe Leroy wrote:
> 
> 
> On 06/02/2018 03:21 PM, Greg Kroah-Hartman wrote:
> > On Thu, May 31, 2018 at 08:54:52AM +0000, Christophe Leroy wrote:
> > > [ Upstream commit a3286f05bc5a5bc7fc73a9783ec89de78fcd07f8 ]
> > > 
> > > In preparation for the following patch which will enhance 'slices'
> > > for supporting PPC32 in order to fix an issue on hugepages on 8xx,
> > > this patch takes out of page*.h all bits related to 'slices' and put
> > > them into newly created slice.h header files.
> > > While common parts go into asm/slice.h, subarch specific
> > > parts go into respective books3s/64/slice.c and nohash/64/slice.c
> > > 'slices'
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > > ---
> > >   arch/powerpc/include/asm/book3s/64/slice.h | 27 ++++++++++++++
> > >   arch/powerpc/include/asm/nohash/64/slice.h | 12 ++++++
> > >   arch/powerpc/include/asm/page.h            |  1 +
> > >   arch/powerpc/include/asm/page_64.h         | 59 ------------------------------
> > >   arch/powerpc/include/asm/slice.h           | 40 ++++++++++++++++++++
> > >   5 files changed, 80 insertions(+), 59 deletions(-)
> > >   create mode 100644 arch/powerpc/include/asm/book3s/64/slice.h
> > >   create mode 100644 arch/powerpc/include/asm/nohash/64/slice.h
> > >   create mode 100644 arch/powerpc/include/asm/slice.h
> > 
> > This patch does not apply :(
> 
> I tried again, it applies well for me:
> 
> [root@localhost linux-stable]# git checkout v4.14.47 -b 4.14.47
> Checking out files: 100% (27111/27111), done.
> Switched to a new branch '4.14.47'
> [root@localhost linux-stable]# git am /root/Downloads/4.14-1-4-powerpc-mm-slice-Remove-intermediate-bitmap-copy.patch
> 
> Applying: powerpc/mm/slice: Remove intermediate bitmap copy
> Applying: powerpc/mm/slice: create header files dedicated to slices
> Applying: powerpc/mm/slice: Enhance for supporting PPC32
> Applying: powerpc/mm/slice: Fix hugepage allocation at hint address on 8xx
> [root@localhost linux-stable]#
> 
> > 
> > Can you fix this series up and resend the whole thing?
> 
> Is there any conflicting patch in the queue ?
> What should I rebase on ?

Ah, the problem is I was taking the upstream version of this patch, not
your backported one.  Next time be a bit more specific and say you
changed something here, otherwise I will always default to what is in
Linus's tree.

Let me go work on this again...

thanks,

greg k-h
