Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BEEB1A0036
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 06:59:29 +1100 (AEDT)
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Thu, 14 Jan 2016 17:59:23 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 38B891DC006A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 14:59:17 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0EJupcW28967234
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 17:56:52 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0EJxJZB020257
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 17:59:20 -0200
Subject: Re: [PATCH] powerpc/eeh: Validate arch in eeh_add_device_early()
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1452395295-1759-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1452681487.7404.6.camel@ellerman.id.au>
 <56963E40.8070702@linux.vnet.ibm.com>
 <1452720339.8203.4.camel@ellerman.id.au>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <5697FE17.4070605@linux.vnet.ibm.com>
Date: Thu, 14 Jan 2016 17:59:19 -0200
MIME-Version: 1.0
In-Reply-To: <1452720339.8203.4.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/13/2016 07:25 PM, Michael Ellerman wrote:
> But for example what happens if the user boots with eeh=off on the command
> line, and then hotplugs a device. It looks like because you're not using
> eeh_enabled() you will incorrectly initialise EEH anyway?

Thanks very much for this catch Michael! I didn't think in this 
possibility; I just tested and it fails with the kernel oops.

So, since my patch does not cover this case, I think would be more 
interesting "unlink" the DDW mechanism from the EEH. It seems easy, I'll 
try to send you a patch soon.

Do you think it is a good approach?

Cheers,


Guilherme
