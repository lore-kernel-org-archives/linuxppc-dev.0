Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF4BF1A0072
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 11:53:04 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 27 Jan 2016 10:53:03 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B16C22BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 11:53:01 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0R0qUSY48300258
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 11:52:38 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0R0qTnw023909
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 11:52:29 +1100
Subject: Re: [PATCH] Fix fall-through from case 30 (rld*) to case 31
To: "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <1453704952-11197-1-git-send-email-oohall@gmail.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56A814B4.9020802@au1.ibm.com>
Date: Wed, 27 Jan 2016 11:52:04 +1100
MIME-Version: 1.0
In-Reply-To: <1453704952-11197-1-git-send-email-oohall@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25/01/16 17:55, Oliver O'Halloran wrote:
> I think this bug can only be triggered if the instruction to
> simulate is malformed. The switch in the else case only handles
> the zero and one case, but it extracts bits 4:1 from the
> instruction word so it may be other values. It's pretty minor, but
> a bug is a bug.
>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

The patch summary should probably be something along the lines of
"powerpc/sstep: fix switch fall-through when analysing malformed rld* 
instructions" or similar. The rest of the message should have the more 
specific details of the bug you're fixing.

In general, we always mention the affected subsystems in the patch 
summary line and write both the summary line and the message so that 
other developers can get a quick understanding of what the patch does 
without actually needing to read the code. Keep in mind that commit 
messages will show up in the git logs of every kernel developer, not 
just powerpc people.

> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -925,6 +925,7 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>   			}
>   		}
>   #endif
> +	break; /* illegal instruction */

I had a cursory glance at the code and it's not obvious to me that this 
is the correct way to deal with an invalid instruction. What happens 
when you break out of the switch? It looks like it just ends up 
returning 0, the same as any other instruction that isn't executed 
directly in the analyse_instr() stage.

Is there anywhere else in the sstep code that deals well with malformed 
instructions?

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
