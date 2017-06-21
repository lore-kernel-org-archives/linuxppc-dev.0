Return-Path: <chris@chris-wilson.co.uk>
Received: from fireflyinternet.com (mail.fireflyinternet.com [109.228.58.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtLyC403DzDqRW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 09:48:35 +1000 (AEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>, "David Airlie" <airlied@linux.ie>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20170613135849.GB28327@htj.duckdns.org>
Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel" <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org,
 "sachinp" <sachinp@linux.vnet.ibm.com>,
 "Stephen Rothwell" <sfr@canb.auug.org.au>,
 "Abdul Haleem" <abdhalee@linux.vnet.ibm.com>
References: <1497278454.15415.50.camel@abdul.in.ibm.com>
 <20170613135849.GB28327@htj.duckdns.org>
Message-ID: <149808789548.17054.471609626305557642@mail.alporthouse.com>
Subject: Re: [next-20170609] WARNING: CPU: 3 PID: 71167 at lib/idr.c:157
 idr_replace
Date: Thu, 22 Jun 2017 00:31:35 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Tejun Heo (2017-06-13 14:58:49)
> Cc'ing David Airlie.
> =

> This is from drm driver calling in idr_replace() w/ a negative id.
> Probably a silly bug in error handling path?

No, this is the validation of an invalid userspace handle. The drm ABI
for handles is supposed to be a full u32 range with 0 reserved for an
invalid handle (constrained by the idr_alloc ofc). The WARN was
introduced by 0a835c4f090a.
-Chris
