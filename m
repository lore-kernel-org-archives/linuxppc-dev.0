Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DECF51A073D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 11:10:53 +1100 (AEDT)
Received: by pabfh17 with SMTP id fh17so62554513pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 16:10:50 -0800 (PST)
Subject: Re: [PATCH v7 12/50] powerpc/powernv: Track M64 segment consumption
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-13-git-send-email-gwshan@linux.vnet.ibm.com>
 <56498D77.2060101@ozlabs.ru> <20151117010446.GA26294@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <564D1382.6030504@ozlabs.ru>
Date: Thu, 19 Nov 2015 11:10:42 +1100
MIME-Version: 1.0
In-Reply-To: <20151117010446.GA26294@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/17/2015 12:04 PM, Gavin Shan wrote:
> On Mon, Nov 16, 2015 at 07:01:59PM +1100, Alexey Kardashevskiy wrote:
>> On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>> As we track M32 segment consumption, this introduces an array to
>>> the PHB to track the mapping between M64 segment and PE number.
>>> The information is going to be used to find M64 segment from the
>>> PE number during PCI unplugging time in subsequent patches.
>>
>>
>> It would not hurt to put a few words about how we managed to live without
>> such a mapping for M64 before but we needed mapping for M32.
>>
>
> The M32 mapping (phb->ioda.m32_segmap[]) isn't used for anything before
> this patcheset. There're no need for M64 mapping before this patchset
> similarly, no need to add the words.

After years I learned that reviewers ask less questions about new but yet 
unused code when I put few words in the commit log confirming that it is 
not used now but it will be used for <here I put what it is for> later.

And it is not obvious that m32_segment is not used. And m64_segmap is 
started being used only 13 patches later in:

[PATCH v7 27/50] powerpc/powernv: Dynamically release PEs

which is quite far, complicates reviewing. 12/50 is better be moved there 
(to make it 26/50) or just merged into 27/50.


-- 
Alexey
