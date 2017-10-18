Return-Path: <julia.lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHCf448JLzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 00:32:07 +1100 (AEDT)
Date: Wed, 18 Oct 2017 15:32:00 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: David Laight <David.Laight@ACULAB.COM>
cc: 'SF Markus Elfring' <elfring@users.sourceforge.net>,
 Joe Perches <joe@perches.com>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Alexander Steffen <Alexander.Steffen@infineon.com>,
 Nayna Jain <nayna@linux.vnet.ibm.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Julia Lawall <julia.lawall@lip6.fr>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Kenneth Goldman <kgold@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 =?ISO-8859-15?Q?Peter_H=FCwe?= <PeterHuewe@gmx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: Adjusting further size determinations?
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD009ACE3@AcuExch.aculab.com>
Message-ID: <alpine.DEB.2.20.1710181531130.15834@hadrien>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
 <20171017085124.pkrjzghcf5wmcydc@mwanda>
 <f9b35a67-bd7f-b140-bdc1-cb4886a6b1ea@users.sourceforge.net>
 <1508255833.3129.33.camel@HansenPartnership.com>
 <1508280210.6530.32.camel@perches.com>
 <bf7fc26c-bdc9-c752-72c7-f44c22f4a328@users.sourceforge.net>
 <1508318326.6806.1.camel@perches.com>
 <026d582729b849b780fbaa06fb8bc79e@infineon.com>
 <alpine.DEB.2.20.1710181154390.3524@hadrien>
 <1508322510.6806.3.camel@perches.com>
 <ab5730c4-fb69-4791-a2a6-c726493d4564@users.sourceforge.net>
 <1508327383.6806.7.camel@perches.com>
 <0fc1f522-8772-d859-a9b0-cb3b6931c862@users.sourceforge.net>
 <063D6719AE5E284EB5DD2968C1650D6DD009ACE3@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wed, 18 Oct 2017, David Laight wrote:

> From: SF Markus Elfring
> > >>>> Unpleasant consequences are possible in both cases.
> > >> How much do you care to reduce the failure probability further?
> > >
> > > Zero.
> >
> > I am interested to improve the software situation a bit more here.
>
> There are probably better places to spend your time!
>
> If you want 'security' for kmalloc() then:
>
> #define KMALLOC_TYPE(flags) (type *)kmalloc(sizeof (type), flags)
> #define KMALLOC(ptr, flags) *(ptr) = KMALLOC_TYPE(typeof *(ptr), flags)
>
> and change:
> 	ptr = kmalloc(sizeof *ptr, flags);
> to:
> 	KMALLOC(&ptr, flags);
>
> But it is all churn for churn's sake.

Please don't.  Coccinelle won't find real problems with kmalloc any more
if this is done.

julia
