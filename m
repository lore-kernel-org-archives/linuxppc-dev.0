Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A66D1A0170
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 22:53:58 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 30 Aug 2015 22:53:57 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 94018357804F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 22:53:54 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7UCri9h34209850
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 22:53:52 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7UCrLV6022633
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 22:53:22 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 09/10] kasan: Prevent deadlock in kasan reporting
In-Reply-To: <CAPAsAGwhV6tr3byk8kgjTxrLS0kKoyhoW8AUAXkjLVOaUbuVUA@mail.gmail.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1440577578-15813-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAPAsAGwhV6tr3byk8kgjTxrLS0kKoyhoW8AUAXkjLVOaUbuVUA@mail.gmail.com>
Date: Sun, 30 Aug 2015 18:23:02 +0530
Message-ID: <8737z1q6oh.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrey Ryabinin <ryabinin.a.a@gmail.com> writes:

> 2015-08-26 11:26 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
>> We we end up calling kasan_report in real mode, our shadow mapping
>> for even spinlock variable will show poisoned.
>
> Generally I agree with this patch. We should disable reports when we
> print report as early
> as possible to prevent recursion in case of bug in spinlock or printk etc.
>
> But I don't understand what is the problem that you observing.
> How we ended up with shadow poisoned for a valid spinlock struct?
> And since  shadow poisoned for some valid memory we should get
> enormous amount of false positive reports.
>

I still haven't fully isolated all the .c files which should not be
kasan instrumented. That means in case of ppc64 i ended up calling
kasan _load/_store in real mode. That will result in failure w.r.t
to the above spin_lock code.

-aneesh
