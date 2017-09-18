Return-Path: <axboe@kernel.dk>
Received: from mail-io0-x22e.google.com (mail-io0-x22e.google.com
 [IPv6:2607:f8b0:4001:c06::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwr8k5zs3zDrMt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 01:51:34 +1000 (AEST)
Received: by mail-io0-x22e.google.com with SMTP id i197so3175527ioe.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 08:51:33 -0700 (PDT)
Subject: Re: [linux-next][XFS][trinity] WARNING: CPU: 32 PID: 31369 at
 fs/iomap.c:993
To: Al Viro <viro@ZenIV.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 chandan <chandan@linux.vnet.ibm.com>
References: <1505746565.6990.18.camel@abdul.in.ibm.com>
 <20170918152706.GA11482@lst.de>
 <8abed401-1634-760f-6543-4652fa495315@kernel.dk>
 <20170918153947.GA12635@lst.de> <20170918154328.GA32076@ZenIV.linux.org.uk>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <955c9c41-1941-5cf4-751c-14a3efa9d0ce@kernel.dk>
Date: Mon, 18 Sep 2017 09:51:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170918154328.GA32076@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/18/2017 09:43 AM, Al Viro wrote:
> On Mon, Sep 18, 2017 at 05:39:47PM +0200, Christoph Hellwig wrote:
>> On Mon, Sep 18, 2017 at 09:28:55AM -0600, Jens Axboe wrote:
>>> If it's expected, why don't we kill the WARN_ON_ONCE()? I get it all
>>> the time running xfstests as well.
>>
>> Dave insisted on it to decourage users/applications from mixing
>> mmap and direct I/O.
>>
>> In many ways a tracepoint might be the better way to diagnose these.
> 
> sysctl suppressing those two, perhaps?

I'd rather just make it a trace point, but don't care too much.

The code doesn't even have a comment as to why that WARN_ON() is
there or expected. Seems pretty sloppy to me, not a great way
to "discourage" users to mix mmap/dio.

-- 
Jens Axboe
