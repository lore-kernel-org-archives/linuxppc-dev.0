Message-ID: <38453959.F7D6F95D@fadata.bg>
Date: Wed, 01 Dec 1999 17:06:01 +0200
From: Momchil Velikov <velco@fadata.bg>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        Stephen Edie <sedie@terraplex.com>, linuxppc-dev@lists.linuxppc.org,
        yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: Frame buffer / mmap() weirdness
References: <Pine.HPX.4.10.9912011342440.10294-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
> 
> On Wed, 1 Dec 1999, Momchil Velikov wrote:
> >   [a & ~PAGE_MASK, (a + off + PAGE_SIZE - 1) & ~PAGE_SIZE)
> > to
> >   [b & ~PAGE_MASK, (b + off + PAGE_SIZE - 1) & ~PAGE_SIZE)
> 
> Some PAGE_SIZE are actually PAGE_MASK in this snippet...

Oops, my PAGE fault. It should be
  [a & PAGE_MASK, (a + off + ~PAGE_MASK) & PAGE_MASK )
to
  [b & PAGE_MASK, (b + off + ~PAGE_MASK) & PAGE_MASK )

where PAGE_MASK == ~(PAGE_SIZE -1).

Regards,
-velco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
