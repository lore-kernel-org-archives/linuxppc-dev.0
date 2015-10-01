Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCD641A03D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 03:11:15 +1000 (AEST)
Subject: Re: [PATCH v3 1/3] powerpc/512x: add LocalPlus Bus FIFO device driver
To: alex.popov@linux.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anatolij Gustschin <agust@denx.de>, Rob Herring <robh@kernel.org>,
 Grant Likely <grant.likely@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1443115737-3948-1-git-send-email-alex.popov@linux.com>
 <1443115737-3948-2-git-send-email-alex.popov@linux.com>
 <56049CD0.7080104@tabi.org> <560C5325.6070406@linux.com>
From: Timur Tabi <timur@tabi.org>
Message-ID: <560D692E.1010309@tabi.org>
Date: Thu, 1 Oct 2015 12:11:10 -0500
MIME-Version: 1.0
In-Reply-To: <560C5325.6070406@linux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/30/2015 04:24 PM, Alexander Popov wrote:

>> Can you test for "!cs" here instead?
>>
>>> +        e = -EFAULT;
>>> +        goto err_param;
>>> +    }
>
> Unfortunately no: 0 is a valid value for Chip Select.
> Is it OK to leave it like that?

Yes.

>>> +    lpbfifo.ram_bus_addr = sg_dma_address(&sg); /* For freeing later */
>>> +    sg_dma_len(&sg) = lpbfifo.req->size;
>>
>> I don't think sg_dma_len() is meant to be used as an lvalue.
>
> I've double-checked and found many cases of such usage of this macro.
> It seems that I can't avoid it too.

Ok.

>> Driver code that has to parse #address-cells or #size-cells
>> is usually wrong.
>
> I would not call it "parsing", I just check whether the dts-file is good.
> Anyway, could you give me a clue how to do better?

You should use of_n_size_cells() and of_n_addr_cells().

-- 
