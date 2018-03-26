Return-Path: <jgg@ziepe.ca>
Received: from mail-wr0-x235.google.com (mail-wr0-x235.google.com
 [IPv6:2a00:1450:400c:c0c::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4090c93nNWzF23j
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:54:32 +1100 (AEDT)
Received: by mail-wr0-x235.google.com with SMTP id m13so6305803wrj.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 09:54:32 -0700 (PDT)
Date: Mon, 26 Mar 2018 10:54:25 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>,
 Sinan Kaya <okaya@codeaurora.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Oliver <oohall@gmail.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: RFC on writel and writel_relaxed
Message-ID: <20180326165425.GA15554@ziepe.ca>
References: <3611eabe-2999-1482-b2b4-6d216bbe4762@codeaurora.org>
 <CAOSf1CFmoK2XSn0=qAtiVEO9t4i-DHGgfieiedDfuO6E3tpkQw@mail.gmail.com>
 <4e5c745a-8b9b-959e-8893-d99cd6032484@codeaurora.org>
 <1521692689.16434.293.camel@kernel.crashing.org>
 <CAOSf1CFv1HHCL3YOVhRn2U=grdNjaQ=A4m3xwxN2Rek1-_TySg@mail.gmail.com>
 <1521726722.16434.312.camel@kernel.crashing.org>
 <20180323163510.GC13033@ziepe.ca>
 <1521854626.16434.359.camel@kernel.crashing.org>
 <58ce5b83f40f4775bec1be8db66adb0d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <58ce5b83f40f4775bec1be8db66adb0d@AcuMS.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 26, 2018 at 11:08:45AM +0000, David Laight wrote:
> > > This is a super performance critical operation for most drivers and
> > > directly impacts network performance.
> 
> Perhaps there ought to be writel_nobarrier() (etc) that never contain
> any barriers at all.
> This might mean that they are always just the memory operation,
> but it would make it more obvious what the driver was doing.

I think that is what writel_relaxed is supposed to be.

The only restriction it has is that the writes to a single device
using UC memory must be kept in program order..

Jason
