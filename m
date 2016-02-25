Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38D781A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 21:28:33 +1100 (AEDT)
Message-ID: <1456396112.15739.7.camel@ellerman.id.au>
Subject: Re: [PATCH 06/12] powerpc/module: Rework is_early_mcount_callsite()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz,  live-patching@vger.kernel.org, mbenes@suse.cz
Date: Thu, 25 Feb 2016 21:28:32 +1100
In-Reply-To: <56CE3F25.8030100@gmail.com>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-6-git-send-email-mpe@ellerman.id.au>
 <56CE3F25.8030100@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-02-25 at 10:39 +1100, Balbir Singh wrote:
> On 25/02/16 01:28, Michael Ellerman wrote:
> > is_early_mcount_callsite() needs to detect either the two instruction or
> > the three instruction versions of the _mcount() sequence.
> > 
> > But if we're running a kernel with the two instruction sequence, we need
> > to be careful not to read instruction - 2, otherwise we might fall off
> > the front of a page and cause an oops.
> > 
> > While we're here convert to bool to make the return semantics clear.
> > 
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > 
> Do we even need to do this anymore?

Yes. Otherwise the code in apply_relocate_add() will see a far call with no nop
slot after it to do the toc restore, and it considers that a bug (which it
usually is, except mcount is special).

As we discussed today I'm hoping we can clean this code up a bit more in the
medium term, but this works for now.

cheers
