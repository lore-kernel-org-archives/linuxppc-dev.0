Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa4.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id E0C1B679FF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Apr 2006 07:00:31 +1000 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Upgrading cramfs root file system while running (DENX wrote that
	is not possible)
Date: Thu, 20 Apr 2006 23:03:21 +0200
References: <200604062238.17972.antonio.dibacco@aruba.it>
	<200604202154.45963.antonio.dibacco@aruba.it>
	<20060420221801.55331e15@White64>
In-Reply-To: <20060420221801.55331e15@White64>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200604202303.21680.antonio.dibacco@aruba.it>
Cc: White <white@from-b.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Yes, I also thought this too. Anything important should stay already in RAM=
=20
but there is a chance that something bad could happen. Probably the best=20
thing is what you suggested as second option but I have not so much ram. My=
=20
CGI writes the downloaded new software in RAM and then I should directly ju=
mp=20
to u-boot without leaving Linux the chance to mix things up and then u-boot=
 =20
should copy the RAM to the flash. It seems a strange procedure but what els=
e=20
could be done with 4MB flash and 16 MB ram?=20

Bye,
Antonio.

On Thursday 20 April 2006 22:18, White wrote:
> make it easy: if you start an application which do the flash and after
> this a reset.. nothing should happen. I do it that way.
> the application resist completly in RAM .. and all important libs are
> in RAm or in Filesystem Cache.
> It's only important that you pretend any Application from accessing
> Datafiles or start of new application ...
>
> Alternativly, you can put it in a reserved RAM Area ( mark it not
> usable by Linux) and put a Flash Code in your Bootloader (U-boot?)
> after a reset....
>
> But overwrite a cramfs works for me on >100 times without problems.
>
> Am Thu, 20 Apr 2006 21:54:45 +0200 schrieb Antonio Di Bacco
>
> <antonio.dibacco@aruba.it> :
> > Yes you are right, it is not a good idea to overwrite working cramfs
> > filesystem. But what happens if I download the new cramfs plus kernel in
> > RAM, do a checksum and then, completely in kernel mode, disabling all t=
he
> > interrupts, I write to flash? No process could complain that I am
> > overwriting because no one is executing.
> >
> > Bye,
> > Antonio.
> >
> > On Wednesday 19 April 2006 09:42, Wojciech Kromer wrote:
> > > Dnia 2006-04-06 22:38, U=C5=BCytkownik Antonio Di Bacco napisa=C5=82:
> > > > Hi,
> > > >
> > > > how could I upgrade my cramfs rootfs? I have a CGI in the rootfs th=
at
> > > > receives the new rootfs from a web interface and then tries to write
> > > > it in the flash. While overwriting the old cramfs, the CGI will
> > > > continue to work? something weird could happen?
> > >
> > > Generally it's not a good idea to override working filesystem ( I've
> > > tried to do it once).
> > >
> > > You can have two separate copies of filesystem, one to work with, and
> > > another to overwrite, it requires more flash.
> > > Another way is working in initrd, it requires more RAM.
> > > You can also use jffs2 or jffs3 (experimental) to have read-write
> > > filesystem, and change applications only, not whole filesystem (be
> > > carefull with changing busybox or libraries!)
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
