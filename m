Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Evolves!] Why does one "stw" fail with address translation
	disabled in PPC405EP?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhou Rui <vancasperz@yahoo.com.cn>
In-Reply-To: <1220253721.6764.9.camel@zr.gii.upv.es>
References: <1219429635.8882.22.camel@zr.gii.upv.es>
	<20080822184213.GA24526@yoda.jdub.homelinux.org>
	<1219479992.7565.17.camel@localhost>
	<20080824185547.94A0724899@gemini.denx.de>
	<1219691805.6735.63.camel@zr.gii.upv.es>
	<1220183410.6750.56.camel@zr.gii.upv.es>
	<1220247721.13010.33.camel@pasglop>
	<1220253721.6764.9.camel@zr.gii.upv.es>
Content-Type: text/plain; charset=utf-8
Date: Mon, 01 Sep 2008 17:17:43 +1000
Message-Id: <1220253463.13010.40.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-09-01 at 09:22 +0200, Zhou Rui wrote:
> 在 2008-09-01一的 15:42 +1000，Benjamin Herrenschmidt写道：
> > On Sun, 2008-08-31 at 13:50 +0200, Zhou Rui wrote:
> > > Hi, all:
> > >     My problem seems basically solved.
> > >     We we used to call vmalloc() in the memory management part of our
> > > source, but it seems to be the key unreliable point resulting in the
> > > problem. vmalloc() always assigns some virtual addresses whose
> > > corresponding physical addresses are out of memory size (there is only
> > > 32MB DRAM in our 405 board). Once instructions try to access these
> > > illegal physical address, machine check happens
> > 
> > That should -never- happen.
> > 
> > Have you verified, as I asked you a while ago, that you are actually
> > passing the right amount of memory to your kernel from the device-tree
> > or the bootloader ?
> > 
> > Ben.
> 
> I added "mem=32M" to linux command line of the bootloader, and got the
> same machine check.

Paul spotted today that you are actually trying to use __pa() on
addresses returned from vmalloc, that will not work. Those are virtual
addresses in a non-linear mapping, _pa() only works on the linear
mapping.

Ben.
