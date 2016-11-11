Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFMTh6ql0zDvdJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 12:17:28 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id i88so333626pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 17:17:28 -0800 (PST)
Subject: Re: [PATCH v6 4/4] of/fdt: mark hotpluggable memory
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton
 <akpm@linux-foundation.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
References: <1478562276-25539-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1478562276-25539-5-git-send-email-arbab@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 devicetree@vger.kernel.org, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <2627373d-b90c-10f6-90b6-2ee74029b74f@gmail.com>
Date: Fri, 11 Nov 2016 12:17:18 +1100
MIME-Version: 1.0
In-Reply-To: <1478562276-25539-5-git-send-email-arbab@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/11/16 10:44, Reza Arbab wrote:
> When movable nodes are enabled, any node containing only hotpluggable
> memory is made movable at boot time.
> 
> On x86, hotpluggable memory is discovered by parsing the ACPI SRAT,
> making corresponding calls to memblock_mark_hotplug().
> 
> If we introduce a dt property to describe memory as hotpluggable,
> configs supporting early fdt may then also do this marking and use
> movable nodes.
> 
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---

Tested-by: Balbir Singh <bsingharora@gmail.com>

I tested this with a custom device tree and it worked quite well for me.
It also means that the guest and bare-metal have two different mechanisms
of marking something as hotpluggable. But given that your patch enables
all architectures using OF, it might be worth it.

Balbir Singh.
