Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEDE61A00FC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 11:08:27 +1000 (AEST)
Message-ID: <1440032907.13406.5.camel@ellerman.id.au>
Subject: Re: [1/1] powerpc/xmon: Paged output for paca display
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, khandual@linux.vnet.ibm.com
Date: Thu, 20 Aug 2015 11:08:27 +1000
In-Reply-To: <20150820004247.GA2363@tungsten.ozlabs.ibm.com>
References: <e9e27ee5cee97ac3be2599646243fefc319f92a9.1439520906.git.sam.bobroff@au1.ibm.com>
 <20150818062632.3C4F114032F@ozlabs.org>
 <20150820004247.GA2363@tungsten.ozlabs.ibm.com>
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

On Thu, 2015-08-20 at 10:42 +1000, Sam Bobroff wrote:
> On Tue, Aug 18, 2015 at 04:26:32PM +1000, Michael Ellerman wrote:
> > On Fri, 2015-14-08 at 02:55:14 UTC, Sam bobroff wrote:
> > > The paca display is already more than 24 lines, which can be problematic
> > > if you have an old school 80x24 terminal, or more likely you are on a
> > > virtual terminal which does not scroll for whatever reason.
...
> > > 
> > > (Based on a similar patch by Michael Ellerman <mpe@ellerman.id.au>
> > > "[v2] powerpc/xmon: Allow limiting the size of the paca display".
> > > This patch is an alternative and cannot coexist with the original.)
> > 
> > 
> > So this is nice, but ... the diff is twice the size of my version, plus 128
> > bytes of BSS, so I'm not sure the added benefit is sufficient to justify the
> > added code complexity.
> > 
> > But you can convince me otherwise if you feel strongly about it.
> 
> I do think the output is a lot better paged like this :-)

OK.

> The 128 byte buffer is a lot more than it needs for this particular command; it
> could quite comfortably be lowered to about 32 (I was leaving space for other
> commands to use it but there aren't any so far). I'll do this and repost.
> 
> Also, because the last_cmd_buf system is not specific to the paca display, it
> could be used by the other paged commands (like the memory dumps). If we did
> this we could (probably) remove ndump, nidump and ncsum which are all longs,
> although I haven't worked out how much buffer space would be needed in
> last_cmd_buf to support these (they have their own paging code but the
> positional information could be stored in the string buffer). It's probably not
> much work but might be a bit tricky. Do you think it's worth doing?

Not sure. The xmon code is in general incredibly crufty, so any clean ups are
always welcome. Certainly if we could come up with a general paging system that
would be great.

> Since we're looking at memory usage, it looks like "tmpstr[128]" could be
> removed without much work, saving 128 bytes and removing an unnecessary global
> variable. If it actually turns out to be easy to do I'll post a separate patch.

Cool. Obviously in absolute terms 128 bytes is a non-issue, it was only meant
as a comparison between the two approaches.

cheers
