Return-Path: <white@from-b.org>
Received: from aphrodite.net-build.de (aphrodite.net-build.de [212.88.135.60])
	by ozlabs.org (Postfix) with ESMTP id 1203567A3B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Apr 2006 06:25:15 +1000 (EST)
Received: from White64 (p54B4BA88.dip0.t-ipconnect.de [84.180.186.136])
	(authenticated)
	by aphrodite.net-build.de (8.11.6/8.11.2) with ESMTP id k3KKQUS23784
	for <linuxppc-embedded@ozlabs.org>; Thu, 20 Apr 2006 22:26:40 +0200
Date: Thu, 20 Apr 2006 22:18:01 +0200
From: White <white@from-b.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Upgrading cramfs root file system
Message-ID: <20060420221801.55331e15@White64>
In-Reply-To: <200604202154.45963.antonio.dibacco@aruba.it>
References: <200604062238.17972.antonio.dibacco@aruba.it>
	<4445E9E1.50204@dgt.com.pl>
	<200604202154.45963.antonio.dibacco@aruba.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



make it easy: if you start an application which do the flash and after
this a reset.. nothing should happen. I do it that way.
the application resist completly in RAM .. and all important libs are
in RAm or in Filesystem Cache.
It's only important that you pretend any Application from accessing
Datafiles or start of new application ...

Alternativly, you can put it in a reserved RAM Area ( mark it not
usable by Linux) and put a Flash Code in your Bootloader (U-boot?)
after a reset....

But overwrite a cramfs works for me on >100 times without problems.

Am Thu, 20 Apr 2006 21:54:45 +0200 schrieb Antonio Di Bacco
<antonio.dibacco@aruba.it> :

> Yes you are right, it is not a good idea to overwrite working cramfs 
> filesystem. But what happens if I download the new cramfs plus kernel in RAM, 
> do a checksum and then, completely in kernel mode, disabling all the 
> interrupts, I write to flash? No process could complain that I am overwriting 
> because no one is executing.
> 
> Bye,
> Antonio.
> 
> On Wednesday 19 April 2006 09:42, Wojciech Kromer wrote:
> > Dnia 2006-04-06 22:38, Użytkownik Antonio Di Bacco napisał:
> > > Hi,
> > >
> > > how could I upgrade my cramfs rootfs? I have a CGI in the rootfs that
> > > receives the new rootfs from a web interface and then tries to write it
> > > in the flash. While overwriting the old cramfs, the CGI will continue to
> > > work? something weird could happen?
> >
> > Generally it's not a good idea to override working filesystem ( I've
> > tried to do it once).
> >
> > You can have two separate copies of filesystem, one to work with, and
> > another to overwrite, it requires more flash.
> > Another way is working in initrd, it requires more RAM.
> > You can also use jffs2 or jffs3 (experimental) to have read-write
> > filesystem, and change applications only, not whole filesystem (be
> > carefull with changing busybox or libraries!)
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
