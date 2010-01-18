Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f217.google.com (mail-gx0-f217.google.com
	[209.85.217.217]) by ozlabs.org (Postfix) with ESMTP id 4A011B7C31
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jan 2010 05:36:43 +1100 (EST)
Received: by gxk9 with SMTP id 9so4287541gxk.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jan 2010 10:36:41 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <3e45db430912170757v20209609y61498e287928d47b@mail.gmail.com>
References: <3e45db430912170757v20209609y61498e287928d47b@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 18 Jan 2010 11:36:21 -0700
Message-ID: <fa686aa41001181036v29e26330v8da6f56d603efa5e@mail.gmail.com>
Subject: Re: Need advice on changing MPC5200B UART prescaler
To: Sylvain Lamontagne <sylvain.lamontagne@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 17, 2009 at 8:57 AM, Sylvain Lamontagne
<sylvain.lamontagne@gmail.com> wrote:
> Hi all,
> I would like to be able to set a baud rate of 460800 for modem that we ar=
e
> testing. With the actual prescaler of 32 and a IPB frequency of 84MHz
> I got a 5.1% error (437500) vs a 0.9% error (456522) if I could use the
> prescaler of 4. See MPC5200B user manual page 15-46 for the calculation
> formula and page 15-12 for the CSR description.
> Currently the code for the kernel we are using here, (2.6.29.2) seams not=
 to
> take a prescaler of 4 into account.
> Line 249 of
> mpc52xx_uart.c=A0http://lxr.linux.no/linux+v2.6.29.2/drivers/serial/mpc52=
xx_uart.c#L249
> /* Search for bus-frequency property in this node or a parent */
> static unsigned long mpc52xx_getuartclk(void *p)
> {
> =A0=A0 =A0 =A0 =A0/*
> =A0=A0 =A0 =A0 =A0 * 5200 UARTs have a / 32 prescaler
> =A0=A0 =A0 =A0 =A0 * but the generic serial code assumes 16
> =A0=A0 =A0 =A0 =A0 * so return ipb freq / 2
> =A0=A0 =A0 =A0 =A0 */
> =A0=A0 =A0 =A0 =A0return mpc52xx_find_ipb_freq(p) / 2;
> }
> How could I make it use the prescaler of 4 without breaking anything that=
 we
> currently have working ?
> I doubt that simply doing=A0=A0return mpc52xx_find_ipb_freq(p) / 4 would =
do the
> trick ...

since 32 prescale is scaled to 16 by dividing by 2, then 4 would be
scaled to 16 by multiplying by 4.  Have you tried
mpc52xx_find_ipb_freq(p) * 4?  You'll need to add some method for the
uart driver to either set the prescaler at boot time or to figure out
on its own which prescaler would be best.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
