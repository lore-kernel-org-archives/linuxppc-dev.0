Message-ID: <009f01c19938$efaa0580$2f438209@endicott.ibm.com>
From: "Michael Washburn" <mwashbur@stny.rr.com>
To: "Kent Borg" <kentborg@borg.org>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <20020109112508.B4902@borg.org>
Subject: Re: Boot ROM Responsibilities (and GDB)?
Date: Wed, 9 Jan 2002 13:10:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kent,

I just scanned through several PPC 405 Boot code sources and found that they
are all resetting the DBCR very early after the cpu starts up. These sources
include the openbios support, mentioned by Armin Kuster in his response, and
in the ppcboot sources (http://ppcboot.sourceforge.net/  ), along with
several boot sources I've developed.

The 405GP User's Manual (
http://www-3.ibm.com/chips/techlib/techlib.nsf/techdocs/852569B20050FF778525
6996006130F8 )does offer a slight hint to do this in section 8.10, though
they don't say what it should be set to since it is application dependent.

Good Luck,
Mike
----- Original Message -----
From: "Kent Borg" <kentborg@borg.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, January 09, 2002 11:25 AM
Subject: Boot ROM Responsibilities (and GDB)?


>
> Is there any documentation on what a 405 boot ROM is supposed to do
> before jumping to the PPC kernel?
>
> We finally found what was messing with our use of GDB.  DBSR was
> (sometimes) coming up with some unfortunate bits set, our boot ROM
> didn't know to clear them and the code that actually uses the CPU's
> debug hardware didn't bother to put that hardware in an appropriate
> state.
>
> Coming from an old fashioned perspective where boot ROMs are little
> and only sufficient to get the next higher level of program running,
> it seems strange to make them have to know anything about details of
> assorted hardware other than to disable optional things and make very
> basic things (like RAM access) work.
>
> Because we have a custom boot ROM (lifted from a previous non-Linux
> use of the same board--that's part of the beauty of having boot ROMs
> be simple, they are then quite universal and can be written quite
> early in the project before you even know what the project is) what
> else are we missing?
>
> What are a PPC boot ROM's responsibilities?  (I.E., what do we add to
> our version of head.S.)
>
>
> Thanks,
>
> -kb, the Kent who is trying to keep his head in two different arch
> trees at once without too much confusion.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
