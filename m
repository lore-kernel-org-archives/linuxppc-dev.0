Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9DB91A0FCD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 22:12:21 +1000 (AEST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CAB4814029E
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 22:12:20 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 17:42:18 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A1FB51258059
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 17:44:45 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5AC52sH62193740
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 17:42:14 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5AC2Kwj017593
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 17:32:22 +0530
Message-ID: <5578274A.8080402@linux.vnet.ibm.com>
Date: Wed, 10 Jun 2015 17:32:18 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V8 01/10] powerpc, perf: Drop the branch sample when 'from'
 cannot be fetched
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433906475.3096.1.camel@axtens.net>
In-Reply-To: <1433906475.3096.1.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/2015 08:51 AM, Daniel Axtens wrote:
> Hi Anshuman,
> 
> Was there a cover letter for this series that I missed?

This is the continuation (rebased and reworked) of the series
posted at https://lkml.org/lkml/2014/5/5/153 (which is V6). I
remember to have incremented the count for the re-send of the
first four patches of the series to Peter Z for generic review
which got pulled in last year. These patches here are the
remaining powerpc part of the original series. Will list down
the current changes as well next time around along with the new
ones.

> 
> On Mon, 2015-06-08 at 17:08 +0530, Anshuman Khandual wrote:
>> BHRB is a rolling buffer. Hence we might end up in a situation where
> Could you spell out what BHRB stands for?

Branch History Rolling Buffer, would you like to have that in the
commit message as well ?

> 
>> we have read one target address but when we try to read the next entry
>>  indicating the from address of the targe, the buffer just overflows.
> target?

Yeah its target address.

> 
>> In this case, the captured from address will be zero which indicates
>> the end of the buffer.
>>
> In what sort of situations would this occur? It seems like something we
> would want to avoid if possible?

Its not avoidable. During regular flow of branch recording, the HW would
have written both the records correctly but then the new ones came in and
we just happen to loose one of them causing this situation.
