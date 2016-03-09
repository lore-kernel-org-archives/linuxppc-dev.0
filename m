Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA7DD1A0118
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 22:16:51 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F408C140297
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 22:16:50 +1100 (AEDT)
Date: Wed, 9 Mar 2016 12:16:47 +0100
From: Torsten Duwe <duwe@lst.de>
To: Jiri Kosina <jikos@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Balbir Singh <bsingharora@gmail.com>,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, jeyu@redhat.com,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH][v6][RFC] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160309111647.GA27913@lst.de>
References: <1457506780-19556-1-git-send-email-bsingharora@gmail.com>
 <20160309091904.GA23039@lst.de> <20160309094423.GH10940@pathway.suse.cz>
 <20160309100328.GB23039@lst.de>
 <alpine.LNX.2.00.1603091110510.3656@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1603091110510.3656@cbobk.fhfr.pm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2016 at 11:13:05AM +0100, Jiri Kosina wrote:
> On Wed, 9 Mar 2016, Torsten Duwe wrote:
> > was my first choice. Arguments on the stack? I thought we'll deal with them
> > once we get there (e.g. _really_ need to patch a varargs function or one
> > with a silly signature).
> 
> Well, the problem is, once such need arises, it's too late already.

No, not if it's documented.

> You need to be able to patch the kernels which are already out there, 
> running on machines potentially for ages once all of a sudden there is a 
> CVE for >8args / varargs function.

Then you'd need a solution like I sent out yesterday, with a pre-prologue
caller that pops the extra frame, so the replacement can be more straight-
forward. Or you can just deal with the shifted offsets in the replacement.

I'll try to demonstrate the alternative. That would then be required for
_all_ replacement functions. Or can the live patching framework differentiate
and tell ftrace_caller whether to place a stack frame or not?

Miroslav? Petr? Can we have 2 sorts of replacement functions?

	Torsten
