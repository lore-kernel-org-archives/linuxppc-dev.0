Return-Path: <michaele@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydGqJ2T1WzDrFk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 09:57:47 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAGMsNkM132817
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 17:57:45 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e9j6rmdrd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 17:57:44 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <michaele@au1.ibm.com>;
 Thu, 16 Nov 2017 22:57:42 -0000
From: Michael Ellerman <michaele@au1.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: alexander.h.duyck@intel.com, dipankar@linux.vnet.ibm.com,
 stable@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, brking@pobox.com
Subject: Re: [Intel-wired-lan] [PATCH 0/7] [RESEND] [net] intel: Use smp_rmb
 rather than read_barrier_depends
In-Reply-To: <f360a8cd-518c-1df5-5ffd-91a0e9688ce2@linux.vnet.ibm.com>
References: <1510846675-15169-1-git-send-email-brking@linux.vnet.ibm.com>
 <20171116113358.00001d5a@intel.com>
 <f360a8cd-518c-1df5-5ffd-91a0e9688ce2@linux.vnet.ibm.com>
Date: Fri, 17 Nov 2017 09:57:36 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87375dvnkv.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Brian King <brking@linux.vnet.ibm.com> writes:

> On 11/16/2017 01:33 PM, Jesse Brandeburg wrote:
>> On Thu, 16 Nov 2017 09:37:48 -0600
>> Brian King <brking@linux.vnet.ibm.com> wrote:
>> 
>>> Resending as the first attempt is not showing up in the list archive.
>>>
>>> This patch converts several network drivers to use smp_rmb
>>> rather than read_barrier_depends. The initial issue was
>>> discovered with ixgbe on a Power machine which resulted
>>> in skb list corruption due to fetching a stale skb pointer.
>>> More details can be found in the ixgbe patch description.
>> 
>> Thanks for the fix Brian, I bet it was a tough debug.
>> 
>> The only users in the entire kernel of read_barrier_depends() (not
>> smp_read_barrier_depends) are the Intel network drivers.
>> 
>> Wouldn't it be better for power to just fix read_barrier_depends to do
>> the right thing on power? The question I'm not sure of the answer to is:
>> Is it really the wrong barrier to be using or is the implementation in
>> the kernel powerpc wrong?
>> 
>> So I think the right thing might actually to be to:
>> Fix arch powerpc read_barrier_depends to not be a noop, as the
>> semantics of the read_barrier_depends seems to be sufficient to solve
>> this problem, but it seems not to work for powerpc?
>
> Jesse,
>
> Thanks for the quick response.
>
> Cc'ing linuxppc-dev as well. 
>
> I did think about changing the powerpc definition of read_barrier_depends,
> but after reading up on that barrier, decided it was not the correct barrier
> to be used in this context. Here is some good historical background on
> read_barrier_depends that I found, along with an example.
>
> https://lwn.net/Articles/5159/
>
> Since there is no data-dependency in the code in question here, I think
> the smp_rmb is the proper barrier to use.

Yes I agree.

The read_barrier_depends() is correct to order the load of eop_desc and
then the dependent load of eop_desc->wb.status, but it's only required
or does anything on Alpha.

> For background, the code in question looks like this:
>
> CPU 1                                   CPU2
> ============================            ============================
> 1: ixgbe_xmit_frame_ring                ixgbe_clean_tx_irq
> 2:  first->skb = skb                     eop_desc = tx_buffer->next_to_watch
>                                          if (!eop_desc)
>                                              break;
> 3:  ixgbe_tx_map                         read_barrier_depends()
>                                          if (!(eop_desc->wb.status) ... )
>                                              break;
> 4:   wmb                                 
> 5:   first->next_to_watch = tx_desc      napi_consume_skb(tx_buffer->skb ..);
> 6:   writel(i, tx_ring->tail);
>
> What we see on powerpc is that tx_buffer->skb on CPU2 is getting loaded
> prior to tx_buffer->next_to_watch. Changing the read_barrier_depends
> to a smp_rmb solves this and prevents us from dereferencing old pointer.

Right. Given that read_barrier_depends() is a nop, there's nothing there
to order the load of tx_buffer->skb vs anything else.

If it's actually the load of tx_buffer->skb that's the issue then the
smp_rmb() should really be immediately prior to that, rather than where
the read_barrier_depends() currently is.

cheers
