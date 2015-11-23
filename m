Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D47F1A013E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 09:43:32 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 24 Nov 2015 08:43:30 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8DB112BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 09:43:25 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANMhHpx64749618
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 09:43:25 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANMgqKA001281
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 09:42:53 +1100
Date: Tue, 24 Nov 2015 09:42:27 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 12/50] powerpc/powernv: Track M64 segment consumption
Message-ID: <20151123224227.GB5375@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-13-git-send-email-gwshan@linux.vnet.ibm.com>
 <56498D77.2060101@ozlabs.ru> <20151117010446.GA26294@gwshan>
 <564D1382.6030504@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <564D1382.6030504@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 19, 2015 at 11:10:42AM +1100, Alexey Kardashevskiy wrote:
>On 11/17/2015 12:04 PM, Gavin Shan wrote:
>>On Mon, Nov 16, 2015 at 07:01:59PM +1100, Alexey Kardashevskiy wrote:
>>>On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>>>As we track M32 segment consumption, this introduces an array to
>>>>the PHB to track the mapping between M64 segment and PE number.
>>>>The information is going to be used to find M64 segment from the
>>>>PE number during PCI unplugging time in subsequent patches.
>>>
>>>
>>>It would not hurt to put a few words about how we managed to live without
>>>such a mapping for M64 before but we needed mapping for M32.
>>>
>>
>>The M32 mapping (phb->ioda.m32_segmap[]) isn't used for anything before
>>this patcheset. There're no need for M64 mapping before this patchset
>>similarly, no need to add the words.
>
>After years I learned that reviewers ask less questions about new but yet
>unused code when I put few words in the commit log confirming that it is not
>used now but it will be used for <here I put what it is for> later.
>
>And it is not obvious that m32_segment is not used. And m64_segmap is started
>being used only 13 patches later in:
>
>[PATCH v7 27/50] powerpc/powernv: Dynamically release PEs
>
>which is quite far, complicates reviewing. 12/50 is better be moved there (to
>make it 26/50) or just merged into 27/50.
>

It doesn't make sense to me. As said in PATCH[00/50], the patchset consists of
3 separate parts: PowerNV PCI rework; Using PCI slot; Hotplug standalone driver;
For the first part ("PowerNV PCI rework"), the patches are organized in order:
refactor/cleanup, IO/M32/M64, DMA, PE allocation/deallocation. So I don't think
I need move the patch around if you don't have a stronger reason.

Thanks,
Gavin
