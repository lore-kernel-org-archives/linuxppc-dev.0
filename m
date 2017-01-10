Return-Path: <chandan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyLCF2wDXzDqHY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 16:28:09 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0A5OAVt079836
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 00:28:07 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27vmqyrnrg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 00:28:06 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <chandan@linux.vnet.ibm.com>;
 Tue, 10 Jan 2017 10:58:02 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A7292394006A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 10:58:00 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0A5RCia29950176
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 10:57:12 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0A5RxUv004389
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 10:58:00 +0530
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: axboe@kernel.dk, jack@suse.cz, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 anton@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] direct-io: don't introduce another read of
 inode->i_blkbits
Date: Tue, 10 Jan 2017 10:57:55 +0530
In-Reply-To: <x49r34bgba5.fsf@segfault.boston.devel.redhat.com>
References: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
 <x49r34bgba5.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <4971281.Bg9JD0zqnv@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, January 09, 2017 04:42:58 PM Jeff Moyer wrote:
> Commit 20ce44d545844 ("do_direct_IO: Use inode->i_blkbits to compute
> block count to be cleaned") introduced a regression: if the block size
> of the block device is changed while a direct I/O request is being
> setup, it can result in a panic.  See commit ab73857e354ab ("direct-io:
> don't read inode->i_blkbits multiple times") for the reasoning, and
> commit b87570f5d3496 ("Fix a crash when block device is read and block
> size is changed at the same time") for a more detailed problem
> description and reproducer.
> 
> Fixes: 20ce44d545844
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> 
> ---
> Chandan, can you please test this to ensure this still fixes your problem?

This patch fixes the failure,

Tested-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>

-- 
chandan
