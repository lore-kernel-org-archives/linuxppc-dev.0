Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN9FM3DmGzDrJ2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 10:01:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?utf-8?Q?C=C3=A9dr?=
 =?utf-8?Q?ic?= Le Goater <clg@kaod.org>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/xive: fix the fuzz value in xive_pick_irq_target()
In-Reply-To: <1501711052.2664.7.camel@kernel.crashing.org>
References: <1501692230-20789-1-git-send-email-clg@kaod.org>
 <1501711052.2664.7.camel@kernel.crashing.org>
Date: Thu, 03 Aug 2017 10:01:10 +1000
Message-ID: <87r2wtr03d.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2017-08-02 at 18:43 +0200, C=C3=A9dric Le Goater wrote:
>> If xive_find_target_in_mask() fails to find a cpu, the fuzz value used
>> in xive_pick_irq_target() is decremented and reused in the last
>> returning call to xive_find_target_in_mask(). This can result in such
>> WARNINGs if the initial fuzz value is zero :
>
> Ah indeed ... would have worked better if "fuzz" had been unsigned.

Is that an ack or a changes requested?

chers
