Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 04100DDE2C
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 01:09:30 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2DE9Rj9010687
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 10:09:27 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2DE9Qwu016548
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 08:09:26 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2DE9QKM018463
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 08:09:26 -0600
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <528646bc0703130700o4773f0c6g460cc2d53ea90da9@mail.gmail.com>
References: <200703122254.27087.sr@denx.de> <20070313094229.GA13567@lst.de>
	<528646bc0703130700o4773f0c6g460cc2d53ea90da9@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 13 Mar 2007 09:09:25 -0500
Message-Id: <1173794965.3953.7.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-03-13 at 08:00 -0600, Grant Likely wrote:
> On 3/13/07, Christoph Hellwig <hch@lst.de> wrote:
> > On Mon, Mar 12, 2007 at 10:54:26PM +0100, Stefan Roese wrote:
> > >  arch/ppc/Kconfig               |   10 ++++++++
> > >  arch/ppc/kernel/head_44x.S     |   23 ++++++++++---------
> > >  arch/ppc/kernel/misc.S         |   13 ++++++-----
> > >  arch/ppc/kernel/vmlinux.lds.S  |   15 +++++++-----
> > >  include/asm-ppc/page.h         |    6 ++++-
> > >  include/asm-ppc/ppc_page_asm.h |   49 ++++++++++++++++++++++++++++++++++++++++
> >
> > I though we'd given up on arch/ppc by now?
> > Can you try to redo this over the arch/powerpc/ 44x port?
> 
> Not dead yet.  arch/powerpc support is not complete for 4xx cores and
> older bootloaders cannot boot arch/powerpc kernels yet.

Um, yes they can.  You just need to include the dtb in the zImage
wrapper.  I've booted Ebony with Openbios using David's patches and
Bamboo with PIBS using my patches (which are based off David's patches).

What I think you mean is that there is no translation from a bd_t (using
older u-boot for example) to a dt in the wrapper yet.  But that is what
Scott's cuimage patches are for.

josh
