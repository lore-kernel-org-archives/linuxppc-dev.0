Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0F341A0352
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 11:50:42 +1100 (AEDT)
Message-ID: <1457657442.22078.1.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] ppc64le live patch: get rid of mini stack frame
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>, Petr Mladek <pmladek@suse.com>
Cc: jeyu@redhat.com, jkosina@suse.cz, jikos@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com,  linuxppc-dev@ozlabs.org,
 live-patching@vger.kernel.org, mbenes@suse.cz
Date: Fri, 11 Mar 2016 11:50:42 +1100
In-Reply-To: <20160310130453.GA3983@lst.de>
References: <20160309172821.GC27913@lst.de> <20160309173017.GD27913@lst.de>
 <20160310122508.GR10940@pathway.suse.cz>
 <20160310125116.GS10940@pathway.suse.cz> <20160310130453.GA3983@lst.de>
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

On Thu, 2016-03-10 at 14:04 +0100, Torsten Duwe wrote:
> On Thu, Mar 10, 2016 at 01:51:16PM +0100, Petr Mladek wrote:
> > On Thu 2016-03-10 13:25:08, Petr Mladek wrote:
> > > On Wed 2016-03-09 18:30:17, Torsten Duwe wrote:
> > > > After the mini stack frame is no longer required for TOC storage, it can
> > > > be eliminated iff the functionality of klp_return_helper, which required
> > > > a stack frame for the extra return address previously, is carried out
> > > > by the replacement function now. This requires _every_ live patch replacement
> > > > function to execute the following (or similar) sequence of machine instructions
> > > > just before every return to the original caller:
> > > 
> > > I have thought about it and it is a nono from my point of view.
> > > It is too error prone, especially that there are functions that
> > > call return on several locations.
> 
> Yes, that's what I think as well when I look at it.

> > BTW: How is this solved in kretprobes? Or is it easier there?
> 
> Without any look at the code I assume it uses solution 3. Once
> you have a probing framework in place, you can remember the real
> return addresses in a data structure. As I wrote, the function
> graph tracer does it this way so it would be abvious.

Yeah it has a linked list of struct kretprobe_instance's, each of which stores
the real return address.

I have some ideas for how to fix livepatch, but this week is a bit busy with
merge window prep.

cheers
