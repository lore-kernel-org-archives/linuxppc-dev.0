Return-Path: <brking@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB7D41A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 08:07:42 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Tue, 12 May 2015 16:07:40 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0A9B81FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 15:58:49 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4CM5Xuo23855292
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 15:05:33 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4CM7cqm001526
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 16:07:38 -0600
Message-ID: <555279A8.6060906@linux.vnet.ibm.com>
Date: Tue, 12 May 2015 17:07:36 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sreekanth Reddy <sreekanth.reddy@avagotech.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: mpt2sas DMA mask
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-scsi <linux-scsi@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mpt2sas driver was changed late last year in that it now requests a 64 bit DMA
mask, then requests a 32 bit coherent DMA mask, then later requests a 64 bit coherent
DMA mask. This was 5fb1bf8aaa832e1e9ca3198de7bbecb8eff7db9c. This breaks 64 bit DMA
support for mpt2sas on Power and we always fall back to using 32 bit DMA. Looking
at the commit log, it looks like this was an intentional change.

Ben - you had a patch set you had posted to the list back in Feb of this year, but it
doesn't look like it got merged. 

https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-February/125087.html

This would fix the issue I'm seeing on mpt2sas. Do you plan to dust that patch set
off and upstream it? Were there issues with it that still need to be resolved?

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
