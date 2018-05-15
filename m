Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lR4M2zmNzF2sS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 15:30:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Philippe Bergheaud <felix@linux.ibm.com>,
 "stewart\@linux.vnet.ibm.com" <stewart@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: fbarrat@linux.ibm.com, clombard@linux.ibm.com, benh@au1.ibm.com
Subject: Re: [PATCH v4 1/2] cxl: Set the PBCQ Tunnel BAR register when
 enabling capi mode
In-Reply-To: <f95e5788-dd8e-8ac9-84e2-9a3fad0e307c@linux.ibm.com>
References: <20180514082736.3699-1-felix@linux.ibm.com>
 <87sh6upl2i.fsf@concordia.ellerman.id.au>
 <f95e5788-dd8e-8ac9-84e2-9a3fad0e307c@linux.ibm.com>
Date: Tue, 15 May 2018 15:30:58 +1000
Message-ID: <87r2mdo57x.fsf@concordia.ellerman.id.au>
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

Philippe Bergheaud <felix@linux.ibm.com> writes:

> On 14/05/2018 12:51, Michael Ellerman wrote:
>> Philippe Bergheaud <felix@linux.ibm.com> writes:
>>
>>> Skiboot used to set the default Tunnel BAR register value when capi mode
>>> was enabled. This approach was ok for the cxl driver, but prevented other
>>> drivers from choosing different values.
>>>
>>> Skiboot versions > 5.11 will not set the default value any longer. This
>>> patch modifies the cxl driver to set/reset the Tunnel BAR register when
>>> entering/exiting the cxl mode, with pnv_pci_set_tunnel_bar().
>>>
>>> That should work with old skiboot (since we are re-writing the value
>>> already set) and new skiboot.
>> But doesn't that mean new skiboot can't boot any old kernel? That seems
>> undesirable.
>
> Yes, with new skiboot, all kernels will boot.

OK.

> Capi mode tunnelled operations did not work until linux-4.17-rc1 (Apr 
> 15, 2008). With new skiboot, kernels since linux-4.17-rc1 will loose 
        ^
        1

> tunneled operations in capi mode, until this patch set is merged.

So it would be preferable if I put this patch into 4.17, so that the
4.17 release works. Am I right?

> Capi mode tunneled operations are not used in any IBM or partner GA 
> products. The feature will be fully supported after this patch set and 
> the libcxl PR https://github.com/ibm-capi/libcxl/pull/29 are merged.

OK. In general I ignore that sort of stuff because people also ignore it
when they're filing bugs against the kernel. So if it's in the tree we
want it to work (as much as possible), regardless of what's been GA'ed,
or is supported officially etc.

cheers
