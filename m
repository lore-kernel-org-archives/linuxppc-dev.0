Message-ID: <3A6C7970.2E3E88CA@relog.ch>
Date: Mon, 22 Jan 2001 19:18:24 +0100
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: michdaen@iiic.ethz.ch
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <Pine.GSO.4.10.10101221854100.18061-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel wrote:

> > > [drm] drm_sg_alloc
> > > i: ca292000
> > > pgd: c014dca0
> > > pmd: c014dca0
> > > pte: 00000a48
> > > Oops: kernel access of bad area, sig: 11
> >
> > Looking at pgd/pmd, pte seems fishy for a pointer. Any reason why this
> > code shouldn't work on PPC?
>
> There is no pte table and so there is nothing mapped at that address, you
> can use (pgd|pmd|pte)_present() to test for that.

You are saying we should use *_present() to check each of these before using
*_offset to get the pointer? And what if *_present() is false?


Michel


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
