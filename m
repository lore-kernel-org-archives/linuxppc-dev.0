Return-Path: <pmladek@suse.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRMWX44KTzDqgc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 21:52:56 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qRMWX0Slrz9sD6
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Mar 2016 21:52:55 +1100 (AEDT)
Date: Fri, 18 Mar 2016 11:52:49 +0100
From: Petr Mladek <pmladek@suse.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Balbir Singh <bsingharora@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 jeyu@redhat.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [v3,1/8] powerpc: Create a helper for getting the kernel toc value
Message-ID: <20160318105249.GO22171@pathway.suse.cz>
References: <3qNsms00H7z9snl@ozlabs.org>
 <alpine.LNX.2.00.1603150220231.3656@cbobk.fhfr.pm>
 <56E9F332.1070206@gmail.com> <20160317155928.GB32575@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160317155928.GB32575@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 2016-03-17 16:59:28, Torsten Duwe wrote:
> On Thu, Mar 17, 2016 at 10:58:42AM +1100, Balbir Singh wrote:
> > 
> > To be honest I think my v6 works well, but I don't have complete confidence
> > due to the lack of proper testing. livepatch samples plus some others I wrote
> > and I one Petr wrote all work (calling patched from within patched),
> 
> I have outlined a failure scenario for you as a reply to v6 ;)
> 
> Question to all: would it be feasible to limit the size of a single module's
> .text + TOC to let's say 8MB, and place modules at 10MB granularity? Then it
> would be unambiguous: exactly iff the high 40 bits of (TOC-LR) are zero, both
> belong to the same module.

We need to be careful about any limit. I did a quick check of the size
of modules on my system and there is one 13MB big:

13737713        ./3.12.44-52.18-default/extra/fglrx.ko

Another problem is security. If we align the modules too much, it
might make the life easier for the bad guys. Well, we do not need
to put the modules at the very beginning of the assigned slot.

Best Regards,
Petr
