Return-Path: <glikely@secretlab.ca>
Received: from mail-yi0-f42.google.com (mail-yi0-f42.google.com
	[209.85.218.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4DAA410083A
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2011 06:16:28 +1000 (EST)
Received: by yib12 with SMTP id 12so918312yib.15
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Sep 2011 13:16:25 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Thu, 29 Sep 2011 12:27:37 -0500
From: Grant Likely <grant.likely@secretlab.ca>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: Handling multiple GPIO controllers in 8xxx GPIO driver
Message-ID: <20110929172737.GF6800@ponder.secretlab.ca>
References: <4E81D6C0.3010201@embedded-sol.com>
	<20110927182912.GA3994@ponder.secretlab.ca>
	<CAOZdJXW7uSSMO2KP7gW9UVQXNvBiYJoDRWsJWtPGXgWY-PXvCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOZdJXW7uSSMO2KP7gW9UVQXNvBiYJoDRWsJWtPGXgWY-PXvCQ@mail.gmail.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 28, 2011 at 08:52:30PM +0000, Tabi Timur-B04825 wrote:
> On Tue, Sep 27, 2011 at 1:29 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> 
> > The solution is to make the gpio driver register as a regular
> > interrupt handler, and not as a chained handler.
> 
> I was wondering about that.
> 
> What exactly is a chained handler?  How is it different from a regular handler?

A chained handler has an expedited path through the interrupt code for
handling it (basically, it skips handling it at the parent controller
and passes through to the child, but it cannot handle multiple chained
children on a single irq input.

g.
