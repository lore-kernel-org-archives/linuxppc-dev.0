Message-Id: <20001224225303.Postino-014755@smtp01.highway.ne.jp>
Date: Sun, 24 Dec 2000 22:53:03 +0900
To: Alexandre Oliva <aoliva@redhat.com>
CC: <gcc@gcc.gnu.org>, <linuxppc-dev@lists.linuxppc.org>
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: kerne-2.4.0-test13pre3 with gcc-2.97
In-Reply-To: <or66kazecj.fsf@guarana.lsd.ic.unicamp.br>
References: <20001223145258.Postino-022361@smtp01.highway.ne.jp> Kaoru Fukui's
 message of "Sat, 23 Dec 2000 14:52:58 +0900"
 <or66kazecj.fsf@guarana.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Alexandre Oliva <aoliva@redhat.com>
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: kerne-2.4.0-test13pre3 with gcc-2.97
Date: 24 Dec 2000 01:29:32 -0200
Cc: <linuxppc-dev@lists.linuxppc.org>, <gcc@gcc.gnu.org>

>
> On Dec 23, 2000, Kaoru Fukui <k_fukui@highway.ne.jp> wrote:
>
> > -		unsigned char b[0];
> > +		unsigned char *b;
>
> This change (and apparently all other changes you've made) are
> definitely wrong.  Zero-sized arrays as the last element of a
> structure used to be an extension in GCC 2.95.2, that has been adopted
> by C99 with a slightly different syntax, that GCC CVS supports: just
> remove the `0' from between the braces.
>
> With your change, you're changing what is supposed to be a structure
> whose last element is a flexible array with a structure that ends with
> a pointer to such an array, which means the array should be allocated
> separately, and any access to it must de-reference an additional
> pointer.  You'd have to adjust all uses of such a pointer to make this
> change.  Could this be the reason why your modified kernel doesn't
> work?

Thanks Alex your explain.

I tried this

 -		unsigned char b[0];
 +		unsigned char b[];

It gave me Inetrnal  error: Segmentaion fault .

I had success compileing for the kernel with my patch.

I don't understand how do I do untill.

Thanks
Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
