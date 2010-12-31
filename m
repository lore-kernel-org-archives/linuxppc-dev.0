Return-Path: <stephen.neuendorffer@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20101231091500.7355.2314.stgit@localhost6.localdomain6>
References: <20101231091500.7355.2314.stgit@localhost6.localdomain6>
Date: Fri, 31 Dec 2010 07:59:02 -0800
Message-ID: <AANLkTikG+F+LbbHKfHKzcMKZjxxj=GzhjdeHZ6Jo10mq@mail.gmail.com>
Subject: Re: [PATCH] of/flattree: Add of_flat_dt_match() helper function
From: Stephen Neuendorffer <stephen.neuendorffer@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: multipart/alternative; boundary=90e6ba53a55e89877c0498b6e1eb
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--90e6ba53a55e89877c0498b6e1eb
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Dec 31, 2010 at 1:15 AM, Grant Likely <grant.likely@secretlab.ca>wrote:

> This patch adds of_flat_dt_match() which tests a node for
> compatibility with a list of values and converts the relevant powerpc
> platform code to use it.  This approach simplifies the board support
> code a bit.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>

reviewed-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

minor nits below.


> ---
>  arch/powerpc/platforms/40x/ppc40x_simple.c    |   13 +++-------
>  arch/powerpc/platforms/512x/mpc5121_generic.c |   13 +---------
>  arch/powerpc/platforms/52xx/lite5200.c        |   16 +++++-------
>  arch/powerpc/platforms/52xx/media5200.c       |   13 +---------
>  arch/powerpc/platforms/52xx/mpc5200_simple.c  |   13 +---------
>  arch/powerpc/platforms/83xx/mpc830x_rdb.c     |   13 ++++++----
>  arch/powerpc/platforms/83xx/mpc831x_rdb.c     |   11 +++++---
>  arch/powerpc/platforms/83xx/mpc837x_rdb.c     |   15 +++++++----
>  arch/powerpc/platforms/85xx/tqm85xx.c         |   20 +++++++--------
>  drivers/of/fdt.c                              |   34
> ++++++++++++++++++++++++-
>  include/linux/of_fdt.h                        |    1 +
>  11 files changed, 84 insertions(+), 78 deletions(-)
>
> diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c
> b/arch/powerpc/platforms/40x/ppc40x_simple.c
> index 546bbc2..2521d93 100644
> --- a/arch/powerpc/platforms/40x/ppc40x_simple.c
> +++ b/arch/powerpc/platforms/40x/ppc40x_simple.c
> @@ -50,7 +50,7 @@ machine_device_initcall(ppc40x_simple,
> ppc40x_device_probe);
>  * Again, if your board needs to do things differently then create a
>  * board.c file for it rather than adding it to this list.
>  */
> -static char *board[] __initdata = {
> +static const char *board[] __initdata = {
>        "amcc,acadia",
>        "amcc,haleakala",
>        "amcc,kilauea",
> @@ -60,14 +60,9 @@ static char *board[] __initdata = {
>
>  static int __init ppc40x_probe(void)
>  {
> -       unsigned long root = of_get_flat_dt_root();
> -       int i = 0;
> -
> -       for (i = 0; i < ARRAY_SIZE(board); i++) {
> -               if (of_flat_dt_is_compatible(root, board[i])) {
> -                       ppc_pci_set_flags(PPC_PCI_REASSIGN_ALL_RSRC);
> -                       return 1;
> -               }
> +       if (of_flat_dt_match(of_get_flat_dt_root(), board)) {
> +               ppc_pci_set_flags(PPC_PCI_REASSIGN_ALL_RSRC);
> +               return 1;
>        }
>
>        return 0;
> diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c
> b/arch/powerpc/platforms/512x/mpc5121_generic.c
> index e487eb0..926731f 100644
> --- a/arch/powerpc/platforms/512x/mpc5121_generic.c
> +++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
> @@ -26,7 +26,7 @@
>  /*
>  * list of supported boards
>  */
> -static char *board[] __initdata = {
> +static const char *board[] __initdata = {
>        "prt,prtlvt",
>        NULL
>  };
> @@ -36,16 +36,7 @@ static char *board[] __initdata = {
>  */
>  static int __init mpc5121_generic_probe(void)
>  {
> -       unsigned long node = of_get_flat_dt_root();
> -       int i = 0;
> -
> -       while (board[i]) {
> -               if (of_flat_dt_is_compatible(node, board[i]))
> -                       break;
> -               i++;
> -       }
> -
> -       return board[i] != NULL;
> +       return of_flat_dt_match(of_get_flat_dt_root(), board);
>  }
>
>  define_machine(mpc5121_generic) {
> diff --git a/arch/powerpc/platforms/52xx/lite5200.c
> b/arch/powerpc/platforms/52xx/lite5200.c
> index de55bc0..01ffa64 100644
> --- a/arch/powerpc/platforms/52xx/lite5200.c
> +++ b/arch/powerpc/platforms/52xx/lite5200.c
> @@ -172,20 +172,18 @@ static void __init lite5200_setup_arch(void)
>        mpc52xx_setup_pci();
>  }
>
> +static const char *board[] __initdata = {
> +       "fsl,lite5200",
> +       "fsl,lite5200b",
> +       NULL,
> +};
> +
>  /*
>  * Called very early, MMU is off, device-tree isn't unflattened
>  */
>  static int __init lite5200_probe(void)
>  {
> -       unsigned long node = of_get_flat_dt_root();
> -       const char *model = of_get_flat_dt_prop(node, "model", NULL);
> -
> -       if (!of_flat_dt_is_compatible(node, "fsl,lite5200") &&
> -           !of_flat_dt_is_compatible(node, "fsl,lite5200b"))
> -               return 0;
> -       pr_debug("%s board found\n", model ? model : "unknown");
> -
> -       return 1;
> +       return of_flat_dt_match(of_get_flat_dt_root(), board);
>  }
>
>  define_machine(lite5200) {
> diff --git a/arch/powerpc/platforms/52xx/media5200.c
> b/arch/powerpc/platforms/52xx/media5200.c
> index 0bac3a3..2c7780c 100644
> --- a/arch/powerpc/platforms/52xx/media5200.c
> +++ b/arch/powerpc/platforms/52xx/media5200.c
> @@ -239,7 +239,7 @@ static void __init media5200_setup_arch(void)
>  }
>
>  /* list of the supported boards */
> -static char *board[] __initdata = {
> +static const char *board[] __initdata = {
>        "fsl,media5200",
>        NULL
>  };
> @@ -249,16 +249,7 @@ static char *board[] __initdata = {
>  */
>  static int __init media5200_probe(void)
>  {
> -       unsigned long node = of_get_flat_dt_root();
> -       int i = 0;
> -
> -       while (board[i]) {
> -               if (of_flat_dt_is_compatible(node, board[i]))
> -                       break;
> -               i++;
> -       }
> -
> -       return (board[i] != NULL);
> +       return of_flat_dt_match(of_get_flat_dt_root(), board);
>  }
>
>  define_machine(media5200_platform) {
> diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c
> b/arch/powerpc/platforms/52xx/mpc5200_simple.c
> index d45be5b..e36d6e2 100644
> --- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
> +++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
> @@ -49,7 +49,7 @@ static void __init mpc5200_simple_setup_arch(void)
>  }
>
>  /* list of the supported boards */
> -static char *board[] __initdata = {
> +static const char *board[] __initdata = {
>        "intercontrol,digsy-mtc",
>        "manroland,mucmc52",
>        "manroland,uc101",
> @@ -66,16 +66,7 @@ static char *board[] __initdata = {
>  */
>  static int __init mpc5200_simple_probe(void)
>  {
> -       unsigned long node = of_get_flat_dt_root();
> -       int i = 0;
> -
> -       while (board[i]) {
> -               if (of_flat_dt_is_compatible(node, board[i]))
> -                       break;
> -               i++;
> -       }
> -
> -       return (board[i] != NULL);
> +       return of_flat_dt_match(of_get_flat_dt_root(), board);
>  }
>
>  define_machine(mpc5200_simple_platform) {
> diff --git a/arch/powerpc/platforms/83xx/mpc830x_rdb.c
> b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
> index 846831d..661d354 100644
> --- a/arch/powerpc/platforms/83xx/mpc830x_rdb.c
> +++ b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
> @@ -57,16 +57,19 @@ static void __init mpc830x_rdb_init_IRQ(void)
>        ipic_set_default_priority();
>  }
>
> +struct const char *board[] __initdata = {
> +       "MPC8308RDB",
> +       "fsl,mpc8308rdb",
> +       "denx,mpc8308_p1m",
> +       NULL
> +}
> +
>  /*
>  * Called very early, MMU is off, device-tree isn't unflattened
>  */
>  static int __init mpc830x_rdb_probe(void)
>  {
> -       unsigned long root = of_get_flat_dt_root();
> -
> -       return of_flat_dt_is_compatible(root, "MPC8308RDB") ||
> -              of_flat_dt_is_compatible(root, "fsl,mpc8308rdb") ||
> -              of_flat_dt_is_compatible(root, "denx,mpc8308_p1m");
> +       return of_flat_dt_match(of_get_flat_dt_root(), board);
>  }
>
>  static struct of_device_id __initdata of_bus_ids[] = {
> diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
> b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
> index ae525e4..b54cd73 100644
> --- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
> +++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
> @@ -60,15 +60,18 @@ static void __init mpc831x_rdb_init_IRQ(void)
>        ipic_set_default_priority();
>  }
>
> +struct const char *board[] __initdata = {
> +       "MPC8313ERDB",
> +       "fsl,mpc8315erdb",
> +       NULL
> +}
> +
>  /*
>  * Called very early, MMU is off, device-tree isn't unflattened
>  */
>  static int __init mpc831x_rdb_probe(void)
>  {
> -       unsigned long root = of_get_flat_dt_root();
> -
> -       return of_flat_dt_is_compatible(root, "MPC8313ERDB") ||
> -              of_flat_dt_is_compatible(root, "fsl,mpc8315erdb");
> +       return of_flat_dt_match(of_get_flat_dt_root(), board);
>  }
>
>  static struct of_device_id __initdata of_bus_ids[] = {
> diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
> b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
> index 910caa6..7bafbf2 100644
> --- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
> +++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
> @@ -101,17 +101,20 @@ static void __init mpc837x_rdb_init_IRQ(void)
>        ipic_set_default_priority();
>  }
>
> +static const char *board[] __initdata = {
> +       "fsl,mpc8377rdb",
> +       "fsl,mpc8378rdb",
> +       "fsl,mpc8379rdb",
> +       "fsl,mpc8377wlan",
> +       NULL
> +};
> +
>  /*
>  * Called very early, MMU is off, device-tree isn't unflattened
>  */
>  static int __init mpc837x_rdb_probe(void)
>  {
> -       unsigned long root = of_get_flat_dt_root();
> -
> -       return of_flat_dt_is_compatible(root, "fsl,mpc8377rdb") ||
> -              of_flat_dt_is_compatible(root, "fsl,mpc8378rdb") ||
> -              of_flat_dt_is_compatible(root, "fsl,mpc8379rdb") ||
> -              of_flat_dt_is_compatible(root, "fsl,mpc8377wlan");
> +       return of_flat_dt_match(of_get_flat_dt_root(), board);
>  }
>
>  define_machine(mpc837x_rdb) {
> diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c
> b/arch/powerpc/platforms/85xx/tqm85xx.c
> index 8f29bbc..5e847d0 100644
> --- a/arch/powerpc/platforms/85xx/tqm85xx.c
> +++ b/arch/powerpc/platforms/85xx/tqm85xx.c
> @@ -186,21 +186,21 @@ static int __init declare_of_platform_devices(void)
>  }
>  machine_device_initcall(tqm85xx, declare_of_platform_devices);
>
> +static const char *board[] __initdata = {
> +       "tqc,tqm8540",
> +       "tqc,tqm8541",
> +       "tqc,tqm8548",
> +       "tqc,tqm8555",
> +       "tqc,tqm8560",
> +       NULL
> +};
> +
>  /*
>  * Called very early, device-tree isn't unflattened
>  */
>  static int __init tqm85xx_probe(void)
>  {
> -       unsigned long root = of_get_flat_dt_root();
> -
> -       if ((of_flat_dt_is_compatible(root, "tqc,tqm8540")) ||
> -           (of_flat_dt_is_compatible(root, "tqc,tqm8541")) ||
> -           (of_flat_dt_is_compatible(root, "tqc,tqm8548")) ||
> -           (of_flat_dt_is_compatible(root, "tqc,tqm8555")) ||
> -           (of_flat_dt_is_compatible(root, "tqc,tqm8560")))
> -               return 1;
> -
> -       return 0;
> +       return of_flat_dt_match(of_get_flat_dt_root(), board);
>  }
>
>  define_machine(tqm85xx) {
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 8a90ee4..5a3db04 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -78,19 +78,23 @@ void *of_fdt_get_property(struct boot_param_header
> *blob,
>  * @blob: A device tree blob
>  * @node: node to test
>  * @compat: compatible string to compare with compatible list.
> + *
> + * On match, returns a non-zero value with smaller values returned for
> more
> + * specific compatible values.
>  */
>  int of_fdt_is_compatible(struct boot_param_header *blob,
>                      unsigned long node, const char *compat)
>  {
>        const char *cp;
> -       unsigned long cplen, l;
> +       unsigned long cplen, l, score = 0;
>
>        cp = of_fdt_get_property(blob, node, "compatible", &cplen);
>        if (cp == NULL)
>                return 0;
>        while (cplen > 0) {
> +               score++;
>                if (of_compat_cmp(cp, compat, strlen(compat)) == 0)
> -                       return 1;
> +                       return score;
>                l = strlen(cp) + 1;
>                cp += l;
>                cplen -= l;
> @@ -99,6 +103,24 @@ int of_fdt_is_compatible(struct boot_param_header
> *blob,
>        return 0;
>  }
>
> +/**
> + * of_flat_dt_match - Return true if node matches a list of compatible
> values
>

copy-paste error.


> + */
> +int of_fdt_match(struct boot_param_header *blob, unsigned long node,
> +                 const char **compat)
> +{
> +       unsigned int tmp, score = 0;
> +
> +       while (*compat) {
> +               tmp = of_fdt_is_compatible(blob, node, *compat);
> +               if (tmp && (score == 0 || (tmp < score)))
> +                       score = tmp;
> +               compat++;
> +       }
> +
> +       return score;
> +}
> +
>  static void *unflatten_dt_alloc(unsigned long *mem, unsigned long size,
>                                       unsigned long align)
>  {
> @@ -511,6 +533,14 @@ int __init of_flat_dt_is_compatible(unsigned long
> node, const char *compat)
>        return of_fdt_is_compatible(initial_boot_params, node, compat);
>  }
>
> +/**
> + * of_flat_dt_match - Return true if node matches a list of compatible
> values
> + */
> +int __init of_flat_dt_match(unsigned long node, const char **compat)
> +{
> +       return of_fdt_match(initial_boot_params, node, compat);
> +}
> +
>  #ifdef CONFIG_BLK_DEV_INITRD
>  /**
>  * early_init_dt_check_for_initrd - Decode initrd location from flat tree
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index 9ce5dfd..fb327f3 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -84,6 +84,7 @@ extern int of_scan_flat_dt(int (*it)(unsigned long node,
> const char *uname,
>  extern void *of_get_flat_dt_prop(unsigned long node, const char *name,
>                                 unsigned long *size);
>  extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
> +extern int of_flat_dt_match(unsigned long node, const char **matches);
>

Maybe export of_fdt_match, too?


>  extern unsigned long of_get_flat_dt_root(void);
>
>  extern int early_init_dt_scan_chosen(unsigned long node, const char
> *uname,
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

--90e6ba53a55e89877c0498b6e1eb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Dec 31, 2010 at 1:15 AM, Grant L=
ikely <span dir=3D"ltr">&lt;<a href=3D"mailto:grant.likely@secretlab.ca">gr=
ant.likely@secretlab.ca</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex;">
This patch adds of_flat_dt_match() which tests a node for<br>
compatibility with a list of values and converts the relevant powerpc<br>
platform code to use it. =A0This approach simplifies the board support<br>
code a bit.<br>
<br>
Signed-off-by: Grant Likely &lt;<a href=3D"mailto:grant.likely@secretlab.ca=
">grant.likely@secretlab.ca</a>&gt;<br></blockquote><div><br></div><div>rev=
iewed-by: Stephen Neuendorffer &lt;<a href=3D"mailto:stephen.neuendorffer@x=
ilinx.com">stephen.neuendorffer@xilinx.com</a>&gt;</div>
<div><br></div><div>minor nits below.</div><div>=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex;">
---<br>
=A0arch/powerpc/platforms/40x/ppc40x_simple.c =A0 =A0| =A0 13 +++-------<br=
>
=A0arch/powerpc/platforms/512x/mpc5121_generic.c | =A0 13 +---------<br>
=A0arch/powerpc/platforms/52xx/lite5200.c =A0 =A0 =A0 =A0| =A0 16 +++++----=
---<br>
=A0arch/powerpc/platforms/52xx/media5200.c =A0 =A0 =A0 | =A0 13 +---------<=
br>
=A0arch/powerpc/platforms/52xx/mpc5200_simple.c =A0| =A0 13 +---------<br>
=A0arch/powerpc/platforms/83xx/mpc830x_rdb.c =A0 =A0 | =A0 13 ++++++----<br=
>
=A0arch/powerpc/platforms/83xx/mpc831x_rdb.c =A0 =A0 | =A0 11 +++++---<br>
=A0arch/powerpc/platforms/83xx/mpc837x_rdb.c =A0 =A0 | =A0 15 +++++++----<b=
r>
=A0arch/powerpc/platforms/85xx/tqm85xx.c =A0 =A0 =A0 =A0 | =A0 20 +++++++--=
------<br>
=A0drivers/of/fdt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 34 ++++++++++++++++++++++++-<br>
=A0include/linux/of_fdt.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A01 +<br>
=A011 files changed, 84 insertions(+), 78 deletions(-)<br>
<br>
diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c b/arch/powerpc/plat=
forms/40x/ppc40x_simple.c<br>
index 546bbc2..2521d93 100644<br>
--- a/arch/powerpc/platforms/40x/ppc40x_simple.c<br>
+++ b/arch/powerpc/platforms/40x/ppc40x_simple.c<br>
@@ -50,7 +50,7 @@ machine_device_initcall(ppc40x_simple, ppc40x_device_prob=
e);<br>
 =A0* Again, if your board needs to do things differently then create a<br>
 =A0* board.c file for it rather than adding it to this list.<br>
 =A0*/<br>
-static char *board[] __initdata =3D {<br>
+static const char *board[] __initdata =3D {<br>
 =A0 =A0 =A0 =A0&quot;amcc,acadia&quot;,<br>
 =A0 =A0 =A0 =A0&quot;amcc,haleakala&quot;,<br>
 =A0 =A0 =A0 =A0&quot;amcc,kilauea&quot;,<br>
@@ -60,14 +60,9 @@ static char *board[] __initdata =3D {<br>
<br>
=A0static int __init ppc40x_probe(void)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long root =3D of_get_flat_dt_root();<br>
- =A0 =A0 =A0 int i =3D 0;<br>
-<br>
- =A0 =A0 =A0 for (i =3D 0; i &lt; ARRAY_SIZE(board); i++) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_flat_dt_is_compatible(root, board[i]))=
 {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc_pci_set_flags(PPC_PCI_REA=
SSIGN_ALL_RSRC);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 if (of_flat_dt_match(of_get_flat_dt_root(), board)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc_pci_set_flags(PPC_PCI_REASSIGN_ALL_RSRC);=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
 =A0 =A0 =A0 =A0return 0;<br>
diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc/p=
latforms/512x/mpc5121_generic.c<br>
index e487eb0..926731f 100644<br>
--- a/arch/powerpc/platforms/512x/mpc5121_generic.c<br>
+++ b/arch/powerpc/platforms/512x/mpc5121_generic.c<br>
@@ -26,7 +26,7 @@<br>
=A0/*<br>
 =A0* list of supported boards<br>
 =A0*/<br>
-static char *board[] __initdata =3D {<br>
+static const char *board[] __initdata =3D {<br>
 =A0 =A0 =A0 =A0&quot;prt,prtlvt&quot;,<br>
 =A0 =A0 =A0 =A0NULL<br>
=A0};<br>
@@ -36,16 +36,7 @@ static char *board[] __initdata =3D {<br>
 =A0*/<br>
=A0static int __init mpc5121_generic_probe(void)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long node =3D of_get_flat_dt_root();<br>
- =A0 =A0 =A0 int i =3D 0;<br>
-<br>
- =A0 =A0 =A0 while (board[i]) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_flat_dt_is_compatible(node, board[i]))=
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;<br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 return board[i] !=3D NULL;<br>
+ =A0 =A0 =A0 return of_flat_dt_match(of_get_flat_dt_root(), board);<br>
=A0}<br>
<br>
=A0define_machine(mpc5121_generic) {<br>
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platform=
s/52xx/lite5200.c<br>
index de55bc0..01ffa64 100644<br>
--- a/arch/powerpc/platforms/52xx/lite5200.c<br>
+++ b/arch/powerpc/platforms/52xx/lite5200.c<br>
@@ -172,20 +172,18 @@ static void __init lite5200_setup_arch(void)<br>
 =A0 =A0 =A0 =A0mpc52xx_setup_pci();<br>
=A0}<br>
<br>
+static const char *board[] __initdata =3D {<br>
+ =A0 =A0 =A0 &quot;fsl,lite5200&quot;,<br>
+ =A0 =A0 =A0 &quot;fsl,lite5200b&quot;,<br>
+ =A0 =A0 =A0 NULL,<br>
+};<br>
+<br>
=A0/*<br>
 =A0* Called very early, MMU is off, device-tree isn&#39;t unflattened<br>
 =A0*/<br>
=A0static int __init lite5200_probe(void)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long node =3D of_get_flat_dt_root();<br>
- =A0 =A0 =A0 const char *model =3D of_get_flat_dt_prop(node, &quot;model&q=
uot;, NULL);<br>
-<br>
- =A0 =A0 =A0 if (!of_flat_dt_is_compatible(node, &quot;fsl,lite5200&quot;)=
 &amp;&amp;<br>
- =A0 =A0 =A0 =A0 =A0 !of_flat_dt_is_compatible(node, &quot;fsl,lite5200b&q=
uot;))<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
- =A0 =A0 =A0 pr_debug(&quot;%s board found\n&quot;, model ? model : &quot;=
unknown&quot;);<br>
-<br>
- =A0 =A0 =A0 return 1;<br>
+ =A0 =A0 =A0 return of_flat_dt_match(of_get_flat_dt_root(), board);<br>
=A0}<br>
<br>
=A0define_machine(lite5200) {<br>
diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platfor=
ms/52xx/media5200.c<br>
index 0bac3a3..2c7780c 100644<br>
--- a/arch/powerpc/platforms/52xx/media5200.c<br>
+++ b/arch/powerpc/platforms/52xx/media5200.c<br>
@@ -239,7 +239,7 @@ static void __init media5200_setup_arch(void)<br>
=A0}<br>
<br>
=A0/* list of the supported boards */<br>
-static char *board[] __initdata =3D {<br>
+static const char *board[] __initdata =3D {<br>
 =A0 =A0 =A0 =A0&quot;fsl,media5200&quot;,<br>
 =A0 =A0 =A0 =A0NULL<br>
=A0};<br>
@@ -249,16 +249,7 @@ static char *board[] __initdata =3D {<br>
 =A0*/<br>
=A0static int __init media5200_probe(void)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long node =3D of_get_flat_dt_root();<br>
- =A0 =A0 =A0 int i =3D 0;<br>
-<br>
- =A0 =A0 =A0 while (board[i]) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_flat_dt_is_compatible(node, board[i]))=
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;<br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 return (board[i] !=3D NULL);<br>
+ =A0 =A0 =A0 return of_flat_dt_match(of_get_flat_dt_root(), board);<br>
=A0}<br>
<br>
=A0define_machine(media5200_platform) {<br>
diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/pl=
atforms/52xx/mpc5200_simple.c<br>
index d45be5b..e36d6e2 100644<br>
--- a/arch/powerpc/platforms/52xx/mpc5200_simple.c<br>
+++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c<br>
@@ -49,7 +49,7 @@ static void __init mpc5200_simple_setup_arch(void)<br>
=A0}<br>
<br>
=A0/* list of the supported boards */<br>
-static char *board[] __initdata =3D {<br>
+static const char *board[] __initdata =3D {<br>
 =A0 =A0 =A0 =A0&quot;intercontrol,digsy-mtc&quot;,<br>
 =A0 =A0 =A0 =A0&quot;manroland,mucmc52&quot;,<br>
 =A0 =A0 =A0 =A0&quot;manroland,uc101&quot;,<br>
@@ -66,16 +66,7 @@ static char *board[] __initdata =3D {<br>
 =A0*/<br>
=A0static int __init mpc5200_simple_probe(void)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long node =3D of_get_flat_dt_root();<br>
- =A0 =A0 =A0 int i =3D 0;<br>
-<br>
- =A0 =A0 =A0 while (board[i]) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_flat_dt_is_compatible(node, board[i]))=
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;<br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 return (board[i] !=3D NULL);<br>
+ =A0 =A0 =A0 return of_flat_dt_match(of_get_flat_dt_root(), board);<br>
=A0}<br>
<br>
=A0define_machine(mpc5200_simple_platform) {<br>
diff --git a/arch/powerpc/platforms/83xx/mpc830x_rdb.c b/arch/powerpc/platf=
orms/83xx/mpc830x_rdb.c<br>
index 846831d..661d354 100644<br>
--- a/arch/powerpc/platforms/83xx/mpc830x_rdb.c<br>
+++ b/arch/powerpc/platforms/83xx/mpc830x_rdb.c<br>
@@ -57,16 +57,19 @@ static void __init mpc830x_rdb_init_IRQ(void)<br>
 =A0 =A0 =A0 =A0ipic_set_default_priority();<br>
=A0}<br>
<br>
+struct const char *board[] __initdata =3D {<br>
+ =A0 =A0 =A0 &quot;MPC8308RDB&quot;,<br>
+ =A0 =A0 =A0 &quot;fsl,mpc8308rdb&quot;,<br>
+ =A0 =A0 =A0 &quot;denx,mpc8308_p1m&quot;,<br>
+ =A0 =A0 =A0 NULL<br>
+}<br>
+<br>
=A0/*<br>
 =A0* Called very early, MMU is off, device-tree isn&#39;t unflattened<br>
 =A0*/<br>
=A0static int __init mpc830x_rdb_probe(void)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long root =3D of_get_flat_dt_root();<br>
-<br>
- =A0 =A0 =A0 return of_flat_dt_is_compatible(root, &quot;MPC8308RDB&quot;)=
 ||<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0of_flat_dt_is_compatible(root, &quot;fsl,mpc83=
08rdb&quot;) ||<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0of_flat_dt_is_compatible(root, &quot;denx,mpc8=
308_p1m&quot;);<br>
+ =A0 =A0 =A0 return of_flat_dt_match(of_get_flat_dt_root(), board);<br>
=A0}<br>
<br>
=A0static struct of_device_id __initdata of_bus_ids[] =3D {<br>
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platf=
orms/83xx/mpc831x_rdb.c<br>
index ae525e4..b54cd73 100644<br>
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c<br>
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c<br>
@@ -60,15 +60,18 @@ static void __init mpc831x_rdb_init_IRQ(void)<br>
 =A0 =A0 =A0 =A0ipic_set_default_priority();<br>
=A0}<br>
<br>
+struct const char *board[] __initdata =3D {<br>
+ =A0 =A0 =A0 &quot;MPC8313ERDB&quot;,<br>
+ =A0 =A0 =A0 &quot;fsl,mpc8315erdb&quot;,<br>
+ =A0 =A0 =A0 NULL<br>
+}<br>
+<br>
=A0/*<br>
 =A0* Called very early, MMU is off, device-tree isn&#39;t unflattened<br>
 =A0*/<br>
=A0static int __init mpc831x_rdb_probe(void)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long root =3D of_get_flat_dt_root();<br>
-<br>
- =A0 =A0 =A0 return of_flat_dt_is_compatible(root, &quot;MPC8313ERDB&quot;=
) ||<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0of_flat_dt_is_compatible(root, &quot;fsl,mpc83=
15erdb&quot;);<br>
+ =A0 =A0 =A0 return of_flat_dt_match(of_get_flat_dt_root(), board);<br>
=A0}<br>
<br>
=A0static struct of_device_id __initdata of_bus_ids[] =3D {<br>
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platf=
orms/83xx/mpc837x_rdb.c<br>
index 910caa6..7bafbf2 100644<br>
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c<br>
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c<br>
@@ -101,17 +101,20 @@ static void __init mpc837x_rdb_init_IRQ(void)<br>
 =A0 =A0 =A0 =A0ipic_set_default_priority();<br>
=A0}<br>
<br>
+static const char *board[] __initdata =3D {<br>
+ =A0 =A0 =A0 &quot;fsl,mpc8377rdb&quot;,<br>
+ =A0 =A0 =A0 &quot;fsl,mpc8378rdb&quot;,<br>
+ =A0 =A0 =A0 &quot;fsl,mpc8379rdb&quot;,<br>
+ =A0 =A0 =A0 &quot;fsl,mpc8377wlan&quot;,<br>
+ =A0 =A0 =A0 NULL<br>
+};<br>
+<br>
=A0/*<br>
 =A0* Called very early, MMU is off, device-tree isn&#39;t unflattened<br>
 =A0*/<br>
=A0static int __init mpc837x_rdb_probe(void)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long root =3D of_get_flat_dt_root();<br>
-<br>
- =A0 =A0 =A0 return of_flat_dt_is_compatible(root, &quot;fsl,mpc8377rdb&qu=
ot;) ||<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0of_flat_dt_is_compatible(root, &quot;fsl,mpc83=
78rdb&quot;) ||<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0of_flat_dt_is_compatible(root, &quot;fsl,mpc83=
79rdb&quot;) ||<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0of_flat_dt_is_compatible(root, &quot;fsl,mpc83=
77wlan&quot;);<br>
+ =A0 =A0 =A0 return of_flat_dt_match(of_get_flat_dt_root(), board);<br>
=A0}<br>
<br>
=A0define_machine(mpc837x_rdb) {<br>
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms=
/85xx/tqm85xx.c<br>
index 8f29bbc..5e847d0 100644<br>
--- a/arch/powerpc/platforms/85xx/tqm85xx.c<br>
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c<br>
@@ -186,21 +186,21 @@ static int __init declare_of_platform_devices(void)<b=
r>
=A0}<br>
=A0machine_device_initcall(tqm85xx, declare_of_platform_devices);<br>
<br>
+static const char *board[] __initdata =3D {<br>
+ =A0 =A0 =A0 &quot;tqc,tqm8540&quot;,<br>
+ =A0 =A0 =A0 &quot;tqc,tqm8541&quot;,<br>
+ =A0 =A0 =A0 &quot;tqc,tqm8548&quot;,<br>
+ =A0 =A0 =A0 &quot;tqc,tqm8555&quot;,<br>
+ =A0 =A0 =A0 &quot;tqc,tqm8560&quot;,<br>
+ =A0 =A0 =A0 NULL<br>
+};<br>
+<br>
=A0/*<br>
 =A0* Called very early, device-tree isn&#39;t unflattened<br>
 =A0*/<br>
=A0static int __init tqm85xx_probe(void)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long root =3D of_get_flat_dt_root();<br>
-<br>
- =A0 =A0 =A0 if ((of_flat_dt_is_compatible(root, &quot;tqc,tqm8540&quot;))=
 ||<br>
- =A0 =A0 =A0 =A0 =A0 (of_flat_dt_is_compatible(root, &quot;tqc,tqm8541&quo=
t;)) ||<br>
- =A0 =A0 =A0 =A0 =A0 (of_flat_dt_is_compatible(root, &quot;tqc,tqm8548&quo=
t;)) ||<br>
- =A0 =A0 =A0 =A0 =A0 (of_flat_dt_is_compatible(root, &quot;tqc,tqm8555&quo=
t;)) ||<br>
- =A0 =A0 =A0 =A0 =A0 (of_flat_dt_is_compatible(root, &quot;tqc,tqm8560&quo=
t;)))<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;<br>
-<br>
- =A0 =A0 =A0 return 0;<br>
+ =A0 =A0 =A0 return of_flat_dt_match(of_get_flat_dt_root(), board);<br>
=A0}<br>
<br>
=A0define_machine(tqm85xx) {<br>
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c<br>
index 8a90ee4..5a3db04 100644<br>
--- a/drivers/of/fdt.c<br>
+++ b/drivers/of/fdt.c<br>
@@ -78,19 +78,23 @@ void *of_fdt_get_property(struct boot_param_header *blo=
b,<br>
 =A0* @blob: A device tree blob<br>
 =A0* @node: node to test<br>
 =A0* @compat: compatible string to compare with compatible list.<br>
+ *<br>
+ * On match, returns a non-zero value with smaller values returned for mor=
e<br>
+ * specific compatible values.<br>
 =A0*/<br>
=A0int of_fdt_is_compatible(struct boot_param_header *blob,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long node, const char =
*compat)<br>
=A0{<br>
 =A0 =A0 =A0 =A0const char *cp;<br>
- =A0 =A0 =A0 unsigned long cplen, l;<br>
+ =A0 =A0 =A0 unsigned long cplen, l, score =3D 0;<br>
<br>
 =A0 =A0 =A0 =A0cp =3D of_fdt_get_property(blob, node, &quot;compatible&quo=
t;, &amp;cplen);<br>
 =A0 =A0 =A0 =A0if (cp =3D=3D NULL)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;<br>
 =A0 =A0 =A0 =A0while (cplen &gt; 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 score++;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (of_compat_cmp(cp, compat, strlen(compat=
)) =3D=3D 0)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return score;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l =3D strlen(cp) + 1;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cp +=3D l;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cplen -=3D l;<br>
@@ -99,6 +103,24 @@ int of_fdt_is_compatible(struct boot_param_header *blob=
,<br>
 =A0 =A0 =A0 =A0return 0;<br>
=A0}<br>
<br>
+/**<br>
+ * of_flat_dt_match - Return true if node matches a list of compatible val=
ues<br></blockquote><div><br></div><div>copy-paste error.</div><div>=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex;">

+ */<br>
+int of_fdt_match(struct boot_param_header *blob, unsigned long node,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char **compat)<br>
+{<br>
+ =A0 =A0 =A0 unsigned int tmp, score =3D 0;<br>
+<br>
+ =A0 =A0 =A0 while (*compat) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D of_fdt_is_compatible(blob, node, *com=
pat);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tmp &amp;&amp; (score =3D=3D 0 || (tmp &l=
t; score)))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 score =3D tmp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 compat++;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return score;<br>
+}<br>
+<br>
=A0static void *unflatten_dt_alloc(unsigned long *mem, unsigned long size,<=
br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 unsigned long align)<br>
=A0{<br>
@@ -511,6 +533,14 @@ int __init of_flat_dt_is_compatible(unsigned long node=
, const char *compat)<br>
 =A0 =A0 =A0 =A0return of_fdt_is_compatible(initial_boot_params, node, comp=
at);<br>
=A0}<br>
<br>
+/**<br>
+ * of_flat_dt_match - Return true if node matches a list of compatible val=
ues<br>
+ */<br>
+int __init of_flat_dt_match(unsigned long node, const char **compat)<br>
+{<br>
+ =A0 =A0 =A0 return of_fdt_match(initial_boot_params, node, compat);<br>
+}<br>
+<br>
=A0#ifdef CONFIG_BLK_DEV_INITRD<br>
=A0/**<br>
 =A0* early_init_dt_check_for_initrd - Decode initrd location from flat tre=
e<br>
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h<br>
index 9ce5dfd..fb327f3 100644<br>
--- a/include/linux/of_fdt.h<br>
+++ b/include/linux/of_fdt.h<br>
@@ -84,6 +84,7 @@ extern int of_scan_flat_dt(int (*it)(unsigned long node, =
const char *uname,<br>
=A0extern void *of_get_flat_dt_prop(unsigned long node, const char *name,<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned l=
ong *size);<br>
=A0extern int of_flat_dt_is_compatible(unsigned long node, const char *name=
);<br>
+extern int of_flat_dt_match(unsigned long node, const char **matches);<br>=
</blockquote><div><br></div><div>Maybe export of_fdt_match, too?</div><div>=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex;">

=A0extern unsigned long of_get_flat_dt_root(void);<br>
<br>
=A0extern int early_init_dt_scan_chosen(unsigned long node, const char *una=
me,<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
</blockquote></div><br>

--90e6ba53a55e89877c0498b6e1eb--
