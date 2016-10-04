Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp0f8379dzDrWS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 11:48:48 +1100 (AEDT)
Received: by mail-pf0-x22b.google.com with SMTP id e6so13370101pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Oct 2016 17:48:48 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] powerpc/mm: restore top-down allocation when using
 movable_node
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1474828616-16608-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1474828616-16608-5-git-send-email-arbab@linux.vnet.ibm.com>
 <1474924351.2857.255.camel@kernel.crashing.org>
 <20160927001413.o72fqpfsnsxpu5qq@arbab-laptop>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-mm@kvack.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <e161a34e-4e58-42f5-49ed-3e7913189eb9@gmail.com>
Date: Tue, 4 Oct 2016 11:48:30 +1100
MIME-Version: 1.0
In-Reply-To: <20160927001413.o72fqpfsnsxpu5qq@arbab-laptop>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 27/09/16 10:14, Reza Arbab wrote:
> On Tue, Sep 27, 2016 at 07:12:31AM +1000, Benjamin Herrenschmidt wrote:
>> In any case, if the memory hasn't been hotplug, this shouldn't be necessary as we shouldn't be considering it for allocation.
> 
> Right. To be clear, the background info I put in the commit log refers to x86, where the SRAT can describe movable nodes which exist at boot.  They're trying to avoid allocations from those nodes before they've been identified.
> 
> On power, movable nodes can only exist via hotplug, so that scenario can't happen. We can immediately go back to top-down allocation. That is the missing call being added in the patch.
> 

Can we fix cmdline_parse_movable_node() to do the right thing? I suspect that
code is heavily x86 only in the sense that no other arch needs it.

Balbir Singh.
