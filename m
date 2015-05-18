Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A8141A006F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 20:49:22 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 18 May 2015 20:49:20 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2C48C2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 20:49:17 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4IAn77g17039362
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 20:49:17 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4IAmhV3031864
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 20:48:43 +1000
Message-ID: <5559C370.3050109@linux.vnet.ibm.com>
Date: Mon, 18 May 2015 16:18:16 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH V3 09/13] selftests, powerpc: Add test for DSCR value
 inheritence across fork
References: <1428654612-23539-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1428654612-23539-10-git-send-email-khandual@linux.vnet.ibm.com>
 <20150518150957.4c228ac4@kryten>
In-Reply-To: <20150518150957.4c228ac4@kryten>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, shuahkh@osg.samsung.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/18/2015 10:39 AM, Anton Blanchard wrote:
> Hi Anshuman,
> 
> Thanks for getting these testcases into the kernel.
> 
>> This patch adds a test to verify that the changed DSCR value inside
>> any process would be inherited to it's child process across the fork
>> system call.
> 
> One issue I do notice (a bug in my original test cases too), is that we
> don't restore the DSCR on exit. I'm not sure we need to go to the
> trouble of saving and restoring it, but we should at least get it back
> to 0 when done.

Will save/restore the system DSCR default before exiting.

> 
> Also a tiny nit, no need for a newline in perror():
> 
> open() failed
> : Permission denied
> 

sure, will remove them.

> With those changes you can add:
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> 
> to the patches based on my testcases.

Thanks.
