Date: Fri, 29 Nov 2002 17:21:50 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Samuel Rydh <samuel@ibrium.se>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: asm inline
In-Reply-To: <20021129160826.GA27950@ibrium.se>
Message-ID: <Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 29 Nov 2002, Samuel Rydh wrote:

>
> I just noticed that gcc 3.1 doesn't like the following:
>
> static __inline__ void st_le32( ulong *addr, ulong val )
> {
>         __asm__ __volatile__( "stwbrx %1,0,%2"
> 				: "=m" (*addr)
> 				: "r" (val), "r" (addr) );
> }

How is "addr" declared ? This may be an aliasing problem. Does adding
-fno-strict-aliasing to the options help ? Or changing the "=m" to "+m" as
an incorrect, but less penalizing than a memory clobber, bandaid. Or
declaring addr as pointer to volatile ?

If nothing helps and it still happens with the recently released
gcc-3.2.1, submit a bug report to the GCC lists. I'd love to test it right
now but I'm upgrading all my systems to Debian Woody, not without trouble,
especially keyboard (spanish layout) and input layer related.

>
> The compiler misses the fact that *addr is modified and will happily
> turn the following
>
> 	st_le32( &b, 1UL << i );
> 	testing( b )
>
> into something like
>
> 	addi	r31,r1,28
> 	...
> 	lwz	r3,28(r1)	; loading b
> 	stwbrx	r9,0,r31
> 	bl	testing
>
> The real world example looked like this:
>
>     int i,b;
>     for( i=0; i<=30; i++ ) {
>         st_le32( &b, 1UL<<i );
>         printf("dbg:  %d %08lx b=%08lx\n", i, pic.reg[r_flag], b );
>         if( pic.reg[r_flag] & b )
>             break;
>     }
>
> Adding "memory" to the clobber list seems to be the only way to make
> gcc do the right thing :-(.

A "memory" clobber is such an optimization killer that it is not
acceptable in this situation (actually I consider a memory clober hardly
ever acceptable). I see that your example involves local variables, does
it also happen in the non-automatic case ?

	Regards,
	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
