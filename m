Return-Path: <axboe@kernel.dk>
Received: from mail-io0-x235.google.com (mail-io0-x235.google.com
 [IPv6:2607:f8b0:4001:c06::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwqfn2jt8zDr38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 01:29:02 +1000 (AEST)
Received: by mail-io0-x235.google.com with SMTP id 21so3006031iof.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 08:29:02 -0700 (PDT)
Subject: Re: [linux-next][XFS][trinity] WARNING: CPU: 32 PID: 31369 at
 fs/iomap.c:993
To: Christoph Hellwig <hch@lst.de>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 chandan <chandan@linux.vnet.ibm.com>
References: <1505746565.6990.18.camel@abdul.in.ibm.com>
 <20170918152706.GA11482@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8abed401-1634-760f-6543-4652fa495315@kernel.dk>
Date: Mon, 18 Sep 2017 09:28:55 -0600
MIME-Version: 1.0
In-Reply-To: <20170918152706.GA11482@lst.de>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/18/2017 09:27 AM, Christoph Hellwig wrote:
> On Mon, Sep 18, 2017 at 08:26:05PM +0530, Abdul Haleem wrote:
>> Hi,
>>
>> A warning is triggered from:
>>
>> file fs/iomap.c in function iomap_dio_rw
>>
>>     if (ret)
>>         goto out_free_dio;
>>
>>     ret = invalidate_inode_pages2_range(mapping,
>>             start >> PAGE_SHIFT, end >> PAGE_SHIFT);
>>>>  WARN_ON_ONCE(ret);
>>     ret = 0;
>>
>>     inode_dio_begin(inode);
> 
> This is expected and an indication of a problematic workload - which
> may be triggered by a fuzzer.

If it's expected, why don't we kill the WARN_ON_ONCE()? I get it all
the time running xfstests as well.

-- 
Jens Axboe
