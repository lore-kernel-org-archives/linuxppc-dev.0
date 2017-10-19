Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHqFT5tJtzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 00:16:29 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9JDFJNZ082099
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 09:16:27 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpvps0fuv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 09:16:27 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 19 Oct 2017 14:16:24 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9JDGKBm24838144
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 13:16:22 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9JDGKRK023305
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 00:16:21 +1100
Subject: Re: [PATCH 0/4] char-TPM: Adjustments for ten function implementations
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Julia Lawall <julia.lawall@lip6.fr>,
 Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, SF Markus Elfring
 <elfring@users.sourceforge.net>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Jerry Snitselaar
 <jsnitsel@redhat.com>, Kenneth Goldman <kgold@linux.vnet.ibm.com>, Nayna
 Jain <nayna@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, Peter
 =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>, Stefan Berger
 <stefanb@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Thu, 19 Oct 2017 09:16:11 -0400
In-Reply-To: <87lgk9i1ni.fsf@concordia.ellerman.id.au>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
 <20171017085124.pkrjzghcf5wmcydc@mwanda>
 <alpine.DEB.2.20.1710171055100.5035@hadrien>
 <20171017094434.csarc5fw5d32u64w@mwanda>
 <alpine.DEB.2.20.1710171211210.5035@hadrien>
 <1508241146.4234.16.camel@linux.vnet.ibm.com>
 <87lgk9i1ni.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508418971.4510.134.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-10-18 at 14:18 +1100, Michael Ellerman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> > On Tue, 2017-10-17 at 12:11 +0200, Julia Lawall wrote:
> >> On Tue, 17 Oct 2017, Dan Carpenter wrote:
> >> > On Tue, Oct 17, 2017 at 10:56:42AM +0200, Julia Lawall wrote:
> >> > > On Tue, 17 Oct 2017, Dan Carpenter wrote:
> >> > > > On Mon, Oct 16, 2017 at 09:35:12PM +0300, Jarkko Sakkinen wrote:
> >> > > > >
> >> > > > > A minor complaint: all commits are missing "Fixes:" tag.
> >> > > > >
> >> > > >
> >> > > > Fixes is only for bug fixes.  These don't fix any bugs.
> >> > >
> >> > > 0-day seems to put Fixes for everything.  Should they be removed when the
> >> > > old code is undesirable but doesn't actually cause a crash, eg out of date
> >> > > API.
> >> >
> >> > Yeah, I feel like Fixes tags don't belong for API updates and cleanups.
> >> 
> >> OK, I will remove them from the patches that go through me where they
> >> don't seem appropriate.
> >
> > The "Fixes" tag is an indication that the patch should be backported.
> 
> No it's not that strong. It's an indication that the patch fixes another
> commit, which may or may not mean it should be backported depending on
> the preferences of the backporter. If it *does* need backporting then
> the Fixes tag helps identify where it should go.

Thank you for setting the record straight.

> The doco is actually pretty well worded IMO:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n183
> 
>   If your patch fixes a bug in a specific commit, e.g. you found an issue using
>   ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
>   the SHA-1 ID, and the one line summary.
> 
> and:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n602
> 
>   A Fixes: tag indicates that the patch fixes an issue in a previous commit. It
>   is used to make it easy to determine where a bug originated, which can help
>   review a bug fix. This tag also assists the stable kernel team in determining
>   which stable kernel versions should receive your fix. This is the preferred
>   method for indicating a bug fixed by the patch. See :ref:`describe_changes`
>   for more details.
> 
> 
> cheers
> 
