Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f172.google.com (mail-iw0-f172.google.com
	[209.85.223.172]) by ozlabs.org (Postfix) with ESMTP id 11340B7D26
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 03:13:24 +1100 (EST)
Received: by iwn2 with SMTP id 2so4757456iwn.10
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 08:13:23 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1265096864-3506-2-git-send-email-agust@denx.de>
References: <1265096864-3506-1-git-send-email-agust@denx.de>
	<1265096864-3506-2-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 09:13:03 -0700
Message-ID: <fa686aa41002090813j525cdd4dm8950232a5efefd13@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: mpc52xx_uart: re-enable mpc5121 PSC UART
	support
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 2, 2010 at 12:47 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Currently the support for MPC5121 PSC UART in the mpc52xx_uart
> driver is broken (only console pre-initialized by the bootloader
> works). Re-enable it now by providing MPC5121 specific ops
> for PSCx clock activation, FIFO controller init/uninit and
> MPC5121 PSC FIFO shared interrupt handling functions.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> This patch has been tested using 5200/5121 multiplatform kernel
> on tqm5200 and mpc5121ads boards (mpc52xx_uart staticaly linked
> and as a driver module).
>
> @@ -1164,7 +1378,8 @@ mpc52xx_uart_of_probe(struct of_device *op, const s=
truct of_device_id *match)
> =A0 =A0 =A0 =A0/* Add the port to the uart sub-system */
> =A0 =A0 =A0 =A0ret =3D uart_add_one_port(&mpc52xx_uart_driver, port);
> =A0 =A0 =A0 =A0if (ret) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_dispose_mapping(port->irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(port->irqflags & IRQF_SHARED))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_dispose_mapping(port->i=
rq);

I'd just drop the irq_dispose_mapping() entirely.  It doesn't really
cost anything to leave the mapping around when unloading the driver.

Otherwise, looks good to me.  You can add my acked-by in the next spin.

g.
