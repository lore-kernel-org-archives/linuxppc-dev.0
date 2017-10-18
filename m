Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
 [66.63.167.143])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHH814wyfzDrSV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 03:09:52 +1100 (AEDT)
Message-ID: <1508342988.3958.5.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/4] char-TPM: Adjustments for ten function implementations
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, Dan Carpenter
 <dan.carpenter@oracle.com>, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Jerry Snitselaar
 <jsnitsel@redhat.com>, Kenneth Goldman <kgold@linux.vnet.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.vnet.ibm.com>, Paul
 Mackerras <paulus@samba.org>, Peter =?ISO-8859-1?Q?H=FCwe?=
 <PeterHuewe@gmx.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Wed, 18 Oct 2017 09:09:48 -0700
In-Reply-To: <20171018151010.r4ojcpzs5l7rpt6r@linux.intel.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
 <20171017085124.pkrjzghcf5wmcydc@mwanda>
 <f9b35a67-bd7f-b140-bdc1-cb4886a6b1ea@users.sourceforge.net>
 <1508255833.3129.33.camel@HansenPartnership.com>
 <20171018151010.r4ojcpzs5l7rpt6r@linux.intel.com>
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

On Wed, 2017-10-18 at 18:10 +0300, Jarkko Sakkinen wrote:
> On Tue, Oct 17, 2017 at 08:57:13AM -0700, James Bottomley wrote:
> > 
> > On Tue, 2017-10-17 at 11:25 +0200, SF Markus Elfring wrote:
> > > 
> > > > 
> > > > 
> > > > Fixes is only for bug fixes.  These don't fix any bugs.
> > > 
> > > How do you distinguish these in questionable source code
> > > from other error categories or software weaknesses?
> > 
> > A style change is one that doesn't change the effect of the
> > execution.
> >  These don't actually even change the assembly, so there's
> > programmatic
> > proof they're not fixing anything.
> > 
> > Bug means potentially user visible fault.  In any bug fix commit
> > you
> > should document the fault and its effects on users so those
> > backporting
> > can decide if they care or not.
> > 
> > James
> 
> OK, I'll adjust my definition of a bug :-)

Subsystems are free to define bugs in any reasonable way.  However,
there are two things to note here:

   1. The style guide is just that, a guide; it's not hard and fast rules.
       That means that violations aren't bugs in the usual sense.
       However, new code should mostly follow it and if it doesn't, there
      should be a good reason to go against the guide which should be
      explained in the change log.
   2. The coding style evolves, so older drivers usually don't conform.
       Classifying coding style issues as bugs leads to tons of patches
      "fixing" older drivers, some of which actually end up breaking the
      drivers in subtle ways which take ages to be found (at least that's
      what we've seen in SCSI).

James
