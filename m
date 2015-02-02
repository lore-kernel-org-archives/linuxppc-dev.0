Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DAAD31A057D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 03:22:21 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 2 Feb 2015 21:52:19 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5080C125805C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 21:53:17 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t12GLvX453805124
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Feb 2015 21:51:57 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t12GLvSK018116
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Feb 2015 21:51:57 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Add trace point for tracking hash pte fault
In-Reply-To: <20150202212607.7585dedb@kryten>
References: <1421753750-17135-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1421809627.4900.1.camel@ellerman.id.au> <87d268v7xm.fsf@linux.vnet.ibm.com>
 <1422425467.11009.2.camel@ellerman.id.au> <20150202212607.7585dedb@kryten>
Date: Mon, 02 Feb 2015 21:51:55 +0530
Message-ID: <87vbjk707w.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> writes:

> Hi,
>
>> > ebizzy with -S 30 -t 1 -P gave
>> > 13627 records/s -> Without patch
>> > 13546 records/s -> With patch with tracepoint disabled
>> 
>> OK. So that's about -0.6%. Are we happy with that? I'm not sure.
>> 
>> Can you do a few more runs and see if that's a stable result.
>
> Surprisingly large. Is CONFIG_JUMP_LABEL enabled? That should reduce the
> tracepoint to just a nop.

yes. We do use jump label. I also verified that looking at .s

#APP
 # 23 "./arch/powerpc/include/asm/jump_label.h" 1
        1:
        nop
        .pushsection __jump_table,  "aw"
        .llong 1b, .L201, __tracepoint_hash_fault+8      #,
        .popsection

 # 0 "" 2
.....

-aneesh
