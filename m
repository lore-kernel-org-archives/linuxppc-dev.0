Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGYTn5WKDzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 22:52:45 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9HBpJq1115140
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 07:52:43 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dngndt453-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 07:52:42 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 17 Oct 2017 12:52:40 +0100
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9HBqZcr26804330
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 11:52:37 GMT
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9HBqY0I024465
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 22:52:35 +1100
Subject: Re: [PATCH 0/4] char-TPM: Adjustments for ten function implementations
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Julia Lawall <julia.lawall@lip6.fr>, Dan Carpenter
 <dan.carpenter@oracle.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, SF Markus Elfring
 <elfring@users.sourceforge.net>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Jerry Snitselaar
 <jsnitsel@redhat.com>, Kenneth Goldman <kgold@linux.vnet.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.vnet.ibm.com>, Paul
 Mackerras <paulus@samba.org>, Peter =?ISO-8859-1?Q?H=FCwe?=
 <PeterHuewe@gmx.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Tue, 17 Oct 2017 07:52:26 -0400
In-Reply-To: <alpine.DEB.2.20.1710171211210.5035@hadrien>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
 <20171017085124.pkrjzghcf5wmcydc@mwanda>
 <alpine.DEB.2.20.1710171055100.5035@hadrien>
 <20171017094434.csarc5fw5d32u64w@mwanda>
 <alpine.DEB.2.20.1710171211210.5035@hadrien>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508241146.4234.16.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Julia,

On Tue, 2017-10-17 at 12:11 +0200, Julia Lawall wrote:
> 
> On Tue, 17 Oct 2017, Dan Carpenter wrote:
> 
> > On Tue, Oct 17, 2017 at 10:56:42AM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Tue, 17 Oct 2017, Dan Carpenter wrote:
> > >
> > > > On Mon, Oct 16, 2017 at 09:35:12PM +0300, Jarkko Sakkinen wrote:
> > > > >
> > > > > A minor complaint: all commits are missing "Fixes:" tag.
> > > > >
> > > >
> > > > Fixes is only for bug fixes.  These don't fix any bugs.
> > >
> > > 0-day seems to put Fixes for everything.  Should they be removed when the
> > > old code is undesirable but doesn't actually cause a crash, eg out of date
> > > API.
> >
> > Yeah, I feel like Fixes tags don't belong for API updates and cleanups.
> 
> OK, I will remove them from the patches that go through me where they
> don't seem appropriate.

The "Fixes" tag is an indication that the patch should be backported.
The requirements for what should be backported are pretty stringent. 

Mimi
