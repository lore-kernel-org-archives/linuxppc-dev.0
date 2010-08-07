Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) by ozlabs.org (Postfix) with ESMTP id B5385B6EDF
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Aug 2010 02:58:43 +1000 (EST)
Received: by ywi6 with SMTP id 6so5378216ywi.15
	for <linuxppc-dev@ozlabs.org>; Sat, 07 Aug 2010 09:58:42 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100807183932.4ee10757@wker>
References: <87iq4r5y4q.fsf@macbook.be.48ers.dk>
	<1281187711-10215-1-git-send-email-agust@denx.de>
	<AANLkTimopiF3MZfaAXOO1rJVTptP0HFWSTtmSviAcfT3@mail.gmail.com>
	<20100807183932.4ee10757@wker>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 7 Aug 2010 10:58:21 -0600
Message-ID: <AANLkTikwCBCARw7DRgwGNX5CXvtUrNzQ0YzBKRtWz_VD@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc8xxx_gpio.c: extend the driver to support
	mpc512x gpios
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 7, 2010 at 10:39 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Grant Likely <grant.likely@secretlab.ca> wrote:
>> > @@ -226,6 +272,9 @@ static struct irq_chip mpc8xxx_irq_chip =3D {
>> > =A0static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int vi=
rq,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_hw_=
number_t hw)
>> > =A0{
>> > + =A0 =A0 =A0 if (of_device_is_compatible(h->of_node, "fsl,mpc5121-gpi=
o"))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_irq_chip.set_type =3D mpc512x_ir=
q_set_type;
>> > +
>>
>> You can put the set type hook into the of_match_table data which you
>> will need for of_find_matching_node() (see below).
>
> How can I get this match table data reference in mpc8xxx_gpio_irq_map() ?

of_match_node() will return the matching entry in the table.

> Is it okay to set data field of struct device_node to the set type
> hook? I could do it in mpc8xxx_add_gpiochips() but I'm not sure whether
> the data field will be used for other purposes somewhere else.

You are safe to use the .data field.

g.
