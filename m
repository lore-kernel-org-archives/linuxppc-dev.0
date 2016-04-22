Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrkNM0yRrzDqmG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 15:15:47 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 22 Apr 2016 15:15:45 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 999C03578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 15:15:41 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3M5FXfV59113612
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 15:15:41 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3M5F87X013599
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 15:15:09 +1000
Subject: Re: [PATCH 2/2] cxl: Poll for outstanding IRQs when detaching a
 context
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
References: <1461301069-12331-1-git-send-email-mikey@neuling.org>
 <1461301069-12331-2-git-send-email-mikey@neuling.org>
Cc: Joerg-Stephan Vogt <JSVOGT@de.ibm.com>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Wolfgang Bolz1 <Wolfgang.Bolz@de.ibm.com>, imunsie@au1.ibm.com,
 Frank Haverkamp <HAVERKAM@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <5719B342.4020306@au1.ibm.com>
Date: Fri, 22 Apr 2016 15:14:42 +1000
MIME-Version: 1.0
In-Reply-To: <1461301069-12331-2-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/04/16 14:57, Michael Neuling wrote:
> When detaching contexts, we may still have interrupts in the system
> which are yet to be delivered to any CPU and be acked in the PSL.
> This can result in a subsequent unrelated process getting an spurious
> IRQ or an interrupt for a non-existent context.
>
> This polls the PSL to ensure that the PSL is clear of IRQs for the
> detached context, before removing the context from the idr.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Tested on top of 4.6-rc3 using the genwqe-echo test utility[0].

Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

[0] 
https://github.com/ibm-genwqe/genwqe-user/blob/master/tools/genwqe_echo.c

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
