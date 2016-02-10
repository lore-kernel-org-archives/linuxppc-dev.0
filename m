Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27F011A006D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 14:14:30 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 9 Feb 2016 20:14:29 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id F1EEC3E40044
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 20:14:25 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1A3EPXB30802034
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 20:14:25 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1A3EPxw031104
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 20:14:25 -0700
Date: Tue, 9 Feb 2016 19:14:10 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/perf/hv-gpci: Increase request buffer size
Message-ID: <20160210031410.GA1483@us.ibm.com>
References: <20160209030830.GA4815@us.ibm.com>
 <20160209094518.B91C7140B9A@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160209094518.B91C7140B9A@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [mpe@ellerman.id.au] wrote:
> Here you read from bytes[i] where i can be > 1 (AFAICS).

Yes, buffer is large enough and I thought this construct of
array was used in a several places. Maybe they are being
changed out now (struct pid has one such usage).

> 
> That's fishy at best, and newer GCCs just don't allow it.

Ah, ok.
> 
> I think you could do this and it would work, but untested:
> 
>    struct hv_gpci_request_buffer {
>    	struct hv_get_perf_counter_info_params params;
>    	uint8_t bytes[4096 - sizeof(struct hv_get_perf_counter_info_parms)];

There is a macro for this computation in that file. I could have
used that. Will change it and repost.

Thanks,

Sukadev
