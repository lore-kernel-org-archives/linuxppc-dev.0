Return-Path: <wladislav.kw@gmail.com>
Received: from mail-we0-x232.google.com (mail-we0-x232.google.com
 [IPv6:2a00:1450:400c:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3DB922C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 18:51:33 +1000 (EST)
Received: by mail-we0-f178.google.com with SMTP id u57so1456208wes.37
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Aug 2013 01:51:27 -0700 (PDT)
Message-ID: <51FA2167.7060305@gmail.com>
Date: Thu, 01 Aug 2013 10:50:47 +0200
From: Wladislav Wiebe <wladislav.kw@gmail.com>
MIME-Version: 1.0
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: mm/slab: ppc: ubi: kmalloc_slab WARNING / PPC + UBI driver
References: <51F8F827.6020108@gmail.com>
 <20130731173434.GA27470@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20130731173434.GA27470@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Cc: dedekind1@gmail.com, dwmw2@infradead.org, penberg@kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, cl@linux.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 31/07/13 19:34, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, Jul 31, 2013 at 01:42:31PM +0200, Wladislav Wiebe wrote:
>> DEBUG: xxx kmalloc_slab, requested 'size' = 8388608, KMALLOC_MAX_SIZE = 4194304
> [...]
> 
> It seems some procfs file is trying to dump 8 MB at a single go. You
> need to fix that to return data in smaller chunks. What file is it?

seems it's coming from DT:
..
DEBUG: xxx seq_path: file path = /proc/device-tree/localbus@5000/flash@0/partition@1/reg
------------[ cut here ]------------
..

need to check if and how it's possible divide it in smaller chunks.
If somebody has suggestions, feel free to comment-)

Thanks & BR
Wladislav Wiebe
