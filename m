Return-Path: <arbab@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BKx438FnzF2vj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 12:59:20 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8E2x4hj096051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 22:59:18 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mfxa1mhab-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 22:59:18 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.ibm.com>;
 Thu, 13 Sep 2018 22:59:16 -0400
Date: Thu, 13 Sep 2018 21:59:11 -0500
From: Reza Arbab <arbab@linux.ibm.com>
To: Alan Modra <amodra@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Correct PowerPC VDSO call frame info
References: <20180913232704.GL3174@bubble.grove.modra.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20180913232704.GL3174@bubble.grove.modra.org>
Message-Id: <20180914025911.665onq4xzb67ijss@arbab-vm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2018 at 08:57:04AM +0930, Alan Modra wrote:
>There is control flow in __kernel_clock_gettime that reaches label 99
>without saving lr in r12.  CFI info however is interpreted by the
>unwinder without reference to control flow: It's a simple matter of
>"Execute all the CFI opcodes up to the current address".  That means
>the unwinder thinks r12 contains the return address at label 99.
>Disabuse it of that notion by resetting CFI for the return address at
>label 99.

Thanks for this! It looks like v2 will just be a commit log change, so 
feel free to carry over my

Tested-by: Reza Arbab <arbab@linux.ibm.com>

-- 
Reza Arbab
