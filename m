Date: Mon, 2 Dec 2002 20:17:47 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm inline
Message-ID: <20021202191747.GA11391@ibrium.se>
References: <20021202170017.GA8469@ibrium.se> <Pine.LNX.4.33.0212021840350.10165-100000@gra-lx1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0212021840350.10165-100000@gra-lx1.iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 02, 2002 at 06:53:47PM +0100, Gabriel Paubert wrote:
> > ...which is desirable in this case. The st_le32 inline is just an efficient
> > way to flip the endian and is not supposted to have any undeclared
> > side effects (like touching hardware).
>
> Efficient?

Well the scenario I had in mind was

	int x = ld_le32( &le_struct.x );
	...
	do some ops on x
	...
	st_le32( &le_struct.x, x )

Hard to beat endian flipping load and store operations in
that context :-). But you are of course right that it is quite
inefficient if one operates on something already loaded into a
register.

/Samuel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
