Date: Sun, 18 Jan 2004 13:07:22 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: OF properties access ?
Message-ID: <20040118120722.GA4603@iliana>
References: <20040113114625.GA9294@iliana> <1074131387.818.43.camel@gaston> <20040115074439.GB14039@iliana> <1074310140.8360.27.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074310140.8360.27.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 17, 2004 at 02:48:11PM +1100, Benjamin Herrenschmidt wrote:
>
> >
> > But this doesn't reply me on why my attempts to read back integer values
> > from OF property only result in the machine hanging, and since it is
> > really early on, i don't even get serial console output to have an idea
> > why :/
> >
> > in particular i cloned the code reading l2cr-value, and changed it to
> > l2cr and instead of reading the value, i got only kernel silently dying.
>
> Show me the code and the relevant device-tree bits.

Ok, here is the code that dies :

void pegasos_set_l2cr(void) {
        struct device_node *root = find_path_device("/");
        char *machine;
        struct device_node *np;

        /* On Pegasos, enable the l2 cache if needed, as the OF forgets * it */
        machine = get_property(root, "model", NULL);
        if (strncmp(machine, "Pegasos", 7) == 0) {
                /* Enable L2 cache if needed */
                np = find_devices ("cpus");
                if (np == 0)
                        np = find_type_devices("cpu");
                if (np != 0) {
                        unsigned int *l2cr = (unsigned int *)
                                get_property (np, "l2cr", NULL);
                        if (!(l2cr & 0x80000000)) {
                                _set_L2CR(0);
                                _set_L2CR(l2cr | 0x80000000);
                        }
                }
        }
}

Called from just after chrp_find_bridges in chrp_setup_arch.

This has been mirrored from the code in pmac_setup_artch, in pmac_setup.c :

        /* Checks "l2cr-value" property in the registry */
        if (cur_cpu_spec[0]->cpu_features & CPU_FTR_L2CR) {
                struct device_node *np = find_devices("cpus");
                if (np == 0)
                        np = find_type_devices("cpu");
                if (np != 0) {
                        unsigned int *l2cr = (unsigned int *)
                                get_property(np, "l2cr-value", NULL);
                        if (l2cr != 0) {
                                ppc_override_l2cr = 1;
                                ppc_override_l2cr_value = *l2cr;
                                _set_L2CR(0);
                                _set_L2CR(ppc_override_l2cr_value);
                        }
                }
        }

Launching a kernel with this small changes only results with him dying
silently, without syncing back to the fbdev console and providing
output, nor showing anything on the serial console, but this is to be
expected given the place where it happens.

A, yes, you wanted the device-tree bit also, i have (from linux) :

$ ls /proc/device-tree/cpus/PowerPC,74x7
altivec             d-cache-sets  external-control    i-tlb-sets	name                      tlb-size
available           d-cache-size  general-purpose     i-tlb-size	performance-monitor       tlb-split
bus-frequency       d-tlb-sets    graphics            l2-cache  	reg translations
clock-frequency     d-tlb-size    i-cache-block-size  l2cr		reservation-granule-size
cpu-version         data-streams  i-cache-line-size   l3-cache		state
d-cache-block-size  device_type   i-cache-sets        l3cr		timebase-frequency
d-cache-line-size   existing      i-cache-size        linux,phandle	tlb-sets

And :

$ ls -l /proc/device-tree/cpus/PowerPC,74x7/l2cr
-r--r--r--    1 root     root            4 Jan 18 13:06 /proc/device-tree/cpus/PowerPC,74x7/l2cr

And finally :

$ hexdump /proc/device-tree/cpus/PowerPC,74x7/l2cr
0000000 0000 0000
0000004

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
