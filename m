Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E3ED3B7211
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2011 12:25:55 +1100 (EST)
Message-ID: <1321838742.13860.8.camel@pasglop>
Subject: Re: 3.2.0-rc1 panic on PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Kujau <lists@nerdbynature.de>
Date: Mon, 21 Nov 2011 12:25:42 +1100
In-Reply-To: <alpine.DEB.2.01.1111201701000.8000@trent.utfs.org>
References: <alpine.DEB.2.01.1111150035560.8000@trent.utfs.org>
 <alpine.DEB.2.01.1111201529070.8000@trent.utfs.org>
 <1321837101.13860.6.camel@pasglop>
 <alpine.DEB.2.01.1111201701000.8000@trent.utfs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-11-20 at 17:17 -0800, Christian Kujau wrote:
> On Mon, 21 Nov 2011 at 11:58, Benjamin Herrenschmidt wrote:
> > I've seen something similar with 3.2-rc2 at cfcfc9ec, unfortunately I
> > couldn't capture the oops log at the time.
> 
> It just happened again today, after heavy CPU & IO load (rsyncing from/to 
> external disks on dm-crypt). This time the oops was printed on the screen 
> but nothing on netconsole:
> 
> http://nerdbynature.de/bits/3.2.0-rc1/oops/oops3m.JPG
> 
> It looks like the oops I reported earlier (oops2m.JPG) so I doubt it's a 
> random corruption due to hardware issues...?

Yeah it's starting to look like a pattern. Your latest oops looks a lot
like the one I had (though it was with tg3 on the g5), ie, vfs_read ->
driver -> allocator -> crash.

> Any debug or boot options to set in my next kernel build?

Well, you can turn everything on see whether that makes any difference
or finds something a bit more precisely

Cheers,
Ben.

> Thanks,
> Christian.
> 
> > Looks like there's some kind of memory corruption happening. So far I
> > haven't been able to get a good target at what could be causing it.
> 
