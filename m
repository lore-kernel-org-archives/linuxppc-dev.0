Date: Fri, 29 Nov 2002 17:08:26 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Subject: asm inline
Message-ID: <20021129160826.GA27950@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just noticed that gcc 3.1 doesn't like the following:

static __inline__ void st_le32( ulong *addr, ulong val )
{
        __asm__ __volatile__( "stwbrx %1,0,%2"
				: "=m" (*addr)
				: "r" (val), "r" (addr) );
}

The compiler misses the fact that *addr is modified and will happily
turn the following

	st_le32( &b, 1UL << i );
	testing( b )

into something like

	addi	r31,r1,28
	...
	lwz	r3,28(r1)	; loading b
	stwbrx	r9,0,r31
	bl	testing

The real world example looked like this:

    int i,b;
    for( i=0; i<=30; i++ ) {
        st_le32( &b, 1UL<<i );
        printf("dbg:  %d %08lx b=%08lx\n", i, pic.reg[r_flag], b );
        if( pic.reg[r_flag] & b )
            break;
    }

Adding "memory" to the clobber list seems to be the only way to make
gcc do the right thing :-(.

/Samuel


Btw. I'm using gcc 3.1 cross compiled for x86.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
