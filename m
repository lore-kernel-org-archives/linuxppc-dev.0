Date: Sun, 3 Jan 1999 16:04:52 +0100 (MET)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: __init, __openfirmware, etc...
In-Reply-To: <19990103104228.031876@smtp.calvacom.fr>
Message-ID: <Pine.LNX.4.02.9901031352460.303-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 3 Jan 1999, Benjamin Herrenschmidt wrote:
> On Sat, Jan 2, 1999, Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be> wrote:
> >__init sections are indeed removed after kernel initialisation. The
> other ones
> >are removed depending on the dynamic run type of the machine, e.g. __pmac
> >sections are removed on PReP, and so on. Saves quite some valuable
> unswappable
> >kernel memory.c
> 
> Ok. Do you know what happens to static datas declared within an __init
> function ? Is it removed to ? I have a function that use a static array
> for putting permanent "override" values for part of the device tree and
> this array must not be removed. Should I put the static array out of the

I think it will be removed. I suggest to use `nm' or `objdump' or just plain
`make dirhiearchy/file.S' to find out in which section the data end up.

Note that __init isn't perfect: especially tables with strings are difficult to
put in __init, e.g.

    const char *table __init = {
	"string 1", "string 2",
    }

will put the table with pointers in an init section, while the string data
itself is put in the normal data section, which is usually not what you want.
You can circumvent that in a tedious way like:

    static const char string1[] = "string 1";
    static const char string2[] = "string 2";
    const char *table __init = {
	string1, string2
    };

> function too or will this remove mecanism avoid bss sections ?

BSS sections are always empty (zeroed), so you can't store initial data in them
:-)

To put a BSS variable in an init section, make sure to put at least one
synthetic initializer in it, like

    const char bssvar[100] __init = { 0, };

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
