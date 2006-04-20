Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa3.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id AA4A267A05
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Apr 2006 05:51:56 +1000 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: wojciech.kromer@dgt.com.pl
Subject: Re: Upgrading cramfs root file system
Date: Thu, 20 Apr 2006 21:54:45 +0200
References: <200604062238.17972.antonio.dibacco@aruba.it>
	<4445E9E1.50204@dgt.com.pl>
In-Reply-To: <4445E9E1.50204@dgt.com.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200604202154.45963.antonio.dibacco@aruba.it>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Yes you are right, it is not a good idea to overwrite working cramfs=20
filesystem. But what happens if I download the new cramfs plus kernel in RA=
M,=20
do a checksum and then, completely in kernel mode, disabling all the=20
interrupts, I write to flash? No process could complain that I am overwriti=
ng=20
because no one is executing.

Bye,
Antonio.

On Wednesday 19 April 2006 09:42, Wojciech Kromer wrote:
> Dnia 2006-04-06 22:38, U=C5=BCytkownik Antonio Di Bacco napisa=C5=82:
> > Hi,
> >
> > how could I upgrade my cramfs rootfs? I have a CGI in the rootfs that
> > receives the new rootfs from a web interface and then tries to write it
> > in the flash. While overwriting the old cramfs, the CGI will continue to
> > work? something weird could happen?
>
> Generally it's not a good idea to override working filesystem ( I've
> tried to do it once).
>
> You can have two separate copies of filesystem, one to work with, and
> another to overwrite, it requires more flash.
> Another way is working in initrd, it requires more RAM.
> You can also use jffs2 or jffs3 (experimental) to have read-write
> filesystem, and change applications only, not whole filesystem (be
> carefull with changing busybox or libraries!)
