Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 5F12BB70D0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 01:44:31 +1000 (EST)
Received: from mail48-tx2 (localhost.localdomain [127.0.0.1])	by
	mail48-tx2-R.bigfish.com (Postfix) with ESMTP id B4B9E11183B4	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 20 Sep 2010 15:44:19 +0000 (UTC)
Received: from TX2EHSMHS047.bigfish.com (unknown [10.9.14.247])	by
	mail48-tx2.bigfish.com (Postfix) with ESMTP id 6DA55568092	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 20 Sep 2010 15:44:09 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8KFhtbJ001671	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Sep 2010 08:43:55 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8KFudaf026363	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Sep 2010 10:56:40 -0500 (CDT)
Date: Mon, 20 Sep 2010 10:43:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Subject: Re: Generating elf kernel ?
Message-ID: <20100920104353.5dbd9201@udp111988uds.am.freescale.net>
In-Reply-To: <4C9569FF.6090807@windriver.com>
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>
	<20100914125713.GB5768@radix50.net>
	<201009151007.50706.dargaud@lpsc.in2p3.fr>
	<4C90835E.4050803@windriver.com>
	<20100915114912.06bc7ed1@schlenkerla.am.freescale.net>
	<4C9182EC.5030900@windriver.com>
	<20100916120944.11c45c31@schlenkerla.am.freescale.net>
	<4C92CB51.5010008@windriver.com>
	<20100917124448.255b08cc@schlenkerla.am.freescale.net>
	<4C9569FF.6090807@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 19 Sep 2010 09:40:15 +0800
"tiejun.chen" <tiejun.chen@windriver.com> wrote:

> Scott Wood wrote:
> > On Fri, 17 Sep 2010 09:58:41 +0800
> > "tiejun.chen" <tiejun.chen@windriver.com> wrote:
> > 
> >> Scott Wood wrote:
> >>> The guest OS *is* the same as native Linux, as far as TLB handling is
> >>> concerned.
> >> Looks you means the TLB exception handler should be same between the native and
> >> the guest OS. Right?
> > 
> > Yes.
> 
> I don't think so. The HY should assist the guest OS on MMU since I already point
> the guest OS have no authority to create a real TLB directly as I previously said.

Of course the hypervisor assists, when a trap is taken.  That doesn't
mean the code is any different in the guest.

> > Yes, of course.  But that's not the point.  I was just using it as a
> > convenient example because that's what I've recently done ELF loading
> > with...  There's no reason U-Boot couldn't do the same if its ELF
> > loader were updated to support device trees.  Currently U-Boot loads
> > bootwrapperless uImages to physical address zero.
> 
> I never doubt the U-boot can do this for uImage. But I think we're always
> talking about vmlinux, a bare Image.

uImage is pretty much a bare image.  It just has a header with a
checksum and some info like OS/architecture, kernel version, build
date, etc.

There would be *no* problem doing this with vmlinux in U-Boot if
someone put in the code to pass a device tree.

-Scott
