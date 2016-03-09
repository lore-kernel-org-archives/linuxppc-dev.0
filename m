Return-Path: <pmladek@suse.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CEA471A0118
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 23:56:43 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 629A81402DE
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 23:56:42 +1100 (AEDT)
Date: Wed, 9 Mar 2016 13:56:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Jiri Kosina <jikos@kernel.org>, Balbir Singh <bsingharora@gmail.com>,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, jeyu@redhat.com,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH][v6][RFC] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160309125638.GK10940@pathway.suse.cz>
References: <1457506780-19556-1-git-send-email-bsingharora@gmail.com>
 <20160309091904.GA23039@lst.de>
 <20160309094423.GH10940@pathway.suse.cz>
 <20160309100328.GB23039@lst.de>
 <alpine.LNX.2.00.1603091110510.3656@cbobk.fhfr.pm>
 <20160309111647.GA27913@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160309111647.GA27913@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 2016-03-09 12:16:47, Torsten Duwe wrote:
> On Wed, Mar 09, 2016 at 11:13:05AM +0100, Jiri Kosina wrote:
> > On Wed, 9 Mar 2016, Torsten Duwe wrote:
> > > was my first choice. Arguments on the stack? I thought we'll deal with them
> > > once we get there (e.g. _really_ need to patch a varargs function or one
> > > with a silly signature).
> > 
> > Well, the problem is, once such need arises, it's too late already.
> 
> No, not if it's documented.
> 
> > You need to be able to patch the kernels which are already out there, 
> > running on machines potentially for ages once all of a sudden there is a 
> > CVE for >8args / varargs function.
> 
> Then you'd need a solution like I sent out yesterday, with a pre-prologue
> caller that pops the extra frame, so the replacement can be more straight-
> forward. Or you can just deal with the shifted offsets in the replacement.
> 
> I'll try to demonstrate the alternative. That would then be required for
> _all_ replacement functions. Or can the live patching framework differentiate
> and tell ftrace_caller whether to place a stack frame or not?
>
> Miroslav? Petr? Can we have 2 sorts of replacement functions?

I personally prefer to keep most functions without any special hack,
especially when it is needed only for one architecture. If a hack is
needed for "corner cases" and it is documented then, IMHO, we could
live with it for some time. We test all patches anyway, so.

But I could not speak for the LivePatching maintainers whose are Josh
and Jiri.

Best Regards,
Petr
