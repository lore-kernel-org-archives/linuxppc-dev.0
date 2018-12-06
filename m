Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C488BC64EB1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 18:10:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB9120868
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 18:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB9120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439kDc04gNzDrBh
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 05:10:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ravnborg.org
 (client-ip=109.247.116.14; helo=asavdk3.altibox.net;
 envelope-from=sam@ravnborg.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ravnborg.org
Received: from asavdk3.altibox.net (asavdk3.altibox.net [109.247.116.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439kB86qpyzDqB4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 05:08:48 +1100 (AEDT)
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk3.altibox.net (Postfix) with ESMTPS id 3A8DD2007D;
 Thu,  6 Dec 2018 19:08:28 +0100 (CET)
Date: Thu, 6 Dec 2018 19:08:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 5/6] arch: simplify several early memory allocations
Message-ID: <20181206180826.GB19166@ravnborg.org>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-6-git-send-email-rppt@linux.ibm.com>
 <20181203162908.GB4244@ravnborg.org>
 <20181203164920.GB26700@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203164920.GB26700@rapoport-lnx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=5FtgESxhPiTmXxFRN-kA:9 a=CjuIK1q_8ugA:10
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
 linux-mm@kvack.org, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Mark Salter <msalter@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 03, 2018 at 06:49:21PM +0200, Mike Rapoport wrote:
> On Mon, Dec 03, 2018 at 05:29:08PM +0100, Sam Ravnborg wrote:
> > Hi Mike.
> > 
> > > index c37955d..2a17665 100644
> > > --- a/arch/sparc/kernel/prom_64.c
> > > +++ b/arch/sparc/kernel/prom_64.c
> > > @@ -34,16 +34,13 @@
> > >  
> > >  void * __init prom_early_alloc(unsigned long size)
> > >  {
> > > -	unsigned long paddr = memblock_phys_alloc(size, SMP_CACHE_BYTES);
> > > -	void *ret;
> > > +	void *ret = memblock_alloc(size, SMP_CACHE_BYTES);
> > >  
> > > -	if (!paddr) {
> > > +	if (!ret) {
> > >  		prom_printf("prom_early_alloc(%lu) failed\n", size);
> > >  		prom_halt();
> > >  	}
> > >  
> > > -	ret = __va(paddr);
> > > -	memset(ret, 0, size);
> > >  	prom_early_allocated += size;
> > >  
> > >  	return ret;
> > 
> > memblock_alloc() calls memblock_alloc_try_nid().
> > And if allocation fails then memblock_alloc_try_nid() calls panic().
> > So will we ever hit the prom_halt() code?
> 
> memblock_phys_alloc_try_nid() also calls panic if an allocation fails. So
> in either case we never reach prom_halt() code.

So we have code here we never reach - not nice.
If the idea is to avoid relying on the panic inside memblock_alloc() then
maybe replace it with a variant that do not call panic?
To make it clear what happens.

	Sam
