Date: Fri, 29 Nov 2002 18:49:42 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm inline
Message-ID: <20021129174942.GA833@ibrium.se>
References: <20021129160826.GA27950@ibrium.se> <Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 29, 2002 at 05:21:50PM +0100, Gabriel Paubert wrote:
> On Fri, 29 Nov 2002, Samuel Rydh wrote:
> How is "addr" declared ? This may be an aliasing problem. Does adding
> -fno-strict-aliasing to the options help ? Or changing the "=m" to "+m" as
> an incorrect, but less penalizing than a memory clobber, bandaid. Or
> declaring addr as pointer to volatile ?

Turning of aliasing did indeed solve the problem. As did changing
unsigned long to int.

> > Adding "memory" to the clobber list seems to be the only way to make
> > gcc do the right thing :-(.
>
> A "memory" clobber is such an optimization killer that it is not
> acceptable in this situation (actually I consider a memory clober hardly
> ever acceptable).

Agreed. A "memory" clobber is definitely suboptimal.

> I see that your example involves local variables, does
> it also happen in the non-automatic case ?

It happens in the non-automatic case too. I'll try the
latest gcc version later.

/Samuel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
