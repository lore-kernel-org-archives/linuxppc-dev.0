Return-Path: <chris@distroguy.com>
Received: from mx-out03.mykolab.com (mx01.mykolab.com [95.128.36.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rXrKg1zjPzDql4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 09:48:37 +1000 (AEST)
Date: Mon, 20 Jun 2016 09:48:24 +1000
From: Chris Smart <chris@distroguy.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [Patch v2 1/2] powerpc: Send SIGBUS on unaligned copy and paste
Message-ID: <20160619234823.GA27442@distroguy.com>
References: <20160616233340.GA14449@distroguy.com>
 <13e8530c-80d6-5475-f4f2-3a46e4a75a76@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <13e8530c-80d6-5475-f4f2-3a46e4a75a76@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 17, 2016 at 05:20:05PM +1000, Balbir Singh wrote:
>
>
>On 17/06/16 09:33, Chris Smart wrote:

[snip]

>> +
>> +    /*
>> +     * ISA 3.0 (such as P9) copy, copy_first, paste and paste_last alignment
>> +     * check.
>> +     *
>> +     * Send a SIGBUS to the process that caused the fault.
>> +     *
>> +     * We do not emulate these because paste may contain additional metadata
>> +     * when pasting to a co-processor. Furthermore, paste_last is the
>> +     * synchronisation point for preceding copy/paste sequences.
>> +     */
>> +    if ((instruction & 0xfc0006fe) == PPC_INST_COPY)
>> +        return -EIO;
>
>Should this all be under cpu_has_feature(CPU_FTR_ARCH_300)?
>

I'm not sure we should or not. That instruction only exists on those
machines so is it worth adding an additional check when the next check
will fail anyway?

I guess it would reduce non ISA 3.0 machines to just a single check rather
than two, but increases ISO 3.0 machines to three.

I defer to the wisdom of others.

-c
