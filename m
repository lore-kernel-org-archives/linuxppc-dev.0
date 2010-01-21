Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f204.google.com (mail-iw0-f204.google.com
	[209.85.223.204]) by ozlabs.org (Postfix) with ESMTP id 75BC8B7CBB
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2010 04:12:39 +1100 (EST)
Received: by iwn42 with SMTP id 42so178497iwn.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 09:12:38 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1263932653-3634-5-git-send-email-agust@denx.de>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
	<1263932653-3634-5-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 21 Jan 2010 10:12:17 -0700
Message-ID: <fa686aa41001210912r5fd2a5a4g8a072e0c41ee4107@mail.gmail.com>
Subject: Re: [PATCH 04/11] i2c-mpc: Add MPC5121 I2C bus support
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: wd@denx.de, dzu@denx.de, linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 19, 2010 at 1:24 PM, Anatolij Gustschin <agust@denx.de> wrote:
> From: Piotr Ziecik <kosmo@semihalf.com>
>
> =A0 =A0- Update Kconfig for i2c-mpc driver.
> =A0 =A0- Enable I2C interrupts on MPC5121.
>
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index f627001..84eeb25 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -540,6 +540,29 @@ static int __devinit fsl_i2c_probe(struct of_device =
*op,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (of_device_is_compatible(op->node, "fsl,mpc5121-i2c")) {

Rather than doing stuff like this with explicit compatible checks in
the probe hook, consider using the .data pointer in the of match
table.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
