Message-ID: <001701c28e91$8ab64b80$0200a8c0@telia.com>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Tim Seufert" <tas@mindspring.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <FA8676EA-FA77-11D6-AE66-003065F22EAA@mindspring.com>
Subject: Re: csum_partial() and csum_partial_copy_generic() in badly optimized?
Date: Mon, 18 Nov 2002 00:32:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Sunday, November 17, 2002, at 07:17  AM, Joakim Tjernlund wrote:
>
> >> CTR and the instructions which operate on it
> >> (such as bdnz) were put into the PPC architecture mainly as an
> >> optimization opportunity for loops where the loop variable is not used
> >> inside the loop body.
> >
> > loop variable not USED or loop variable not MODIFIED?
>
> Not used.  CTR cannot be specified as the source or destination of most
> instructions.  In order to access its contents you have to use special
> instructions that move between it and a normal general purpose register.

OK, so how about if I modify the crc32 loop:

unsigned char * end = data +len;
while(data < end) {
        result = (result << 8 | *data++) ^ crctab[result >> 24];
}

will that be possible to optimze in with something similar as bdnz also?

>
> >> Here's a summary of when gcc will compile
> >> that crc32 loop with use of CTR and bdnz (note that -O3 or above
> >> automatically turn on -funroll-loops, so I saw no point in testing
> >> those levels):
> >>
> >>            -O1    -O2    -O1 -funroll-loops    -O2 -funroll-loops
> >> 2.95.4    no     no     no                    no
> >> 3.1       no     yes    yes                   yes
> >
> > hmm, looks like I should upgrade gcc to 3.1 or possibly 3.2. However
> > I think that gcc >=3.0 has changed the ABI for C++, which is bad for
> > me.
>
> Sooner or later you're going to want to, though.  :)

Yes, but upgrading our customers will be a pain :-(

       Jocke

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
