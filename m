Subject: Re: OF properties access ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040118145158.GA7011@iliana>
References: <20040113114625.GA9294@iliana> <1074131387.818.43.camel@gaston>
	 <20040115074439.GB14039@iliana> <1074310140.8360.27.camel@gaston>
	 <20040118120722.GA4603@iliana> <1074468096.795.27.camel@gaston>
	 <20040118143225.GA6717@iliana>  <20040118145158.GA7011@iliana>
Content-Type: text/plain
Message-Id: <1074503060.812.44.camel@gaston>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 20:04:21 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> void pegasos_set_l2cr(void)
> {
>         struct device_node *root = find_path_device("/");
>         char *machine;
>         struct device_node *np;
>         int l2cr_value;

What about "unsigned int" above and not doing int/unsigned int
conversions and such ? (Dunno if it explains your problem at
this point but it's worth fixing anyway)

>         /* On Pegasos, enable the l2 cache if needed, as the OF forgets * it */
>         if (root == NULL) return;
>         machine = get_property(root, "model", NULL);
>         if (machine == NULL) return;
>         if (strncmp(machine, "Pegasos", 7) == 0) {
>                 /* Enable L2 cache if needed */
>                 np = find_devices ("cpus");
>                 if (np == NULL)
>                         np = find_type_devices("cpu");
>                 if (np != NULL) {
>                         unsigned int *l2cr = (unsigned int *)
>                                 get_property (np, "l2cr", NULL);
>                         if (l2cr == NULL) return;
>                         l2cr_value = *l2cr;
>                         if (!(l2cr_value & 0x80000000)) {
>                                 _set_L2CR(0);
>                                 _set_L2CR(l2cr_value | 0x80000000);
>                         }
>                 }
>         }
> }
>
> Does not die, but also does not seem to enable the l2cr thingy, but
> then, i don't know how fiable the info from /proc/sys/kernel/l2cr is :
>
> 0x00000000:  L2 disabled, no parity, no instn only, no data only,
> default replacement

The value is reliable, the text explanation of the bits isn't on this
CPU.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
