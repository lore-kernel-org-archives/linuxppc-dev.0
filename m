Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0078.hostedemail.com
 [216.40.44.78])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yH9N10JvCzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 22:49:51 +1100 (AEDT)
Message-ID: <1508327383.6806.7.camel@perches.com>
Subject: Re: Adjusting further size determinations?
From: Joe Perches <joe@perches.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, Alexander.Steffen@infineon.com,
 James Bottomley <James.Bottomley@HansenPartnership.com>, Dan Carpenter
 <dan.carpenter@oracle.com>, Jarkko Sakkinen
 <jarkko.sakkinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Jerry Snitselaar
 <jsnitsel@redhat.com>,  Kenneth Goldman <kgold@linux.vnet.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.vnet.ibm.com>, Paul
 Mackerras <paulus@samba.org>, Peter =?ISO-8859-1?Q?H=FCwe?=
 <PeterHuewe@gmx.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date: Wed, 18 Oct 2017 04:49:43 -0700
In-Reply-To: <ab5730c4-fb69-4791-a2a6-c726493d4564@users.sourceforge.net>
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
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-10-18 at 13:00 +0200, SF Markus Elfring wrote:
> > Ugly grep follows:
> > 
> > $ grep -rohP --include=*.[ch] "\w+\s*=\s*[kv].alloc\s*\(\s*sizeof.*," * | \
> >   sed -r -e 's/(\w+)\s*=\s*[kv].alloc\s*\(\s*sizeof\s*\(\s*\*\s*\1\s*\)/foo = k.alloc(sizeof(*foo))/' \
> >          -e 's/(\w+)\s*=\s*[kv].alloc\s*\(\s*sizeof\s*\(\s*struct\s+\w+\s*\)/foo = k.alloc(sizeof(struct foo))/' | \
> >   sort | uniq -c | sort -rn | head -2
> >    6123 foo = k.alloc(sizeof(*foo)),
> >    3060 foo = k.alloc(sizeof(struct foo)),
> 
> Would you like to get this ratio changed in any ways?

No.

> Available development tools could help to improve the software situation
> in a desired direction, couldn't they?
> > > Unpleasant consequences are possible in both cases.
> How much do you care to reduce the failure probability further?

Zero.

The alloc style is trivially useful for new code.
Existing code doesn't need change.
