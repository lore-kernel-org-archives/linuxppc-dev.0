Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add Efika platform support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <454A5A61.6080800@bplan-gmbh.de>
References: <45490394.8020202@bplan-gmbh.de>
	<1162419546.25682.460.camel@localhost.localdomain>
	<1162423546.25682.486.camel@localhost.localdomain>
	<454A5A61.6080800@bplan-gmbh.de>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 10:45:25 +1100
Message-Id: <1162683925.28571.93.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-11-02 at 21:52 +0100, Nicolas DET wrote:

> Well. there was other init done here before. However, I think it's good 
> to have this here, in case more code would be needed or in the 
> ppc_md.init_IRQ is changed. no ?

No. Hook it directly. Don't solve problems you don't have. If you ever
need to do other inits there, you can change it back.

> Well. It it doesn't hurt it can stay here. People are a little bit weird 
> today. Maybe they would try to solder a PCI southbridige to get a nice 
> PC speaker beep ;-)

Yeah, doesn't hurt.

On a general note about your patches: Don't reply and post a new patch
in the same email. Reply, then separately, post patches using the proper
format for patch submission. That is, a changelog comment, a
Signed-off-by: line followed by the patch.

If you want to have off-the-record comments, add "---" after the
Signed-off-by: line and insert your comments between that and the patch
itself, they will be stripped when commiting to git.

Ben.

> * Efika 5K2 platform setup
> + * Some code really inspired from the lite5200b platform.

No (c) ?

> + * 
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + *
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/sched.h>
> +#include <linux/kernel.h>
> +#include <linux/ptrace.h>
> +#include <linux/slab.h>
> +#include <linux/user.h>
> +#include <linux/interrupt.h>
> +#include <linux/reboot.h>
> +#include <linux/init.h>
> +#include <linux/utsrelease.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/console.h>
> +#include <linux/seq_file.h>
> +#include <linux/root_dev.h>
> +#include <linux/initrd.h>
> +#include <linux/module.h>
> +#include <linux/timer.h>
> +
> +#include <asm/pgtable.h>
> +#include <asm/prom.h>
> +#include <asm/dma.h>
> +#include <asm/machdep.h>
> +#include <asm/irq.h>
> +#include <asm/sections.h>
> +#include <asm/time.h>
> +#include <asm/rtas.h>
> +#include <asm/of_device.h>
> +#include <asm/mpc52xx.h>
> +
> +#include "efika.h"

You probably don't need half of those includes :)

> +static void efika_show_cpuinfo(struct seq_file *m)
> +{
> +	struct device_node *root;
> +	const char *revision = NULL;
> +	const char *codegendescription = NULL;
> +	const char *codegenvendor = NULL;
> +
> +	root = of_find_node_by_path("/");
> +	if (root) {
> +		revision = get_property(root, "revision", NULL);
> +		codegendescription =
> +		    get_property(root, "CODEGEN,description", NULL);
> +		codegenvendor = get_property(root, "CODEGEN,vendor", NULL);
> +	}
> +
> +	of_node_put(root);

Move the above to after you are done with the results of get_property().

> +	if (codegendescription)
> +		seq_printf(m, "machine\t\t: %s\n", codegendescription);
> +	else
> +		seq_printf(m, "machine\t\t: Efika\n");
> +
> +	if (revision)
> +		seq_printf(m, "revision\t: %s\n", revision);
> +
> +	if (codegenvendor)
> +		seq_printf(m, "vendor\t\t: %s\n", codegenvendor);
> +}

> +static void __init efika_init_IRQ(void)
> +{
> +	mpc52xx_init_irq();
> +}

Just hook mpc52xx_init_irq() directly

> +static void __init efika_init(void)
> +{
> +	struct device_node *np;
> +	struct device_node *cnp = NULL;
> +	const u32 *base;
> +	char *name;
> +
> +	/* Find every child of the SOC node and add it to of_platform */
> +	np = of_find_node_by_name(NULL, "builtin");
> +	if (np) {
> +		while ((cnp = of_get_next_child(np, cnp))) {
> +			name = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
> +			if (name == NULL)
> +				continue;

Why kmalloc ?

> +			strcpy(name, cnp->name);
> +
> +			base = get_property(cnp, "reg", NULL);
> +			if (base == NULL) {
> +				kfree(name);
> +				continue;
> +			}
> +
> +			sprintf(name+strlen(name), "@%x", *base);
> +			of_platform_device_create(cnp, name, NULL);

Just use a stack based buffer. Either that, or kfree(name) when you are
done. of_platform_device_create() will make a copy of the sting.

Rest looks good.

Ben.
