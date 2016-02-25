Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D74031A0341
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 01:06:41 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2CFF1140322
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 01:06:41 +1100 (AEDT)
Date: Thu, 25 Feb 2016 15:06:38 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 06/12] powerpc/module: Rework is_early_mcount_callsite()
Message-ID: <20160225140638.GH21932@lst.de>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-6-git-send-email-mpe@ellerman.id.au>
 <56CE3F25.8030100@gmail.com> <1456396112.15739.7.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456396112.15739.7.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 25, 2016 at 09:28:32PM +1100, Michael Ellerman wrote:
> On Thu, 2016-02-25 at 10:39 +1100, Balbir Singh wrote:
> > On 25/02/16 01:28, Michael Ellerman wrote:
> > > is_early_mcount_callsite() needs to detect either the two instruction or
> > > the three instruction versions of the _mcount() sequence.
> > > 
> > > But if we're running a kernel with the two instruction sequence, we need
> > > to be careful not to read instruction - 2, otherwise we might fall off
> > > the front of a page and cause an oops.
> > > 
> > > While we're here convert to bool to make the return semantics clear.
> > > 
> > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

I wouldn't mind if you had folded this into the previous patch, see comments there.

> > > 
> > Do we even need to do this anymore?
> 
> Yes. Otherwise the code in apply_relocate_add() will see a far call with no nop
> slot after it to do the toc restore, and it considers that a bug (which it
> usually is, except mcount is special).
> 
> As we discussed today I'm hoping we can clean this code up a bit more in the
> medium term, but this works for now.

Agreed.
Reviewed-by: Torsten Duwe <duwe@suse.de>

	Torsten
