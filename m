Return-Path: <felix@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lWbN6v8NzF2fH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 18:54:40 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4F8s0LX005655
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 04:54:37 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hyreh9de8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 04:54:37 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.ibm.com>;
 Tue, 15 May 2018 09:54:35 +0100
Subject: Re: [PATCH v4 1/2] cxl: Set the PBCQ Tunnel BAR register when
 enabling capi mode
To: Michael Ellerman <mpe@ellerman.id.au>,
 "stewart@linux.vnet.ibm.com" <stewart@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20180514082736.3699-1-felix@linux.ibm.com>
 <87sh6upl2i.fsf@concordia.ellerman.id.au>
 <f95e5788-dd8e-8ac9-84e2-9a3fad0e307c@linux.ibm.com>
 <87r2mdo57x.fsf@concordia.ellerman.id.au>
Cc: fbarrat@linux.ibm.com, clombard@linux.ibm.com, benh@au1.ibm.com
From: Philippe Bergheaud <felix@linux.ibm.com>
Date: Tue, 15 May 2018 10:54:31 +0200
MIME-Version: 1.0
In-Reply-To: <87r2mdo57x.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <51771ac5-02c3-0e84-eba7-855ecebcaf9d@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/05/2018 07:30, Michael Ellerman wrote:
> Philippe Bergheaud <felix@linux.ibm.com> writes:
>
>> On 14/05/2018 12:51, Michael Ellerman wrote:
>>> Philippe Bergheaud <felix@linux.ibm.com> writes:
>>>
>>>> Skiboot used to set the default Tunnel BAR register value when capi mode
>>>> was enabled. This approach was ok for the cxl driver, but prevented other
>>>> drivers from choosing different values.
>>>>
>>>> Skiboot versions > 5.11 will not set the default value any longer. This
>>>> patch modifies the cxl driver to set/reset the Tunnel BAR register when
>>>> entering/exiting the cxl mode, with pnv_pci_set_tunnel_bar().
>>>>
>>>> That should work with old skiboot (since we are re-writing the value
>>>> already set) and new skiboot.
>>> But doesn't that mean new skiboot can't boot any old kernel? That seems
>>> undesirable.
>> Yes, with new skiboot, all kernels will boot.
> OK.
>
>> Capi mode tunnelled operations did not work until linux-4.17-rc1 (Apr
>> 15, 2008). With new skiboot, kernels since linux-4.17-rc1 will loose
>          ^
>          1
>
>> tunneled operations in capi mode, until this patch set is merged.
> So it would be preferable if I put this patch into 4.17, so that the
> 4.17 release works. Am I right?

Yes.

>
>> Capi mode tunneled operations are not used in any IBM or partner GA
>> products. The feature will be fully supported after this patch set and
>> the libcxl PR https://github.com/ibm-capi/libcxl/pull/29 are merged.
> OK. In general I ignore that sort of stuff because people also ignore it
> when they're filing bugs against the kernel. So if it's in the tree we
> want it to work (as much as possible), regardless of what's been GA'ed,
> or is supported officially etc.
>
> cheers
>
