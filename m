Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 31E61B6F29
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 05:22:52 +1100 (EST)
Received: by yxe8 with SMTP id 8so3489725yxe.17
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 10:22:51 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091113111019.GA3563@pengutronix.de>
References: <1257844329-20687-1-git-send-email-l.fu@pengutronix.de>
	<1258108877-25435-1-git-send-email-l.fu@pengutronix.de>
	<1258108877-25435-2-git-send-email-l.fu@pengutronix.de>
	<1258108877-25435-3-git-send-email-l.fu@pengutronix.de>
	<1258108877-25435-4-git-send-email-l.fu@pengutronix.de>
	<20091113111019.GA3563@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 13 Nov 2009 11:22:31 -0700
Message-ID: <fa686aa40911131022yc84ab95wd9c67ab5d03c5ecb@mail.gmail.com>
Subject: Re: [PATCH 3/3] [V2] mpc52xx_spi: add gpio chipselect
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, Luotao Fu <l.fu@pengutronix.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 13, 2009 at 4:10 AM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
> On Fri, Nov 13, 2009 at 11:41:17AM +0100, Luotao Fu wrote:
>> This one enables the mpc52xx_spi driver for usage of user defined gpio l=
ines
>> as chipselect. This way we can control some more spi devices than only o=
ne
>>
>> V2 Changes:
>> * preinitialize the gpio as output in probe function and call gpio_set_v=
alue in
>> =A0 the chip select function instead of calling direction_output every t=
ime.
>> * initialize the gpio line with output high, since we don't support CS_H=
IGH
>> =A0 in the driver currently any way. change gpio value setting to defaul=
t active
>> =A0 low in chip select call.
>> * free the gpio array while error or removing.
>>
>> Signed-off-by: Luotao Fu <l.fu@pengutronix.de>

>> @@ -477,6 +520,12 @@ static int __devinit mpc52xx_spi_probe(struct of_de=
vice *op,
>> =A0 err_register:
>> =A0 =A0 =A0 dev_err(&ms->master->dev, "initialization failed\n");
>> =A0 =A0 =A0 spi_master_put(master);
>> + err_gpio:
>> + =A0 =A0 while (i-- > 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(ms->gpio_cs[i]);
>> +
>> + =A0 =A0 if (ms->gpio_cs !=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(ms->gpio_cs);
>
> kfree() is NULL aware, so no if needed.

Not dangerous though.  No need to respin just for this.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
