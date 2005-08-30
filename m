Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id E8CAE681A1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 01:09:35 +1000 (EST)
Date: Tue, 30 Aug 2005 08:09:31 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Grant Likely <glikely@gmail.com>
Message-ID: <20050830080931.A5925@cox.net>
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<35fb2e5905082808152031ef53@mail.gmail.com>
	<528646bc05082817268abfb1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc05082817268abfb1d@mail.gmail.com>;
	from glikely@gmail.com on Sun, Aug 28, 2005 at 06:26:06PM -0600
Cc: jonathan@jonmasters.org, linuxppc-embedded@ozlabs.org
Subject: Re: Address mapping PPC 405
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Aug 28, 2005 at 06:26:06PM -0600, Grant Likely wrote:
> On 8/28/05, Jon Masters <jonmasters@gmail.com> wrote:
> > On 8/26/05, P. Sadik <psadik@gmail.com> wrote:
> > 
> > Lovely. We don't do it that way on 405 but we could - since the MMU is
> > heavy soft assisted we could do that - we actually have everything run
> > through the MMU once we've done initial MMU setup, but we do have the
> > ability to mark ranges of addresses for IO and have the concept of TLB
> > pinning to lock ranges of kernel addresses in large translated (BAT
> > like for bigger PPC users) regions using just a few TLB slots. There
> > is also a ZPR (zone protection register), but that's mostly used to
> > fake the usual USER/KERNEL page distinction.
> I believe TLB pinning was removed in 2.6 in favor of large TLB entries
> for kernel space.  Matt Porter pointed this out to me about a week
> ago.  This will not matter of course if you're not using 2.6.
> 
> Matt, is there any documentation covering the new design in the kernel tree?

The docs are in the original threads from 3+ years ago. You'll need
to read them all to have proper context about the tradeoffs between
permanently pinning a couple TLBs versus faulting large TLB
replacement.

http://ozlabs.org/pipermail/linuxppc-embedded/2002-May/007257.html
http://ozlabs.org/pipermail/linuxppc-embedded/2002-May/007317.html
http://ozlabs.org/pipermail/linuxppc-embedded/2002-June/007370.html
http://ozlabs.org/pipermail/linuxppc-embedded/2002-June/007404.html

-Matt
