Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 411E4DDF01
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 03:29:30 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l8KGLPgA014979
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 12:21:25 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8KHTMmP491592
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 11:29:22 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8KHTL7X017842
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 11:29:22 -0600
Date: Thu, 20 Sep 2007 12:29:19 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>, benh@kernel.crashing.org
Subject: Re: Sequoia kernel crash workaround.
Message-ID: <20070920122919.32dd8061@weaponx.rchland.ibm.com>
In-Reply-To: <20070920172506.GA16354@lixom.net>
References: <46F16CC9.3010003@ru.mvista.com> <200709192119.48259.sr@denx.de>
	<20070919193024.GA28163@lixom.net>
	<20070919150818.3fecc1bc@weaponx.rchland.ibm.com>
	<46F2A640.1000802@ru.mvista.com> <20070920172506.GA16354@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 20 Sep 2007 12:25:06 -0500
Olof Johansson <olof@lixom.net> wrote:

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

Yeah.  Looks like BenH did this in commit:

42c4aaadb737e0e672b3fb86b2c41ff59f0fb8bc

Ben, any reason you ifdef'd it for ppc64?

josh
