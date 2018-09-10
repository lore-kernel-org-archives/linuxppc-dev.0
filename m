Return-Path: <vaibhav@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427y7p2w0fzF3Cc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 16:00:22 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8A5xkWr144252
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 02:00:20 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mdffuxkux-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 02:00:19 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.ibm.com>;
 Mon, 10 Sep 2018 07:00:17 +0100
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Stewart Smith <stewart@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Make possible for user to force a full
 ipl cec reboot
In-Reply-To: <87worut1c7.fsf@linux.vnet.ibm.com>
References: <20180901081745.2165-1-vaibhav@linux.ibm.com>
 <87worut1c7.fsf@linux.vnet.ibm.com>
Date: Mon, 10 Sep 2018 11:30:10 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h8ixj3it.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for looking into this patch Stewart

Stewart Smith <stewart@linux.ibm.com> writes:

> We're about to introduce an MPIPL reboot type (to take a firmware
> assisted kdump style thing), and we maybe should have a reboot type to
> force attempting a fast-reboot, and this makes me think if we should add
> those in now?
I will probably let Vasant and others answer that.


> If the reboot type isn't supported, what should be the behvaiour? Reboot
> the default way or don't reboot at all?
Yes, I have addressed that in v3 of this patch at
http://patchwork.ozlabs.org/patch/967248/. In case the reboot type isnt
supported or if there is an error invoking it, the patch will revert
back to calling opal_cec_reboot().

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
