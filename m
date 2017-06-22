Return-Path: <htejun@gmail.com>
Received: from mail-yb0-x241.google.com (mail-yb0-x241.google.com
 [IPv6:2607:f8b0:4002:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtrTG1zZgzDr12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 04:58:42 +1000 (AEST)
Received: by mail-yb0-x241.google.com with SMTP id 84so1194377ybe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 11:58:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 22 Jun 2017 14:58:37 -0400
From: Tejun Heo <tj@kernel.org>
To: Matthew Wilcox <mawilcox@microsoft.com>,
 Chris Wilson <chris@chris-wilson.co.uk>
Cc: David Airlie <airlied@linux.ie>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-next@vger.kernel.org, sachinp <sachinp@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Subject: Re: [next-20170609] WARNING: CPU: 3 PID: 71167 at lib/idr.c:157
 idr_replace
Message-ID: <20170622185837.GD18600@htj.duckdns.org>
References: <1497278454.15415.50.camel@abdul.in.ibm.com>
 <20170613135849.GB28327@htj.duckdns.org>
 <149808789548.17054.471609626305557642@mail.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149808789548.17054.471609626305557642@mail.alporthouse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 22, 2017 at 12:31:35AM +0100, Chris Wilson wrote:
> Quoting Tejun Heo (2017-06-13 14:58:49)
> > Cc'ing David Airlie.
> > 
> > This is from drm driver calling in idr_replace() w/ a negative id.
> > Probably a silly bug in error handling path?
> 
> No, this is the validation of an invalid userspace handle. The drm ABI
> for handles is supposed to be a full u32 range with 0 reserved for an
> invalid handle (constrained by the idr_alloc ofc). The WARN was
> introduced by 0a835c4f090a.

Matthew, did idr lost some of its range while being reimplemented
using radix tree?

Thanks.

-- 
tejun
