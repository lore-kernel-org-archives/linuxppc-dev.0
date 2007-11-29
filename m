Return-Path: <nish.aravamudan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 2CE98DDDE6
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 12:36:18 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so1871822nfd
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 17:36:17 -0800 (PST)
Message-ID: <29495f1d0711281736if4bd8b0wc77d3beb39cb1284@mail.gmail.com>
Date: Wed, 28 Nov 2007 17:36:17 -0800
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: [PATCH 1/2] powerpc: add hugepagesz boot-time parameter
In-Reply-To: <20071128132816.542fa4df.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <474CF68E.1040709@us.ibm.com>
	<20071128132816.542fa4df.randy.dunlap@oracle.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>, kniht@linux.vnet.ibm.com,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/28/07, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> On Tue, 27 Nov 2007 23:03:10 -0600 Jon Tollefson wrote:
>
> > This patch adds the hugepagesz boot-time parameter for ppc64 that lets
> > you pick the size for your huge pages.  The choices available are 64K
> > and 16M.  It defaults to 16M (previously the only choice) if nothing or
> > an invalid choice is specified.  Tested 64K huge pages with the
> > libhugetlbfs 1.2 release with its 'make func' and 'make stress' test
> > invocations.
> >
> > This patch requires the patch posted by Mel Gorman that adds
> > HUGETLB_PAGE_SIZE_VARIABLE; "[PATCH] Fix boot problem with iSeries
> > lacking hugepage support" on 2007-11-15.
> >
> > Signed-off-by: Jon Tollefson <kniht@linux.vnet.ibm.com>
> > ---
> >
> >  Documentation/kernel-parameters.txt |    1
> >  arch/powerpc/mm/hash_utils_64.c     |   11 +--------
> >  arch/powerpc/mm/hugetlbpage.c       |   41 ++++++++++++++++++++++++++++++++++++
> >  include/asm-powerpc/mmu-hash64.h    |    1
> >  mm/hugetlb.c                        |    1
> >  5 files changed, 46 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> > index 33121d6..2fc1fb8 100644
> > --- a/Documentation/kernel-parameters.txt
> > +++ b/Documentation/kernel-parameters.txt
> > @@ -685,6 +685,7 @@ and is between 256 and 4096 characters. It is defined in the file
> >                       See Documentation/isdn/README.HiSax.
> >
> >       hugepages=      [HW,X86-32,IA-64] Maximal number of HugeTLB pages.
> > +     hugepagesz=     [HW,IA-64,PPC] The size of the HugeTLB pages.
>
> Any chance of spelling it as "hugepagesize" so that it's a little
> less cryptic and more difficult to typo as "hugepages"?
> (i.e., less confusion between them)

It already exists as hugepagesz= for IA64. Changing it to hugepagesize
would either make ppc be different than IA64, or require keeping both
so as to make IA64 setups continue working as before?

Thanks,
Nish
