Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB5AE1A1D32
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 11:53:30 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5E88C1401EF
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 11:53:30 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Fri, 14 Aug 2015 11:53:29 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 617A82CE8050
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 11:53:25 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E1rBRq49217678
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 11:53:19 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E1qq86019437
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 11:52:53 +1000
Date: Fri, 14 Aug 2015 11:52:26 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH v2] powerpc/xmon: Allow limiting the size of the paca
 display
Message-ID: <20150814015225.GA2064@tungsten.ozlabs.ibm.com>
References: <1439362653-14665-1-git-send-email-mpe@ellerman.id.au>
 <1439380525-9986-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439380525-9986-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 12, 2015 at 09:55:25PM +1000, Michael Ellerman wrote:
> The paca display is already more than 24 lines, which can be problematic
> if you have an old school 80x24 terminal, or more likely you are on a
> virtual terminal which does not scroll for whatever reason.
> 
> We'd like to expand the paca display even more, so add a way to limit
> the number of lines that are displayed.
> 
> This adds a third form of 'dp' which is 'dp # #', where the first number
> is the cpu, and the second is the number of lines to display.
> 
> Example output:
> 
>   5:mon> dp 3 6
>   paca for cpu 0x3 @ c00000000fe00c00:
>    possible         = yes
>    present          = yes
>    online           = yes
>    lock_token       = 0x8000            	(0xa)
>    paca_index       = 0x3               	(0x8)

Michael,

This patch inspired me to do the additional work to make the output paged, more
like the memory dump commands.

I'll post it shortly as "powerpc/xmon: Paged output for paca display".

Cheers,
Sam.
