Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHmhV3PL8zDvhd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 10:20:10 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id i88so6792504pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 15:20:10 -0800 (PST)
Subject: Re: [PATCH v7 2/5] mm: remove x86-only restriction of movable_node
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton
 <akpm@linux-foundation.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
References: <1479160961-25840-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1479160961-25840-3-git-send-email-arbab@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 devicetree@vger.kernel.org, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <37a9339f-0ce9-261f-90de-be8463705bb5@gmail.com>
Date: Tue, 15 Nov 2016 10:20:00 +1100
MIME-Version: 1.0
In-Reply-To: <1479160961-25840-3-git-send-email-arbab@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 15/11/16 09:02, Reza Arbab wrote:
> In commit c5320926e370 ("mem-hotplug: introduce movable_node boot
> option"), the memblock allocation direction is changed to bottom-up and
> then back to top-down like this:
> 
> 1. memblock_set_bottom_up(true), called by cmdline_parse_movable_node().
> 2. memblock_set_bottom_up(false), called by x86's numa_init().
> 
> Even though (1) occurs in generic mm code, it is wrapped by #ifdef
> CONFIG_MOVABLE_NODE, which depends on X86_64.
> 
> This means that when we extend CONFIG_MOVABLE_NODE to non-x86 arches,
> things will be unbalanced. (1) will happen for them, but (2) will not.
> 
> This toggle was added in the first place because x86 has a delay between
> adding memblocks and marking them as hotpluggable. Since other arches do
> this marking either immediately or not at all, they do not require the
> bottom-up toggle.
> 
> So, resolve things by moving (1) from cmdline_parse_movable_node() to
> x86's setup_arch(), immediately after the movable_node parameter has
> been parsed.
> 
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>


Acked-by: Balbir Singh <bsingharora@gmail.com>
