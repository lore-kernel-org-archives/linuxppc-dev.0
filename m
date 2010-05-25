Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 214ACB7D1B
	for <linuxppc-dev@ozlabs.org>; Wed, 26 May 2010 06:22:11 +1000 (EST)
Received: by gyf2 with SMTP id 2so2174813gyf.15
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 13:22:10 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100525080834.29149.70967.stgit@ES-J7S4D2J.amer.consind.ge.com>
References: <20100525080834.29149.70967.stgit@ES-J7S4D2J.amer.consind.ge.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 25 May 2010 14:21:50 -0600
Message-ID: <AANLkTikve-ZghgpVl3cyjjgWAch-oCJ0EiYK2127f5gS@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc: Add i8042 keyboard and mouse irq parsing
To: Martyn Welch <martyn.welch@ge.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 25, 2010 at 2:09 AM, Martyn Welch <martyn.welch@ge.com> wrote:
> Currently the irqs for the i8042, which historically provides keyboard an=
d
> mouse (aux) support, is hardwired in the driver rather than parsing the
> dts. =A0This patch modifies the powerpc legacy IO code to attempt to pars=
e
> the device tree for this information, failing back to the hardcoded value=
s
> if it fails.
>
> Signed-off-by: Martyn Welch <martyn.welch@ge.com>
> ---
>
> v2: This patch no longer requires the DTS files to be modified, reading t=
he
> interrupts from the current location as suggested by Grant.
>
> v3: Code compacted as suggested by Grant.
>
> =A0arch/powerpc/kernel/setup-common.c | =A0 13 +++++++++++++
> =A0drivers/input/serio/i8042-io.h =A0 =A0 | =A0 =A05 +++++
> =A02 files changed, 18 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/set=
up-common.c
> index 48f0a00..3d169bb 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -94,6 +94,10 @@ struct screen_info screen_info =3D {
> =A0 =A0 =A0 =A0.orig_video_points =3D 16
> =A0};
>
> +/* Variables required to store legacy IO irq routing */
> +int of_i8042_kbd_irq;
> +int of_i8042_aux_irq;
> +
> =A0#ifdef __DO_IRQ_CANON
> =A0/* XXX should go elsewhere eventually */
> =A0int ppc_do_canonicalize_irqs;
> @@ -567,6 +571,15 @@ int check_legacy_ioport(unsigned long base_port)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0np =3D of_find_compatible_=
node(NULL, NULL, "pnpPNP,f03");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (np) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parent =3D of_get_parent(n=
p);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_i8042_kbd_irq =3D irq_of=
_parse_and_map(parent, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!of_i8042_kbd_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_i8042_kb=
d_irq =3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_i8042_aux_irq =3D irq_of=
_parse_and_map(parent, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!of_i8042_aux_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_i8042_au=
x_irq =3D 12;
> +

The patch looks okay to me.

BTW, where is the i8042 binding documented?  Ben, is this location of
the kbd/mouse irq historical, or is it just something that we happened
to get when the .dts files were first created?  Having the irq
specified directly in the kbd or aux nodes would make a lot more
sense, and if this isn't something already nailed down, then it
probably does make sense to move the irq specification, fall back to
the parent node to still support older trees, and with the hard coded
irq numbers as the last resort.

Cheers,
g.
