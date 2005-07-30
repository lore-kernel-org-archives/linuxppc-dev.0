Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.205])
	by ozlabs.org (Postfix) with ESMTP id 7474367E0F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 15:46:28 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i24so732159wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jul 2005 22:46:27 -0700 (PDT)
Message-ID: <9b7ca657050729224620d67bfc@mail.gmail.com>
Date: Sat, 30 Jul 2005 14:46:27 +0900
From: Daniel Ann <ktdann@gmail.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <9b7ca6570507291836ac62600@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9b7ca65705072918062249e41f@mail.gmail.com>
	<1122686376.4755.2.camel@yoda.jdub.homelinux.org>
	<9b7ca6570507291836ac62600@mail.gmail.com>
Subject: Re: Serial console
Reply-To: Daniel Ann <ktdann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've got a feeling that this has alot to do with IRQ.
Would I be correct to assume printk doesnt require interrupt to work
but printf does ?

After doing some testing, I've found my network interface ping-able
when I got printf working in 2.4.31. But if I alter the openpic source
to not initialize the interrupt, it also stop displaying at the same
point and network interface isnt pingable.

I guess my next problem would be then, why isnt my openpic working. :(
I've done exactly the same as what I did with 2.4.31 and that works.
Hmmm. Something must have changed in 2.6.12.3.

I dont think this is has anything to do with serial console, so I'm
gonna end the thread here.

Thanks.

On 7/30/05, Daniel Ann <ktdann@gmail.com> wrote:
> I too have /dev/null
> 0 crw-rw-rw-  1 root root 1, 3 Aug 31  2001 null
>=20
> However, Im not using initrd. null, and console devices are in my RAMDISK=
 tho.
>=20
> On 7/30/05, Josh Boyer <jwboyer@jdub.homelinux.org> wrote:
> > On Sat, 2005-07-30 at 10:06 +0900, Daniel Ann wrote:
> > > Hi folks,
> > >
> > > Just wondering if anyone could lend a hand with this problem I have
> > > with serial console. I'm trying to boot up my board (very similar to
> > > sandpoint using MPC8245) with kernel 2.6.12.3, and most of it is
> > > working but console will display up to,
> > > [snip]
> > > RAMDISK: Compressed image found at block 0
> > > VFS: Mounted root (ext2 filesystem) readonly.
> > > Freeing unused kernel memory: 112k init
> > >
> > > I've done series of printk in sys_execve() to see if /sbin/init is
> > > working, and found out it went thru the whole rcS file okay. Mind you=
,
> > > printk is successfully displaying the output on the console while I'm
> > > still not getting anything from the user processes.
> > >
> > > Having all the kernel boot up log on console means that I've done som=
e
> > > part right. But why am I not getting anything from the user processes
> > > on the console screen ?
> > >
> > > Is there anything I need to do on the kernel config ?
> >
> > Do you have a /dev/console device node in your initrd?  If not, that is
> > one of the reasons you could be seeing that problem.  Make
> > sure /dev/null is there too.
> >
> > josh
> >
> >
>=20
>=20
> --
> Daniel
>=20


--=20
Daniel
