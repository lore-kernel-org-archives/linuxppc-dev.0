Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A2686DDEC9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 04:01:03 +1000 (EST)
Date: Thu, 20 Sep 2007 13:03:17 -0500
From: Olof Johansson <olof@lixom.net>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: Sequoia kernel crash workaround.
Message-ID: <20070920180317.GA16573@lixom.net>
References: <46F16CC9.3010003@ru.mvista.com> <200709192119.48259.sr@denx.de>
	<20070919193024.GA28163@lixom.net>
	<20070919150818.3fecc1bc@weaponx.rchland.ibm.com>
	<46F2A640.1000802@ru.mvista.com> <20070920172506.GA16354@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070920172506.GA16354@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Josh Boyer <jwboyer@gmail.com>,
	Stefan Roese <sr@denx.de>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 20, 2007 at 12:25:06PM -0500, Olof Johansson wrote:
> On Thu, Sep 20, 2007 at 08:56:32PM +0400, Valentine Barshak wrote:
> >
> > I was thinking about it. Looks like it's the best place, but the code that 
> > actually calls setup_cpu is under ifdef CONFIG_PPC64, while lots of 
> > cpu_setup functions are defined for ppc32 processors.
> > Is it OK to remove this ifdef, or should I do CONFIG_PPC64 || CONFIG_44x?
> 
> Sounds like something that went wrong at the merge of ppc and ppc64.
> 
> Take out the ifdef, even if there's fallout we should deal with it
> instead of adding more complex ifdefs.

See comment from Milton, my bad. It's just called from head_32.S right now.
It'll need to be added to the 4xx head as well, or an ifdef added. One or
the other, I'll leave it to Josh to pick.


-Olof
