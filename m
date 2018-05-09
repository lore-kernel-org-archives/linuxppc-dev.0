Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gqN61dG3zF2Mg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 18:32:05 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w498TRoE036565
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 May 2018 04:32:03 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2huv4fuxnt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 04:32:03 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 9 May 2018 09:32:01 +0100
Subject: Re: [PATCH] powerpc/64s/radix: reset mm_cpumask for single thread
 process when possible
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 09 May 2018 18:31:55 +1000
In-Reply-To: <20180509065613.14762-1-npiggin@gmail.com>
References: <20180509065613.14762-1-npiggin@gmail.com>
Mime-Version: 1.0
Message-Id: <0c3d18301bc3eb86da197ecefb22aec5c6f70a57.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-09 at 16:56 +1000, Nicholas Piggin wrote:
> When a single-threaded process has a non-local mm_cpumask and requires
> a full PID tlbie invalidation, use that as an opportunity to reset the
> cpumask back to the current CPU we're running on.
> 
> No other thread can concurrently switch to this mm, because it must
> have had a reference on mm_users before it could use_mm. mm_users can
> be asynchronously incremented e.g., by mmget_not_zero, but those users
> must not be doing use_mm.

What do you mean ? I don't fully understand how this isn't racy with
another thread being created, switching to that mm, and then having its
bit cleared by us ? Also why not use_mm ? what prevents it ?

Cheers,
Ben.
