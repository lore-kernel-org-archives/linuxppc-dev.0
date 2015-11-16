Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02C841A0D94
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 19:02:28 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so167517387pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 00:02:26 -0800 (PST)
Subject: Re: [PATCH v7 14/50] powerpc/powernv: M64 support on P7IOC
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-15-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56498D8A.2050505@ozlabs.ru>
Date: Mon, 16 Nov 2015 19:02:18 +1100
MIME-Version: 1.0
In-Reply-To: <1446642770-4681-15-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/05/2015 12:12 AM, Gavin Shan wrote:
> This enables M64 window on P7IOC, which has been enabled on PHB3.
> Different from PHB3 where 16 M64 BARs are supported and each of
> them can be owned by one particular PE# exclusively or divided
> evenly to 256 segments, every P7IOC PHB has 16 M64 BARs and each
> of them are divided to 8 segments. So every P7IOC PHB supports
> 128 M64 segments in total. P7IOC has M64DT, which helps mapping
> one particular M64 segment# to arbitrary PE#. PHB3 doesn't have
> M64DT, indicating that one M64 segment can only be pinned to the
> fixed PE#. In order to have same code to support M64 on P7IOC and
> PHB3, we just provide 128 M64 segments on every P7IOC PHB and each
> of them is pinned to the fixed PE# by bypassing the function of
> M64DT. In turn, we just need different phb->init_m64() for P7IOC
> and PHB3 to support M64.

I thought we decided (Ben suggested?) not to push P7IOC code now (or ever) 
as there is no user for it, has this changed?

btw please put ioda1/ioda2/p7ioc/etc to the subject line to make it easier 
to see how much work is there about particular PHB type. You rename quite 
many functions and I generally want to ask you to group all renaming 
patches first but it would also make sense to keep them close to (for 
example) p7ioc-related patches so having more descriptive subject lines may 
help. Thanks.


-- 
Alexey
