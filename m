Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1329383368-12122-9-git-send-email-grant.likely@secretlab.ca>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-9-git-send-email-grant.likely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 16 Feb 2012 06:23:50 -0700
Message-ID: <CACxGe6sKzDzxKUxs2ZVNpf07bzaJSsJ8m+3mdPkU+4mf3EajdQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/27] irq_domain: Move irq_domain code from powerpc to
 kernel/irq
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Milton Miller <miltonm@bga.com>, Rob Herring <rob.herring@calxeda.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 16, 2012 at 2:09 AM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> This patch only moves the code. =A0It doesn't make any changes, and the
> code is still only compiled for powerpc. =A0Follow-on patches will genera=
lize
> the code for other architectures.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Milton Miller <miltonm@bga.com>
> Tested-by: Olof Johansson <olof@lixom.net>
> ---
> +unsigned int irq_find_mapping(struct irq_domain *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_hw_number_t=
 hwirq)
> +{
> + =A0 =A0 =A0 unsigned int i;
> + =A0 =A0 =A0 unsigned int hint =3D hwirq % irq_virq_count;
> +
> + =A0 =A0 =A0 /* Look for default host if nececssary */
> + =A0 =A0 =A0 if (host =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D irq_default_host;
> + =A0 =A0 =A0 if (host =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NO_IRQ;
> +
> + =A0 =A0 =A0 /* legacy -> bail early */
> + =A0 =A0 =A0 if (host->revmap_type =3D=3D IRQ_DOMAIN_MAP_LEGACY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return hwirq;
> +
> + =A0 =A0 =A0 /* Slow path does a linear search of the map */
> + =A0 =A0 =A0 if (hint =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hint =3D 1;
> + =A0 =A0 =A0 i =3D hint;
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct irq_data *data =3D irq_get_irq_data(=
i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data && (data->domain =3D=3D host) && (=
data->hwirq =3D=3D hwirq))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i >=3D irq_virq_count)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i =3D 1

Typo on this line; missing semicolon.  Fixed in my tree now.

g.
