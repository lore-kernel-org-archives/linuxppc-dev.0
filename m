Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4283qW6xVzzF3F7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 20:16:39 +1000 (AEST)
Subject: Re: [PATCH] powerpc: Avoid code patching freed init sections
To: Michael Neuling <mikey@neuling.org>, =?UTF-8?Q?Michal_Such=c3=a1nek?=
 <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Haren Myneni <haren@linux.vnet.ibm.com>
References: <20180910054405.32422-1-mikey@neuling.org>
 <20180910115457.60366160@naga.suse.cz>
 <794308ed6aa6dcccf96e10bb0e3fa8d2dab9adff.camel@neuling.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <3023d79c-cc38-037a-3617-832fed397a3d@c-s.fr>
Date: Mon, 10 Sep 2018 12:16:35 +0200
MIME-Version: 1.0
In-Reply-To: <794308ed6aa6dcccf96e10bb0e3fa8d2dab9adff.camel@neuling.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/09/2018 à 12:05, Michael Neuling a écrit :
> 
>>> +	/* Make sure we aren't patching a freed init section */
>>> +	if (in_init_section(patch_addr) && init_freed())
>>> +		return 0;
>>> +
>>
>> Do we even need the init_freed() check?
> 
> Maybe not.  If userspace isn't up, then maybe it's ok to skip.

Euh ... Do you mean you'll skip all patches into init functions ?
But code patching is not only for meltdown/spectrum workarounds, some of 
the patchings might be needed for the init functions themselves.

Christophe

> 
>> What user input can we process in init-only code?
> 
> See the stack trace in the commit message. It's a weird case for KVM guests in
> KVM PR mode.
> 
> That's the only case I can found so far.
> 
>> Also it would be nice to write the function+offset of the skipped patch
>> location into the kernel log.
> 
> OK. I'll update.
> 
> Mikey
> 
