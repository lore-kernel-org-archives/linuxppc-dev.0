Return-Path: <axboe@kernel.dk>
Received: from mail-io0-x22e.google.com (mail-io0-x22e.google.com
 [IPv6:2607:f8b0:4001:c06::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tykFL2HCLzDqN3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 07:31:15 +1100 (AEDT)
Received: by mail-io0-x22e.google.com with SMTP id l66so8627152ioi.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 12:31:15 -0800 (PST)
Subject: Re: [PATCH] direct-io: don't introduce another read of
 inode->i_blkbits
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 Jeff Moyer <jmoyer@redhat.com>
References: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
 <x49r34bgba5.fsf@segfault.boston.devel.redhat.com>
 <4971281.Bg9JD0zqnv@localhost.localdomain>
Cc: jack@suse.cz, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <eff698ef-2677-bb7c-1caf-2b99d95050e7@kernel.dk>
Date: Tue, 10 Jan 2017 13:31:11 -0700
MIME-Version: 1.0
In-Reply-To: <4971281.Bg9JD0zqnv@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/09/2017 10:27 PM, Chandan Rajendra wrote:
> On Monday, January 09, 2017 04:42:58 PM Jeff Moyer wrote:
>> Commit 20ce44d545844 ("do_direct_IO: Use inode->i_blkbits to compute
>> block count to be cleaned") introduced a regression: if the block size
>> of the block device is changed while a direct I/O request is being
>> setup, it can result in a panic.  See commit ab73857e354ab ("direct-io:
>> don't read inode->i_blkbits multiple times") for the reasoning, and
>> commit b87570f5d3496 ("Fix a crash when block device is read and block
>> size is changed at the same time") for a more detailed problem
>> description and reproducer.
>>
>> Fixes: 20ce44d545844
>> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>>
>> ---
>> Chandan, can you please test this to ensure this still fixes your problem?
> 
> This patch fixes the failure,
> 
> Tested-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> 

I've updated the patch, thanks guys.

-- 
Jens Axboe
