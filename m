Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 367E81A0958
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 04:28:40 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 22:58:37 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C6E341258019
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 22:58:18 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9DHSX9r3866886
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 22:58:33 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9DHSWRS009729
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 22:58:33 +0530
Message-ID: <561D3F81.3010506@linux.vnet.ibm.com>
Date: Tue, 13 Oct 2015 22:59:37 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jeff Moyer <jmoyer@redhat.com>
CC: axboe@kernel.dk, linuxppc-dev@lists.ozlabs.org, ming.lei@canonical.com,
 keith.busch@intel.com, snitzer@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block-mq:Fix the null memory access while setting tags
 cpumask
References: <1444713927-16261-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <x491tcy7m2j.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x491tcy7m2j.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/13/2015 10:17 PM, Jeff Moyer wrote:
> Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> writes:
>
>> In nr_hw_queues >1 cases when certain number of cpus are onlined/or
>> offlined, that results change in request_queue map in block-mq layer,
>> we see the kernel dumping like:
>
> What version is that patch against?  This problem should be fixed by the
> patch set from Akinobu Mita.  I tested cpu hot-plugging on my system
> with an nvme device, and it is fixed there on mainline.
>

Hi Jeff,

My patch was against (4.3.0-rc2) bcee19f424a.

I do see now that  commit 1356aae08338 (blk-mq: avoid setting
hctx->tags->cpumask before allocation) has equivalent fix.

Thanks for the information.
