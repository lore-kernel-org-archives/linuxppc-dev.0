Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 021481A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 23:59:15 +1000 (EST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2AAB41400A6
 for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2014 23:59:13 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 23 May 2014 19:29:11 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C1E6F394003E
 for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2014 19:29:08 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4NDxIaD50135254
 for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2014 19:29:18 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4NDx6WK011863
 for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2014 19:29:08 +0530
Message-ID: <537F53BE.8030105@linux.vnet.ibm.com>
Date: Fri, 23 May 2014 19:27:18 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Pedro Alves <palves@redhat.com>
Subject: Re: [PATCH V2 2/3] powerpc, ptrace: Enable support for transactional
 memory register sets
References: <1399276469-13541-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1399276469-13541-3-git-send-email-khandual@linux.vnet.ibm.com>
 <537252C0.6090005@redhat.com> <53730326.6000400@linux.vnet.ibm.com>
 <53735044.5030008@redhat.com> <537479FD.2010200@linux.vnet.ibm.com>
 <5374AE24.1030302@redhat.com> <5379EF0E.6090504@linux.vnet.ibm.com>
 <537A1889.8030801@redhat.com> <537B0EE0.4080406@linux.vnet.ibm.com>
 <537B2F5E.4040102@redhat.com> <537D8641.8090600@linux.vnet.ibm.com>
In-Reply-To: <537D8641.8090600@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, avagin@openvz.org, linux-kernel@vger.kernel.org,
 oleg@redhat.com, michael@ellerman.id.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/22/2014 10:38 AM, Anshuman Khandual wrote:
> I agree.
> 
>> > 
>> > Maybe we should leave this for another day, and have tm_spr_active
>> > return 0 instead of -ENODEV when the machine doesn't have the hardware,
>> > or not install that hook at all.  Seems like the effect will be the same,
>> > as the note isn't output if ->get fails.

> Agree. Active hooks which return 0 in case of -ENODEV sounds good to me and shall
> incorporate this in the next version.
> 

But from "user_regset_active_fn" definition point of view -ENODEV is the right thing
to do even if we dont use it specifically compared to the return value of 0.
