Return-Path: <dan.carpenter@oracle.com>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHppX2gWfzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 23:56:36 +1100 (AEDT)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v9JCuWTV008353
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 12:56:33 GMT
Date: Thu, 19 Oct 2017 15:55:59 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Doug Ledford <dledford@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johan Hovold <johan@kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh@kernel.org>,
 Sahil Mehta <sahilmehta17@gmail.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] powerpc-pseries: Delete an unnecessary variable
 initialisation in iommu_pseries_alloc_group()
Message-ID: <20171019125558.itidc4ejr6goadci@mwanda>
References: <0d221be4-1402-0499-d95e-afa4a30e1f33@users.sourceforge.net>
 <9c71e3e0-8998-fd02-e3a3-ef219d82ee32@users.sourceforge.net>
 <20171019133718.5bdab33c@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171019133718.5bdab33c@kitsune.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 19, 2017 at 01:37:18PM +0200, Michal Suchánek wrote:
> Hello,
> 
> On Wed, 18 Oct 2017 21:24:25 +0200
> SF Markus Elfring <elfring@users.sourceforge.net> wrote:
> 
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 18 Oct 2017 19:14:39 +0200
> > 
> > The variable "table_group" will be set to an appropriate pointer.
> > Thus omit the explicit initialisation at the beginning.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  arch/powerpc/platforms/pseries/iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c
> > b/arch/powerpc/platforms/pseries/iommu.c index
> > b37d4fb20d1c..b6c12b8e3ace 100644 ---
> > a/arch/powerpc/platforms/pseries/iommu.c +++
> > b/arch/powerpc/platforms/pseries/iommu.c @@ -55,7 +55,7 @@
> >  
> >  static struct iommu_table_group *iommu_pseries_alloc_group(int node)
> >  {
> > -	struct iommu_table_group *table_group = NULL;
> > +	struct iommu_table_group *table_group;
> >  	struct iommu_table *tbl = NULL;
> >  	struct iommu_table_group_link *tgl = NULL;
> >  
> 
> I think initializing pointers to NULL is generally a good idea.
> 
> If there is no use of the variable before it is reinitialized by
> allocation gcc is free to optimize out the variable and its initial
> value.
> 
> On the other hand, if the code is changed later and use of the variable
> becomes possible you may crash (and get a gcc warning, too).

No, it's the opposite. GCC doesn't warn about potential NULL
dereferences, it warns about uninitialized variables.  By initializing
it to a bogus value, you're deliberately disabling static analysis.
We do see bugs where, if only people didn't initialize stuff to bogus
values, then the bug would have been caught before it was merged.

You might imagine that static analysis tools would catch NULL
dereferences but it's actually really really hard.  We used to have
an __uninitialized_var() macro which was used to silence GCC false
positives, but now we initialize the pointers to NULL instead.  So
most of the code that you're dealing with is stuff that was marked as
too hard for GCC to understand.  It's tricky.

regards,
dan carpenter
