Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id EA76ADDDE6
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:44:22 +1000 (EST)
Date: Fri, 28 Sep 2007 15:47:49 -0500
From: Olof Johansson <olof@lixom.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 06/18] [POWERPC] Fix UARTLITE reg io for little-endian
	architectures (ie. microblaze)
Message-ID: <20070928204749.GD23749@lixom.net>
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181704.18608.40317.stgit@trillian.cg.shawcable.net>
	<20070928203104.GC23749@lixom.net>
	<fa686aa40709281342h4f8ff3fdv265e8098d2da6f52@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40709281342h4f8ff3fdv265e8098d2da6f52@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 28, 2007 at 02:42:32PM -0600, Grant Likely wrote:
> On 9/28/07, Olof Johansson <olof@lixom.net> wrote:
>
> > Hmm, I see the start changed, and you're now reading/writing a full
> > 32-bit word instead of individual bytes. Still, looks a little fishy to
> > me. Wouldn't it be more appropriate to change the ULITE_RX offset to be
> > 3 higher and still read/write bytes?
> >
> > Or are the registers defined as 32-bit ones? (I don't remember, it was
> > so long since I touched uartlite myself. :-)
> 
> All the registers are defined as 32 bit ones.  I think it makes more
> sense to access the registers as they are documented, and it
> eliminates the 'magic' +3 needed to make it work now.

Ok, thaks for the clarification. Feel free to add it as motivation in
the patch description. :)

> > (Same for the other functions below, but the general principle applies.)
> >
> > Also, I'm not sure you need to cast port->membase to void*, do you? The
> > math will still be right since it's declared as char *.
> 
> membase is now defined as u32*, so the cast is needed.

Hm, I must have looked at a stale tree.


Thanks,

-Olof
