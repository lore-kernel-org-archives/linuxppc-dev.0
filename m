Date: Sun, 18 Jan 2004 15:32:25 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: OF properties access ?
Message-ID: <20040118143225.GA6717@iliana>
References: <20040113114625.GA9294@iliana> <1074131387.818.43.camel@gaston> <20040115074439.GB14039@iliana> <1074310140.8360.27.camel@gaston> <20040118120722.GA4603@iliana> <1074468096.795.27.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074468096.795.27.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 19, 2004 at 10:21:36AM +1100, Benjamin Herrenschmidt wrote:
>
> On Sun, 2004-01-18 at 23:07, Sven Luther wrote:
> > On Sat, Jan 17, 2004 at 02:48:11PM +1100, Benjamin Herrenschmidt wrote:
> > >
> > > >
> > > > But this doesn't reply me on why my attempts to read back integer values
> > > > from OF property only result in the machine hanging, and since it is
> > > > really early on, i don't even get serial console output to have an idea
> > > > why :/
> > > >
> > > > in particular i cloned the code reading l2cr-value, and changed it to
> > > > l2cr and instead of reading the value, i got only kernel silently dying.
> > >
> > > Show me the code and the relevant device-tree bits.
> >
> > Ok, here is the code that dies :
> >
> > void pegasos_set_l2cr(void) {
>
> Grrr... please put the { on a different line

Ok. (altough i think this is a subject of philosophical debate :)

> >         struct device_node *root = find_path_device("/");
> >         char *machine;
> >         struct device_node *np;
> >
> >         /* On Pegasos, enable the l2 cache if needed, as the OF forgets * it */
>
> Check if root isn't NULL...

Ok.

> >         machine = get_property(root, "model", NULL);
>
> Check if machine isn't NULL...

Ok.

> >         if (strncmp(machine, "Pegasos", 7) == 0) {
> >                 /* Enable L2 cache if needed */
> >                 np = find_devices ("cpus");
> >                 if (np == 0)
> >                         np = find_type_devices("cpu");
> >                 if (np != 0) {
> >                         unsigned int *l2cr = (unsigned int *)
> >                                 get_property (np, "l2cr", NULL);
>
> The above got you a _pointer_ to the value, the code below uses
> that point directly as the value, which is obviously wrong

Arg, i copied the wrong version.

> >                         if (!(l2cr & 0x80000000)) {
> >                                 _set_L2CR(0);
> >                                 _set_L2CR(l2cr | 0x80000000);
> >                         }
>
> The above should have been...
>
> 			if (l2cr && !((*l2cr) & L2CR_L2E)) {
> 				_set_L2CR(0);
> 				_set_L2CR((*l2cr) | L2CR_L2E);
> 			}

In reality, i had both the code using l2cr, and the one using *l2cr, and
even a version like the pmac_setup code, which copied the content of the
l2cr pointer to a l2cr_value int, but none worked.

> Now that is said providing your algorithm is right, that is the
> device-tree provides you with an "l2cr" property containing the
> right settings but not the enable bit, and matching what your CPU
> is doing. If the device-tree has L2E set but not the CPU, you
> may want to do things differently...

Well, i have bugged the OF people, and they have indeed set the L2E bit
in future versions of the OF. Mostly what happens right now, is that L2E
is not set (i get a something around 30% decrease in compilation time
when doing the l2cr=0x80000000 thingy) and the l2cr property returns 0.

I also have had similar troubles with the /proc/pci@C0000000/display
bus_number property, altough it didn't die there.

> > $ hexdump /proc/device-tree/cpus/PowerPC,74x7/l2cr
> > 0000000 0000 0000
>
> So you "l2cr" value is just 0... Setting it to 0x80000000 means enabled
> without any setting bit... that might actually be correct for on-die L2
> though, check the CPU spec anyway. It is correct for my 7455

It is either a 7447 or a 750Cxe. It is correct for both, and we have
been using the l2cr=0x80000000 option as kernel boot option since ages.
It quickly becomes old to have to type this per hand each time though,
as we have no boot loader (yet).

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
