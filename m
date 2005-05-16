Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8E6F6679EF
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 02:28:47 +1000 (EST)
Date: Mon, 16 May 2005 09:22:04 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Wolfgang Denk <wd@denx.de>
Message-ID: <20050516162204.GB21985@gate.ebshome.net>
References: <1116255938.5095.133.camel@gaston>
	<20050516161108.5BD3CC1512@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050516161108.5BD3CC1512@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 16, 2005 at 06:11:03PM +0200, Wolfgang Denk wrote:
> In message <1116255938.5095.133.camel@gaston> you wrote:
> >
> > I suppose it would add about ... 1 instruction :) Which is probably
> > barely measurable compared to the cost of the cache misses of getting to
> > the page table entires...
> 
> That would be just another "just 1 instruction"  modifircation  to  a
> time  critical path in a kernel which already now is so slow compared
> against an old 2.4 kernel that I'm really surprised to  nobody  seems
> to care.

Well, this just one instruction is needed to make code correct anyway, 
because currently head_8xx.S, head_4xx.S, head_44x.s just hardcode 
0x80000000 TASK_SIZE assumption, and you cannot change TASK_SIZE on 
all this hardware.

-- 
Eugene
