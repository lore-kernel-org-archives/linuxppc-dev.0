Date: Mon, 22 Jan 2001 19:54:48 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: michdaen@iiic.ethz.ch
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <3A6C7970.2E3E88CA@relog.ch>
Message-ID: <Pine.GSO.4.10.10101221945230.19978-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Mon, 22 Jan 2001, Michel Dänzer wrote:

> > There is no pte table and so there is nothing mapped at that address, you
> > can use (pgd|pmd|pte)_present() to test for that.
>
> You are saying we should use *_present() to check each of these before using
> *_offset to get the pointer? And what if *_present() is false?

It depends what you what you want to do. If you just want to do a reverse
lookup, yes, you have to check the value with *_present.
But you can also map something at that address, then you had to use
*_alloc(), but leave that better to ioremap/vmalloc. (Look for map_page in
arch/ppc/mm/init.c for how it can be done.)

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
