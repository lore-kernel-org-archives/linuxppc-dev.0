Date: Sun, 18 Jan 2004 15:51:58 +0100
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: OF properties access ?
Message-ID: <20040118145158.GA7011@iliana>
References: <20040113114625.GA9294@iliana> <1074131387.818.43.camel@gaston> <20040115074439.GB14039@iliana> <1074310140.8360.27.camel@gaston> <20040118120722.GA4603@iliana> <1074468096.795.27.camel@gaston> <20040118143225.GA6717@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040118143225.GA6717@iliana>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 18, 2004 at 03:32:25PM +0100, Sven Luther wrote:
>
> On Mon, Jan 19, 2004 at 10:21:36AM +1100, Benjamin Herrenschmidt wrote:
> >
> > On Sun, 2004-01-18 at 23:07, Sven Luther wrote:
> > > On Sat, Jan 17, 2004 at 02:48:11PM +1100, Benjamin Herrenschmidt wrote:
> > > >
> > > > >
> > > > > But this doesn't reply me on why my attempts to read back integer values
> > > > > from OF property only result in the machine hanging, and since it is
> > > > > really early on, i don't even get serial console output to have an idea
> > > > > why :/
> > > > >
> > > > > in particular i cloned the code reading l2cr-value, and changed it to
> > > > > l2cr and instead of reading the value, i got only kernel silently dying.
> > > >
> > > > Show me the code and the relevant device-tree bits.
> > >
> > > Ok, here is the code that dies :
> > >
> > > void pegasos_set_l2cr(void) {
> >
> > Grrr... please put the { on a different line
>
> Ok. (altough i think this is a subject of philosophical debate :)
>
> > >         struct device_node *root = find_path_device("/");
> > >         char *machine;
> > >         struct device_node *np;
> > >
> > >         /* On Pegasos, enable the l2 cache if needed, as the OF forgets * it */
> >
> > Check if root isn't NULL...
>

Ok, the following version :

void pegasos_set_l2cr(void)
{
        struct device_node *root = find_path_device("/");
        char *machine;
        struct device_node *np;
        int l2cr_value;

        /* On Pegasos, enable the l2 cache if needed, as the OF forgets * it */
        if (root == NULL) return;
        machine = get_property(root, "model", NULL);
        if (machine == NULL) return;
        if (strncmp(machine, "Pegasos", 7) == 0) {
                /* Enable L2 cache if needed */
                np = find_devices ("cpus");
                if (np == NULL)
                        np = find_type_devices("cpu");
                if (np != NULL) {
                        unsigned int *l2cr = (unsigned int *)
                                get_property (np, "l2cr", NULL);
                        if (l2cr == NULL) return;
                        l2cr_value = *l2cr;
                        if (!(l2cr_value & 0x80000000)) {
                                _set_L2CR(0);
                                _set_L2CR(l2cr_value | 0x80000000);
                        }
                }
        }
}

Does not die, but also does not seem to enable the l2cr thingy, but
then, i don't know how fiable the info from /proc/sys/kernel/l2cr is :

0x00000000:  L2 disabled, no parity, no instn only, no data only,
default replacement

Friendly,

Sven Luther


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
