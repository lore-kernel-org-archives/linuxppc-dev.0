Subject: Re: OF properties access ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040118120722.GA4603@iliana>
References: <20040113114625.GA9294@iliana> <1074131387.818.43.camel@gaston>
	 <20040115074439.GB14039@iliana> <1074310140.8360.27.camel@gaston>
	 <20040118120722.GA4603@iliana>
Content-Type: text/plain
Message-Id: <1074468096.795.27.camel@gaston>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 10:21:36 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-01-18 at 23:07, Sven Luther wrote:
> On Sat, Jan 17, 2004 at 02:48:11PM +1100, Benjamin Herrenschmidt wrote:
> >
> > >
> > > But this doesn't reply me on why my attempts to read back integer values
> > > from OF property only result in the machine hanging, and since it is
> > > really early on, i don't even get serial console output to have an idea
> > > why :/
> > >
> > > in particular i cloned the code reading l2cr-value, and changed it to
> > > l2cr and instead of reading the value, i got only kernel silently dying.
> >
> > Show me the code and the relevant device-tree bits.
>
> Ok, here is the code that dies :
>
> void pegasos_set_l2cr(void) {

Grrr... please put the { on a different line

>         struct device_node *root = find_path_device("/");
>         char *machine;
>         struct device_node *np;
>
>         /* On Pegasos, enable the l2 cache if needed, as the OF forgets * it */

Check if root isn't NULL...

>         machine = get_property(root, "model", NULL);

Check if machine isn't NULL...

>         if (strncmp(machine, "Pegasos", 7) == 0) {
>                 /* Enable L2 cache if needed */
>                 np = find_devices ("cpus");
>                 if (np == 0)
>                         np = find_type_devices("cpu");
>                 if (np != 0) {
>                         unsigned int *l2cr = (unsigned int *)
>                                 get_property (np, "l2cr", NULL);

The above got you a _pointer_ to the value, the code below uses
that point directly as the value, which is obviously wrong

>                         if (!(l2cr & 0x80000000)) {
>                                 _set_L2CR(0);
>                                 _set_L2CR(l2cr | 0x80000000);
>                         }

The above should have been...

			if (l2cr && !((*l2cr) & L2CR_L2E)) {
				_set_L2CR(0);
				_set_L2CR((*l2cr) | L2CR_L2E);
			}

Now that is said providing your algorithm is right, that is the
device-tree provides you with an "l2cr" property containing the
right settings but not the enable bit, and matching what your CPU
is doing. If the device-tree has L2E set but not the CPU, you
may want to do things differently...

>                 }
>         }
> }

> And finally :
>
> $ hexdump /proc/device-tree/cpus/PowerPC,74x7/l2cr
> 0000000 0000 0000

So you "l2cr" value is just 0... Setting it to 0x80000000 means enabled
without any setting bit... that might actually be correct for on-die L2
though, check the CPU spec anyway. It is correct for my 7455

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
