Return-Path: <srs0=nusq=fp=au1.ibm.com=alastair@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmv6n21g7zF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 10:37:53 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zmv6n1Qz1z8t6w
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 10:37:53 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zmv6m3Gy0z9sW3
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 10:37:52 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1LNTUjo047098
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 18:37:50 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g9fsgdm1y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 18:37:50 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 21 Feb 2018 23:37:48 -0000
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information
 to userspace
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, Balbir Singh
 <bsingharora@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, frederic.barrat@fr.ibm.com, Greg KH
 <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 22 Feb 2018 10:37:43 +1100
In-Reply-To: <c6017f9f-67f0-10eb-1eed-527c9c5298ba@linux.vnet.ibm.com>
References: <20180221045736.7614-1-alastair@au1.ibm.com>
 <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
 <c6017f9f-67f0-10eb-1eed-527c9c5298ba@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1519256263.2867.8.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-02-21 at 12:25 +0100, Frederic Barrat wrote:
> 
> Le 21/02/2018 à 07:43, Balbir Singh a écrit :
> > On Wed, Feb 21, 2018 at 3:57 PM, Alastair D'Silva <alastair@au1.ibm
> > .com> wrote:
> > > From: Alastair D'Silva <alastair@d-silva.org>
> > > 
> > > Some required information is not exposed to userspace currently
> > > (eg. the
> > > PASID), pass this information back, along with other information
> > > which
> > > is currently communicated via sysfs, which saves some parsing
> > > effort in
> > > userspace.
> > > 
> > > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > > 
<snip>
> > Should we document the fields? pp_ stands for per process, but is
> > not
> > very clear at first look. Why do we care to return only the size,
> > what
> > about lpc size?
> 
> My bad, I forgot to mention it before. There's a somewhat high-level 
> description which needs updating in:
> Documentation/accelerators/ocxl.rst
> 
> It doesn't go down to the level of the structure members, but at
> least 
> all ioctl commands should have a brief description.
> 

I'll update the docs.

> lpc_size could be added. It's currently useless to the library, but 
> doesn't hurt. The one which was giving me troubles on a previous
> version 
> of this patch was the lpc numa node ID, since that was experimental
> code 
> and felt out of place considering what's been upstreamed in skiboot
> and 
> linux so far.

I'd rather add the LPC members when the rest of the LPC code goes in.
At the moment, the LPC size represents the window size (as a power of
2), whereas we expect that it should represent the actual amount of LPC
memory exposed. I would rather avoid changing semantics of members in
released code, or burning another reserved member for the updated
definition if we can avoid it.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
