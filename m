Return-Path: <srs0=lavr=fq=au1.ibm.com=alastair@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zn0m36YmwzF1FV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 14:52:03 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zn0m35vVjz8t72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 14:52:03 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zn0m32V77z9rxp
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 14:52:03 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1M3mxj8136186
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 22:52:01 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g9gga39ed-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 22:52:00 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <alastair@au1.ibm.com>;
 Thu, 22 Feb 2018 03:51:57 -0000
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information
 to userspace
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, Frederic Barrat
 <fbarrat@linux.vnet.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, frederic.barrat@fr.ibm.com, Greg KH
 <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 22 Feb 2018 14:51:52 +1100
In-Reply-To: <CAKTCnzkwwmbU4vzrmzW=eNnr2QW+rj=OUcAdOVxz+qKGC=9Q9A@mail.gmail.com>
References: <20180221045736.7614-1-alastair@au1.ibm.com>
 <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
 <c6017f9f-67f0-10eb-1eed-527c9c5298ba@linux.vnet.ibm.com>
 <CAKTCnzkwwmbU4vzrmzW=eNnr2QW+rj=OUcAdOVxz+qKGC=9Q9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1519271512.2867.14.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-02-22 at 14:46 +1100, Balbir Singh wrote:
<snip>
> lpc_size could be added. It's currently useless to the library, but
> > doesn't
> > hurt. The one which was giving me troubles on a previous version of
> > this
> > patch was the lpc numa node ID, since that was experimental code
> > and felt
> > out of place considering what's been upstreamed in skiboot and
> > linux so far.
> > 
> 
> Yeah, I think metadata will evolve for a while till it settle's down.
> Since ocxl_ioctl_get_metadata is exposed via uapi, a newer program
> calling an older kernel will never work, since the size of that
> struct
> will always be larger than what the OS supports and our
> copy_to_user()
> will fail. The other option is for the user program to try all
> possible versions till one succeeds, that is bad as well. I think
> there are a few ways around it, if we care about this combination.
> 
> Balbir Singh.
> 

We have a number of reserved members at the end of the struct which can
be re-purposed for future information (with a corresponding bump of the
version number).

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
