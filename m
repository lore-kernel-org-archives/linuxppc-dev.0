Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rXwjY2pjMzDqCX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 13:06:09 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id us13so9898394pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jun 2016 20:06:09 -0700 (PDT)
Subject: Re: [Patch v2 1/2] powerpc: Send SIGBUS on unaligned copy and paste
To: Chris Smart <chris@distroguy.com>
References: <20160616233340.GA14449@distroguy.com>
 <13e8530c-80d6-5475-f4f2-3a46e4a75a76@gmail.com>
 <20160619234823.GA27442@distroguy.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <31502d44-4cee-8432-317a-dff14df8721c@gmail.com>
Date: Mon, 20 Jun 2016 13:06:01 +1000
MIME-Version: 1.0
In-Reply-To: <20160619234823.GA27442@distroguy.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 20/06/16 09:48, Chris Smart wrote:
> On Fri, Jun 17, 2016 at 05:20:05PM +1000, Balbir Singh wrote:
>>
>>
>> On 17/06/16 09:33, Chris Smart wrote:
> 
> [snip]
> 
>>> +
>>> +    /*
>>> +     * ISA 3.0 (such as P9) copy, copy_first, paste and paste_last alignment
>>> +     * check.
>>> +     *
>>> +     * Send a SIGBUS to the process that caused the fault.
>>> +     *
>>> +     * We do not emulate these because paste may contain additional metadata
>>> +     * when pasting to a co-processor. Furthermore, paste_last is the
>>> +     * synchronisation point for preceding copy/paste sequences.
>>> +     */
>>> +    if ((instruction & 0xfc0006fe) == PPC_INST_COPY)
>>> +        return -EIO;
>>
>> Should this all be under cpu_has_feature(CPU_FTR_ARCH_300)?
>>
> 
> I'm not sure we should or not. That instruction only exists on those
> machines so is it worth adding an additional check when the next check
> will fail anyway?
> 
> I guess it would reduce non ISA 3.0 machines to just a single check rather
> than two, but increases ISO 3.0 machines to three.
> 

Ideally we can do features and fixups, but that today works mostly for the
assembly code we have. In this case we might get away by doing the if and "&",
I would recommend adding a branch hint

if (unlikely(...))

Balbir Singh
