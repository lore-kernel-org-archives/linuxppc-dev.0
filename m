Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E5751A0C45
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 17:23:49 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 22 Jan 2015 16:23:48 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 31D1F2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 17:23:46 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0M6NcOL42664174
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 17:23:46 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0M6NDSB015330
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 17:23:13 +1100
Date: Thu, 22 Jan 2015 17:22:48 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/powernv: Don't alloc IRQ map if necessary
Message-ID: <20150122062248.GA18874@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1420695752-924-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150122055459.A5B3C140281@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150122055459.A5B3C140281@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 22, 2015 at 04:54:59PM +1100, Michael Ellerman wrote:
>On Thu, 2015-08-01 at 05:42:32 UTC, Gavin Shan wrote:
>> On PowerNV platform, the OPAL interrupts are exported by firmware
>> through device-node property (/ibm,opal::opal-interrupts). Under
>> some extreme circumstances (e.g. simulator), we don't have this
>> property found from the device tree. For that case, we shouldn't
>> allocate the interrupt map. Otherwise, slab complains allocating
>> zero sized memory chunk.
>
>That sounds fine. But the implementation is a bit messy.
>
>Can you do a precursor patch which moves the logic into opal_irq_init(), that
>way when you find no interrupts you can just return.
>

Sure, I'll change the code accordingly and repost.

Thanks,
Gavin

>cheers
>
