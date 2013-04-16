Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 76ECB2C00F7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 12:52:03 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Tue, 16 Apr 2013 08:17:22 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B4330125804E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 08:23:23 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3G2pmFZ57081944
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 08:21:48 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3G2pr2Z023591
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 12:51:53 +1000
Message-ID: <1366080710.12424.41.camel@ThinkPad-T5421.cn.ibm.com>
Subject: Re: [RFC PATCH v2 3/4] powerpc: Don't bolt the hpte in
 kernel_map_linear_page()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 16 Apr 2013 10:51:50 +0800
In-Reply-To: <1366025246.24994.35.camel@pasglop>
References: <1365733021-28912-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1365733021-28912-4-git-send-email-zhong@linux.vnet.ibm.com>
 <20130415035031.GA7494@iris.ozlabs.ibm.com>
 <1366008995.24994.25.camel@pasglop>
 <1366013711.12424.33.camel@ThinkPad-T5421.cn.ibm.com>
 <1366025246.24994.35.camel@pasglop>
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

On Mon, 2013-04-15 at 13:27 +0200, Benjamin Herrenschmidt wrote:
> On Mon, 2013-04-15 at 16:15 +0800, Li Zhong wrote:
> 
> > So the code is implemented in ppc_md.hpte_remove(), may be called by
> > __hash_huge_page(), and asm code htab_call_hpte_remove?
> > 
> > > This is why the linear mapping (and the vmemmap) must be bolted.
> > 
> > If not, it would result the infinite recursion like above?
> 
> Potentially, we don't expect to fault linear mapping or vmemmap entries
> on demand. We aren't equipped to do it and we occasionally have code
> path that access the linear mapping and cannot afford to have SRR0 and
> SRR1 clobbered by a page fault.

Thank you for the education :)

Thanks, Zhong

> 
> Cheers,
> Ben.
> 
> 
