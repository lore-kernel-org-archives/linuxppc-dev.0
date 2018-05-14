Return-Path: <felix@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40l15Z6JD5zF3L3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 23:00:34 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4ECx4MU134186
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 09:00:32 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hya2tjjnt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 09:00:31 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.ibm.com>;
 Mon, 14 May 2018 14:00:29 +0100
Subject: Re: [PATCH v4 1/2] cxl: Set the PBCQ Tunnel BAR register when
 enabling capi mode
To: Michael Ellerman <mpe@ellerman.id.au>,
 "stewart@linux.vnet.ibm.com" <stewart@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20180514082736.3699-1-felix@linux.ibm.com>
 <87sh6upl2i.fsf@concordia.ellerman.id.au>
Cc: fbarrat@linux.ibm.com, clombard@linux.ibm.com, benh@au1.ibm.com
From: Philippe Bergheaud <felix@linux.ibm.com>
Date: Mon, 14 May 2018 15:00:26 +0200
MIME-Version: 1.0
In-Reply-To: <87sh6upl2i.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f95e5788-dd8e-8ac9-84e2-9a3fad0e307c@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/05/2018 12:51, Michael Ellerman wrote:
> Philippe Bergheaud <felix@linux.ibm.com> writes:
>
>> Skiboot used to set the default Tunnel BAR register value when capi mode
>> was enabled. This approach was ok for the cxl driver, but prevented other
>> drivers from choosing different values.
>>
>> Skiboot versions > 5.11 will not set the default value any longer. This
>> patch modifies the cxl driver to set/reset the Tunnel BAR register when
>> entering/exiting the cxl mode, with pnv_pci_set_tunnel_bar().
>>
>> That should work with old skiboot (since we are re-writing the value
>> already set) and new skiboot.
> But doesn't that mean new skiboot can't boot any old kernel? That seems
> undesirable.
>
> cheers
>
Yes, with new skiboot, all kernels will boot.

Capi mode tunnelled operations did not work until linux-4.17-rc1 (Apr 
15, 2008). With new skiboot, kernels since linux-4.17-rc1 will loose 
tunneled operations in capi mode, until this patch set is merged.

Capi mode tunneled operations are not used in any IBM or partner GA 
products. The feature will be fully supported after this patch set and 
the libcxl PR https://github.com/ibm-capi/libcxl/pull/29 are merged.

Philippe
