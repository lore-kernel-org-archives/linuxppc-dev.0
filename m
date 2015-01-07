Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0132.outbound.protection.outlook.com [65.55.169.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1D9F1A0F36
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 04:59:35 +1100 (AEDT)
Message-ID: <1420653561.4961.56.camel@freescale.com>
Subject: Re: [PATCH 1/3] powerpc: Don't use local named register variable in
 current_thread_info
From: Scott Wood <scottwood@freescale.com>
To: Anton Blanchard <anton@samba.org>
Date: Wed, 7 Jan 2015 11:59:21 -0600
In-Reply-To: <20150107161247.55591e93@kryten>
References: <1414727247-31838-1-git-send-email-anton__19440.5086375356$1414727300$gmane$org@samba.org>
 <5490D981.7040905@suse.de>	<1418879514.13333.2.camel@ellerman.id.au>
 <20141218172546.432de7f2@kryten>
 <20141231122453.GH5183@bubble.grove.modra.org>
 <20150107161247.55591e93@kryten>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Alan Modra <amodra@gmail.com>, Alexander Graf <agraf@suse.de>,
 ulrich.weigand@de.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-07 at 16:12 +1100, Anton Blanchard wrote:
> Thanks for looking into this. Does that mean we were just getting lucky
> with the previous version:
> 
> static inline struct thread_info *current_thread_info(void)
> {
>         register unsigned long sp asm("r1");
> 
>         return (struct thread_info *)(sp & ~(THREAD_SIZE-1));
> }
>  
> ie a static register asm instead of a global one. If so the safest fix
> for now might be to just eat the overead of a register move:
> 
> static inline struct thread_info *current_thread_info(void)
> {
>         unsigned long sp;
> 
>         asm("mr %0,1": "=r"(sp));
>         return (struct thread_info *)(sp & ~(THREAD_SIZE-1));

You could avoid the register move by doing a rlwinm/rldicr in inline
asm, if it matters enough.

-Scott
