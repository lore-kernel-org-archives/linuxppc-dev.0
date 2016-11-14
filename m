Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTbN0TFNzDvLb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 22:59:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 devicetree@vger.kernel.org, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>, Balbir Singh <bsingharora@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] of/fdt: mark hotpluggable memory
In-Reply-To: <1478562276-25539-5-git-send-email-arbab@linux.vnet.ibm.com>
References: <1478562276-25539-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1478562276-25539-5-git-send-email-arbab@linux.vnet.ibm.com>
Date: Mon, 14 Nov 2016 22:59:43 +1100
Message-ID: <87bmxii85s.fsf@concordia.ellerman.id.au>
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

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> When movable nodes are enabled, any node containing only hotpluggable
> memory is made movable at boot time.
>
> On x86, hotpluggable memory is discovered by parsing the ACPI SRAT,
> making corresponding calls to memblock_mark_hotplug().
>
> If we introduce a dt property to describe memory as hotpluggable,
> configs supporting early fdt may then also do this marking and use
> movable nodes.

So I'm not opposed to this, but it is a little vague.

What does the "hotpluggable" property really mean?

Is it just a hint to the operating system? (which may or may not be
Linux).

Or is it a direction, "this memory must be able to be hotunplugged"?

I think you're intending the former, ie. a hint, which is probably OK.
But it needs to be documented clearly.

cheers
