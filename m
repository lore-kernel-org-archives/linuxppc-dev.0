Return-Path: <davidkwho@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.196])
	by ozlabs.org (Postfix) with ESMTP id 4ED5A67C39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jul 2005 22:58:13 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i6so1213050wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jul 2005 05:58:12 -0700 (PDT)
Message-ID: <4dd15d1805071905573ebcba61@mail.gmail.com>
Date: Tue, 19 Jul 2005 08:57:20 -0400
From: David Ho <davidkwho@gmail.com>
To: David Jander <david.jander@protonic.nl>
In-Reply-To: <200507191021.52063.david.jander@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200507191021.52063.david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How reliable is jffs2 really (denx cvs devel kernel)?
Reply-To: David Ho <davidkwho@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I ran into similar problems, I had talked to David Woodhouse about a
number of issues with JFFS2.  But he has no plans to support 2.4
kernels.

There are a bunch of people that back ports the latest JFFS2 code from
2.6 and snapshots are found here
ftp://ftp.uk.linux.org/pub/people/dwmw2/mtd/cvs/.

I updated the JFFS2 portion of the Denx devel kernel with the latest
from CVS and it solved the initial mount time problem.  But it was a
while a ago when I did this.  Both the devel kernel and the CVS head
has changed quite a bit since then.

But some people on the mailing list seem to indicate timing resolution
in the 2.4 leading to race condition, or some other deficiency from
what I recall.

The people in the mailing list were not interested in fixing these so
called kernel bugs.  And since JFFS2 code is too complex for my spare
time and it does not cause the kernel to hang, I have yet to figure
out a fix for it.

I like to know other's experience with JFFS2 on 2.4 as well.

David


On 7/19/05, David Jander <david.jander@protonic.nl> wrote:
>=20
> Hi,
>=20
> I have seen some strange problems with jffs2. I have been victim of the B=
UG()
> in fs/jffs2/gc.c, line 139. I have been battling with kgdb to see what
> happens there. Here are my findings until now (I am still working on this=
):
>=20
> c->checked_ino starts counting from 0
> c->highest_ino is 92 (????)
>=20
> Isn't this a little low?
>=20
> Flash partition size is 15Mbyte, it probably has been mistreated by writi=
ng
> large files (logfiles) line by line, wasting a lot of space until it gets
> almost full.
> When debugging the for(;;) loop, used size starts from a few kb counting =
up,
> dirty size is around 5 Mb and unchecked size is about 9.9Mb, so when it g=
ets
> past inode 92 it most probably has still a lot of unchecked space.=3D=3D=
=3D> BUG().
>=20
> Googleing for this bug, I have found discouraging e-mails (luckily most o=
f
> them from 2003 or older) saying that this is common and nobody (back then=
)
> seemed to know where it came from. Bugs in fjjs2 code, etc....
>=20
> This is scaring me.
>=20
> Anybody knows more about this problem, why it is caused, and hopefully ho=
w to
> prevent this?
>=20
> Thanks,
>=20
> --
> David Jander
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
