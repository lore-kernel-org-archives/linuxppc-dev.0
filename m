Date: Sun, 18 Jan 2004 16:05:02 +0100
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: OF properties access ?
Message-ID: <20040118150502.GA7255@iliana>
References: <20040113114625.GA9294@iliana> <1074131387.818.43.camel@gaston> <20040115074439.GB14039@iliana> <1074310140.8360.27.camel@gaston> <20040118120722.GA4603@iliana> <1074468096.795.27.camel@gaston> <20040118143225.GA6717@iliana> <20040118145158.GA7011@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040118145158.GA7011@iliana>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 18, 2004 at 03:51:58PM +0100, Sven Luther wrote:
> void pegasos_set_l2cr(void)
> {
>         struct device_node *root = find_path_device("/");
>         char *machine;
>         struct device_node *np;
>         int l2cr_value;
>
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

Further tests show me that it is the if (l2cr == NULL) return; tests
which aborts the test.

Any idea what is going on here. Clearly we did read the right cpus, but
it is not possible to read the "l2cr" property.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
