Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7ACD1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 12:01:09 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 16 Feb 2016 11:01:08 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 03F892CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 12:01:06 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G10v9N11862098
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 12:01:05 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G10XOE031573
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 12:00:33 +1100
Subject: Re: [PATCH] powerpc/lib/sstep.c - Fix emulation fall-through
To: "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <1453704952-11197-1-git-send-email-oohall@gmail.com>
 <1455578929-29599-1-git-send-email-oohall@gmail.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56C27479.8080808@au1.ibm.com>
Date: Tue, 16 Feb 2016 11:59:37 +1100
MIME-Version: 1.0
In-Reply-To: <1455578929-29599-1-git-send-email-oohall@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/02/16 10:28, Oliver O'Halloran wrote:
> There is a switch fallthough in instr_analyze() which can cause
> an invalid instruction to be emulated as a different, valid,
> instruction. The rld* (opcode 30) case extracts a sub-opcode from
> bits 3:1 of the instruction word. However, the only valid values
> of this field a 001 and 000. These cases are correctly handled,
> but the others are not which causes execution to fall through
> into case 31.
>
> Breaking out of the switch causes the instruction to be marked as
> unknown and allows the caller to deal with the invalid instruction
> in a manner consistent with other invalid instructions.
>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

The title should probably be "powerpc/sstep: fix switch fallthrough in 
instruction emulation" to be consistent with our usual patch titling 
practice. Please respin.

Apart from that, I'm reasonably convinced this is an appropriate fix:

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
