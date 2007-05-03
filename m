Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87E3BDDF9B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 22:34:53 +1000 (EST)
Subject: Re: [PATCH] powerpc: dart iommu suspend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1178195662.13233.118.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178195106.13233.108.camel@johannes.berg>
	<1178195312.13233.111.camel@johannes.berg>
	<1178195447.6353.40.camel@localhost.localdomain>
	<1178195662.13233.118.camel@johannes.berg>
Content-Type: text/plain
Date: Thu, 03 May 2007 22:34:45 +1000
Message-Id: <1178195686.6353.43.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-03 at 14:34 +0200, Johannes Berg wrote:
> On Thu, 2007-05-03 at 22:30 +1000, Benjamin Herrenschmidt wrote:
> 
> > We could just make the DART pages CI in the linear mapping rather than
> > not mapping it. That would make it "just work" with the normal code
> > path.
> 
> I didn't think that was even possible because it's mapped in larger
> blocks than that. If it is then all this hackery can go, I'm not
> attached to it...

Well.. the linear mapping is mapped with 16M pages. The DART only uses a
couple of MB but we blast an entire 16M page for it because of that ...

We could probably just map that 16MB page CI rather than not mapping it
and later on ioremapping the DART.

Ben.
