Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by ozlabs.org (Postfix) with ESMTP id 60095B6EEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 02:49:34 +1000 (EST)
Received: from mail21-tx2 (localhost.localdomain [127.0.0.1])	by
	mail21-tx2-R.bigfish.com (Postfix) with ESMTP id 4B607A40596	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 16:49:17 +0000 (UTC)
Received: from TX2EHSMHS041.bigfish.com (unknown [10.9.14.243])	by
	mail21-tx2.bigfish.com (Postfix) with ESMTP id 08172F00046	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 16:49:16 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8FGnEi6010210	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 09:49:14 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8FH4QIX023977	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 12:04:26 -0500 (CDT)
Date: Wed, 15 Sep 2010 11:49:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Subject: Re: Generating elf kernel ?
Message-ID: <20100915114912.06bc7ed1@schlenkerla.am.freescale.net>
In-Reply-To: <4C90835E.4050803@windriver.com>
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>
	<20100914125713.GB5768@radix50.net>
	<201009151007.50706.dargaud@lpsc.in2p3.fr>
	<4C90835E.4050803@windriver.com>
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

On Wed, 15 Sep 2010 16:27:10 +0800
"tiejun.chen" <tiejun.chen@windriver.com> wrote:

> It's impossible to boot PPC vmlinux format directly if you only change the
> original entry point address, 0xc0000000.

Why?  That's pretty much what the bootwrapper does.  Our hypervisor has
directly booted vmlinux this way.

Note that in recent kernels physaddr is even set to zero, allowing the
ELF loader to just use that instead of magically knowing the kernel
wants to go at address zero.

> For kernel the following is as default:
> v:0xc0000000 --> p:0x0

That mapping is set up by code at the entry point of vmlinux, not by
the bootwrapper.

-Scott
