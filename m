Date: Wed, 19 Apr 2000 16:21:31 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Stephane Laroche <stephane.laroche@sympatico.ca>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: char type is unsigned with PPC gcc?
In-Reply-To: <38FDBB60.34DE949@sympatico.ca>
Message-ID: <Pine.HPX.4.10.10004191614290.19933-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 19 Apr 2000, Stephane Laroche wrote:

>
> I just finished debugging the ASH shell, which wasn't running properly
> on my 860, and found out that it assumes (correctly if you ask me) that
> the type 'char' is signed.

No, signed char lead to bugs, I've already been vocal enough about it so I
won't repeat myself. I personnally consider that the only good char is the
unsigned char (signed char also lead to code bloat on many architecture
which have load byte with zero extension but not with sign extension).

> GCC 2.95.2 is configured to have chars unsigned by default on the
> PowerPC platforms.  The x86 GCC configures char to be signed... (looking
> at gcc/config/rs6000/rs6000.h for the ppc)
>
> Anyone knows why the PowerPC is different in this regard?

Because it's an ABI/Platform issue, not a compiler issue. Correctly
written programs should never assume that a char is signed or unsigned.
Any program which depends on this is buggy. This said, there are so many
programs that are buggy that gcc gives you the option with -fsigned-char
and -funsigned-char.

>
> Surely I'm not the first one to come across this problem.  Should I fix
> ASH or should I reconfigured gcc to default to signed char?  I think the
> latter is a better idea since, if I remember correctly, ANSI C says that
> char should be signed.

No, ANSI C leaves it to the implementation. Besides, did I already mention
that signed char leads to bugs ?

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
