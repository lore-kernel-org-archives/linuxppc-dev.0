Return-Path: <bryantly@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lGtZ07JMzDqgD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 00:22:13 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w77EJCdR029510
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Aug 2018 10:22:11 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kqay6eng9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Aug 2018 10:22:10 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.ibm.com>;
 Tue, 7 Aug 2018 10:22:09 -0400
Subject: Re: [PATCH] misc: ibmvsm: Fix wrong assignment of return code
To: Michael Ellerman <michaele@au1.ibm.com>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1533562260-11456-1-git-send-email-bryantly@linux.vnet.ibm.com>
 <87y3dibbt3.fsf@concordia.ellerman.id.au>
From: "Bryant G. Ly" <bryantly@linux.ibm.com>
Date: Tue, 7 Aug 2018 09:22:04 -0500
MIME-Version: 1.0
In-Reply-To: <87y3dibbt3.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <ff54860b-9e9a-84a2-9f72-cbb0c5b7118d@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 8/7/18 7:28 AM, Michael Ellerman wrote:

> "Bryant G. Ly" <bryantly@linux.vnet.ibm.com> writes:
>
>> From: "Bryant G. Ly" <bryantly@linux.ibm.com>
>>
>> Currently the assignment is flipped and rc is always 0.
> If you'd left rc uninitialised at the start of the function the compiler
> would have caught it for you.
>
> And what is the consequence of the bug? Nothing, complete system crash,
> subtle data corruption?

The consequence would be that if the CRQ Registration failed the first time
due to not enough resources, it would never try to reset and try again. 

If it fails due to any other error then it would just fail the sending of the
crq init message, thus it would just wait for the client to init, which would
never happen. 

We would also have a memory leak since in the error case DMA would never get
un-mapped and the message queue never gets freed. 

>
> Also this should be tagged:
>
> Fixes: 0eca353e7ae7 ("misc: IBM Virtual Management Channel Driver (VMC)")
>
> cheers
>
Yep, sorry I forgot to add the Fixes:..

-Bryant
