Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D6FC1A033A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 17:04:44 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 16 Jun 2014 12:34:42 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 29ADFE0053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 12:35:44 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5G74rHR38010970
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 12:34:53 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5G74bF0026894
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 12:34:39 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 00/10] CMA: generalize CMA reserved area management code
In-Reply-To: <20140616053209.GG23210@js1304-P5Q-DELUXE>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <87r42seyvg.fsf@linux.vnet.ibm.com>
 <20140616053209.GG23210@js1304-P5Q-DELUXE>
Date: Mon, 16 Jun 2014 12:34:14 +0530
Message-ID: <87tx7lcp3l.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, Michal Nazarewicz <mina86@mina86.com>,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joonsoo Kim <iamjoonsoo.kim@lge.com> writes:

> On Sat, Jun 14, 2014 at 12:55:39PM +0530, Aneesh Kumar K.V wrote:
>> Joonsoo Kim <iamjoonsoo.kim@lge.com> writes:
>> 
>> > Currently, there are two users on CMA functionality, one is the DMA
>> > subsystem and the other is the kvm on powerpc. They have their own code
>> > to manage CMA reserved area even if they looks really similar.
>> > From my guess, it is caused by some needs on bitmap management. Kvm side
>> > wants to maintain bitmap not for 1 page, but for more size. Eventually it
>> > use bitmap where one bit represents 64 pages.
>> >
>> > When I implement CMA related patches, I should change those two places
>> > to apply my change and it seem to be painful to me. I want to change
>> > this situation and reduce future code management overhead through
>> > this patch.
>> >
>> > This change could also help developer who want to use CMA in their
>> > new feature development, since they can use CMA easily without
>> > copying & pasting this reserved area management code.
>> >
>> > v2:
>> >   Although this patchset looks very different with v1, the end result,
>> >   that is, mm/cma.c is same with v1's one. So I carry Ack to patch 6-7.
>> >
>> > Patch 1-5 prepare some features to cover ppc kvm's requirements.
>> > Patch 6-7 generalize CMA reserved area management code and change users
>> > to use it.
>> > Patch 8-10 clean-up minor things.
>> 
>> 
>> I wanted to test the ppc changes and found that the patch series doesn't apply
>> against v3.15 . Do you have a kernel tree which I can clone to test this
>> series ?
>
> This is based on linux-next -next-20140610.
> And my tree is on following link.
>
> https://github.com/JoonsooKim/linux/tree/cma-general-v2.0-next-20140610
>
> But, I think I'm late, because you have already added a Tested-by tag.

linux-next kexec is broken on ppc64, hence I hand picked few of
dependent patches for dma CMA on top of 3.15 and used that for testing.

-aneesh
