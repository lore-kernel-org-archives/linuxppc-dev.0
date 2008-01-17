Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 556EBDDEB6
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 00:47:21 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so142893anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 05:47:20 -0800 (PST)
Message-ID: <fa686aa40801170547q8c758dxef5aa301396f7f38@mail.gmail.com>
Date: Thu, 17 Jan 2008 06:47:07 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jochen Friedrich" <jochen@scram.de>
Subject: Re: [PATCH/RFC] [POWERPC] CPM1: implement GPIO LIB API
In-Reply-To: <478F4514.7030906@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <478F4514.7030906@scram.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jochen,

comments below.

On 1/17/08, Jochen Friedrich <jochen@scram.de> wrote:
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---

Need a more detailed change description.

>  arch/powerpc/platforms/8xx/Kconfig |    2 +
>  arch/powerpc/sysdev/commproc.c     |  162 +++++++++++++++++++++++++++++++++++-

Is this 8xx only?  Can it live in arch/powerpc/platforms/8xx?

>  2 files changed, 163 insertions(+), 1 deletions(-)
>
> +static struct of_gpio_chip cpm1_gc16 = {
> +       .gpio_cells = 1,
> +       .xlate = of_gpio_simple_xlate,
> +
> +       .gc = {
> +               .ngpio = 16,
> +               .direction_input = cpm1_gpio_dir_in16,
> +               .direction_output = cpm1_gpio_dir_out16,
> +               .get = cpm1_gpio_get16,
> +               .set = cpm1_gpio_set16,
> +       },
> +};
<snip>
> +static struct of_gpio_chip cpm1_gc32 = {
> +       .gpio_cells = 1,
> +       .xlate = of_gpio_simple_xlate,
> +
> +       .gc = {
> +               .ngpio = 32,
> +               .direction_input = cpm1_gpio_dir_in32,
> +               .direction_output = cpm1_gpio_dir_out32,
> +               .get = cpm1_gpio_get32,
> +               .set = cpm1_gpio_set32,
> +       },
> +};

Nit: Your naming convention seems a little backwards.  It took me a
moment to figure out what your hooks lined up with.  Can you make the
'16' and '32' part of the prefix instead of appended on the end?

ie. use 'cpm1_gpio16_dir_in' instead of 'cpm1_gpio_dir_in16'

> +int cpm1_gpiochip_add32(struct device_node *np)
> +{
> +       return of_mm_gpiochip_add(np, &cpm1_gc32);
> +}

Can you just drop this function and roll it into cpm_init_par_io?

> +
> +static int cpm_init_par_io(void)
> +{
> +       struct device_node *np;
> +
> +       for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank16")
> +               cpm1_gpiochip_add16(np);
> +
> +       for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank32")
> +               cpm1_gpiochip_add32(np);
> +       return 0;
> +}
> +arch_initcall(cpm_init_par_io);

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
