Return-Path: <SRS0+fe5d3eea650504d0da4d+527+infradead.org+arjan@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7B2C67A5D
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Feb 2005 02:50:33 +1100 (EST)
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <41FFA21C.8060203@nortelnetworks.com>
References: <41FECA18.50609@nortelnetworks.com>
	<1107243398.4208.47.camel@laptopd505.fenrus.org>
	<41FFA21C.8060203@nortelnetworks.com>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 16:50:16 +0100
Message-Id: <1107273017.4208.132.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on symbol exports
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-02-01 at 09:37 -0600, Chris Friesen wrote:
> Arjan van de Ven wrote:
> > On Mon, 2005-01-31 at 18:15 -0600, Chris Friesen wrote:
> 
> >>Is there any particular reason why modules should not be allowed to 
> >>flush the tlb, or is this an oversight?
> > 
> > can you point at the url to your module source? I suspect modules doing
> > tlb flushes is the wrong thing, but without seeing the source it's hard
> > to tell.
> 
> I've included the relevent code at the bottom.  The module will be 
> released under the GPL.
> 
> I've got a module that I'm porting forward from 2.4.  The basic idea is 
> that we want to be able to track pages dirtied by an application.  The 
> system has no swap, so we use the dirty bit to get this information.  On 
> demand we walk the page tables belonging to the process, store the 
> addresses of any dirty ones, flush the tlb, and mark them clean.

afaik one doesn't need to do a tlb flush in code that clears the dirty
bit, as long as you use the proper vm functions to do so. 
(if those need a tlb flush, those are supposed to do that for you
afaik).

Also note that your code isn't dealing with 4 level pagetables.... And
pagetable walking in drivers is basically almost always a mistake and a
sign that something is wrong.
