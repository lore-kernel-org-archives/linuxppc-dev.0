Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 53701DDE3C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 08:41:36 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l91MfY6w029798
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Oct 2007 18:41:34 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l91MfXkE477752
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Oct 2007 16:41:33 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l91MfXBL029640
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Oct 2007 16:41:33 -0600
Date: Mon, 1 Oct 2007 17:41:32 -0500
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 2/2]: PCI Error Recovery: Symbios SCSI First Failure
Message-ID: <20071001224132.GH4338@austin.ibm.com>
References: <20070420204114.GL31947@austin.ibm.com>
	<20070420204720.GM31947@austin.ibm.com>
	<20070926150216.GH3899@parisc-linux.org>
	<20070927220022.GC18686@austin.ibm.com>
	<20070927221031.GY3899@parisc-linux.org>
	<20070927233437.GF18686@austin.ibm.com>
	<20071001201247.GN12049@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071001201247.GN12049@parisc-linux.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 01, 2007 at 02:12:47PM -0600, Matthew Wilcox wrote:
> 
> I think the fundamental problem is that completions aren't really
> supposed to be used like this.  Here's one attempt at using completions
> perhaps a little more the way they're supposed to be used, 

Yes, that looks very good to me.  I see it solves a bug that
I hadn't been quite aware of. I don't understand why 
struct host_data is preferable to struct sym_shcb (is it because 
this is the structure that is "naturally protectected" by the 
spinlock?)

My gut instinct is to say "ack", although prudence dictates that 
I should test first. Which might take a few days...

> although now
> I've written it, I wonder if we shouldn't just use a waitqueue instead.

I thought that earlier versions of the driver used waitqueues (I vaguely
remember "eh_wait" in the code), which were later converted to 
completions (I also vaguely recall thinking that the new code was
more elegant/simpler). I converted my patch to use the completions 
likewise, and, as you've clearly shown, did a rather sloppy job in 
the conversion.

I'm tempted to go with this patch; but if you prod, I could attempt
a wait-queue based patch.

--linas
