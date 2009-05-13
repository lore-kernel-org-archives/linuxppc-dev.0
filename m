Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7DD10DE02D
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 08:44:25 +1000 (EST)
Date: Wed, 13 May 2009 15:44:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: drivers/video/logo/logo_linux_mono.c build error
Message-Id: <20090513154415.fd10762c.akpm@linux-foundation.org>
In-Reply-To: <alpine.LRH.2.00.0904280922410.31001@vixen.sonytel.be>
References: <20090427145031.99d4e0ac.akpm@linux-foundation.org>
	<20090428135202.9c9bbadb.sfr@canb.auug.org.au>
	<alpine.LRH.2.00.0904280922410.31001@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Apr 2009 09:24:53 +0200 (CEST)
Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> On Tue, 28 Apr 2009, Stephen Rothwell wrote:
> > On Mon, 27 Apr 2009 14:50:31 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > > powerpc allmodconfig, current mainline:
> > > 
> > > drivers/video/logo/logo_linux_mono.c:11: error: logo_linux_mono_data causes a section type conflict
> > > 
> > > switching it from __initconst to __initdata "fixes" it.
> > 
> > Interesting.  The program that generates the .c file above produces
> > __initdata for me ...
> 
> I assume Andrew once built in that tree using the recent logo patches that
>   1. Makes the logos const and switch them from __initdata to __initconst,
>   2. Fix the missing dependency of the generated files on the generator program.
> Hence if you revert the logo patches, you have to manually remove the generated
> files.
> 
> Is my assumption correct?

Nope - mrproper removes every .c file from drivers/video/logo/ apart
from logo.c



The failure is caused by your fbdev-move-logo-externs-to-header-file.patch.

Without that patch, drivers/video/logo/logo_linux_mono.c is generated as

	static unsigned char logo_linux_mono_data[] __initdata = {
	
and with that patch, drivers/video/logo/logo_linux_mono.c is generated as

	static const unsigned char logo_linux_mono_data[] __initconst = {

and it's the switch from __initdata to __initconst which causes this
section conflict in my setup.
