Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6B8A22C00E6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 21:29:18 +1000 (EST)
Message-ID: <1366025246.24994.35.camel@pasglop>
Subject: Re: [RFC PATCH v2 3/4] powerpc: Don't bolt the hpte in
 kernel_map_linear_page()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Mon, 15 Apr 2013 13:27:26 +0200
In-Reply-To: <1366013711.12424.33.camel@ThinkPad-T5421.cn.ibm.com>
References: <1365733021-28912-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1365733021-28912-4-git-send-email-zhong@linux.vnet.ibm.com>
 <20130415035031.GA7494@iris.ozlabs.ibm.com>
 <1366008995.24994.25.camel@pasglop>
 <1366013711.12424.33.camel@ThinkPad-T5421.cn.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-04-15 at 16:15 +0800, Li Zhong wrote:

> So the code is implemented in ppc_md.hpte_remove(), may be called by
> __hash_huge_page(), and asm code htab_call_hpte_remove?
> 
> > This is why the linear mapping (and the vmemmap) must be bolted.
> 
> If not, it would result the infinite recursion like above?

Potentially, we don't expect to fault linear mapping or vmemmap entries
on demand. We aren't equipped to do it and we occasionally have code
path that access the linear mapping and cannot afford to have SRR0 and
SRR1 clobbered by a page fault.

Cheers,
Ben.
