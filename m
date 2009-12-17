Return-Path: <sylvain.lamontagne@gmail.com>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.144])
	by ozlabs.org (Postfix) with ESMTP id DEA3FB6F04
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Dec 2009 02:57:03 +1100 (EST)
Received: by qw-out-1920.google.com with SMTP id 4so385408qwk.50
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Dec 2009 07:57:01 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 17 Dec 2009 10:57:01 -0500
Message-ID: <3e45db430912170757v20209609y61498e287928d47b@mail.gmail.com>
Subject: Need advice on changing MPC5200B UART prescaler
From: Sylvain Lamontagne <sylvain.lamontagne@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd6ca2c77435b047aeeac83
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd6ca2c77435b047aeeac83
Content-Type: text/plain; charset=UTF-8

Hi all,

I would like to be able to set a baud rate of 460800 for modem that we are
testing. With the actual prescaler of 32 and a IPB frequency of 84MHz
I got a 5.1% error (437500) vs a 0.9% error (456522) if I could use the
prescaler of 4. See MPC5200B user manual page 15-46 for the calculation
formula and page 15-12 for the CSR description.

Currently the code for the kernel we are using here, (2.6.29.2) seams not to
take a prescaler of 4 into account.
Line 249 of mpc52xx_uart.c
http://lxr.linux.no/linux+v2.6.29.2/drivers/serial/mpc52xx_uart.c#L249

/* Search for bus-frequency property in this node or a parent */
static unsigned long mpc52xx_getuartclk(void *p)
{
        /*
         * 5200 UARTs have a / 32 prescaler
         * but the generic serial code assumes 16
         * so return ipb freq / 2
         */
        return mpc52xx_find_ipb_freq(p) / 2;
}

How could I make it use the prescaler of 4 without breaking anything that we
currently have working ?
I doubt that simply doing  return mpc52xx_find_ipb_freq(p) / 4 would do the
trick ...

--000e0cd6ca2c77435b047aeeac83
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,=C2=A0<div><br></div><div>I would like to be able to set a baud rate=
 of 460800 for modem that we are testing. With the actual prescaler of 32 a=
nd a IPB frequency of 84MHz</div><div>I got a 5.1% error (437500) vs a 0.9%=
 error (456522) if I could use the prescaler of 4. See MPC5200B user manual=
 page 15-46 for the calculation formula and page 15-12 for the CSR descript=
ion.</div>
<div><br></div><div>Currently the code for the kernel we are using here, (2=
.6.29.2) seams not to take a prescaler of 4 into account.</div><div><div>Li=
ne 249 of mpc52xx_uart.c=C2=A0<a href=3D"http://lxr.linux.no/linux+v2.6.29.=
2/drivers/serial/mpc52xx_uart.c#L249">http://lxr.linux.no/linux+v2.6.29.2/d=
rivers/serial/mpc52xx_uart.c#L249</a></div>
<div><br></div><div>/* Search for bus-frequency property in this node or a =
parent */</div><div>static unsigned long mpc52xx_getuartclk(void *p)</div><=
div>{</div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0/*</div><div>=C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 * 5200 UARTs have a / 32 prescaler</div>
<div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 * but the generic serial code assume=
s 16</div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 * so return ipb freq / 2</=
div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 */</div><div>=C2=A0=C2=A0 =C2=A0=
 =C2=A0 =C2=A0return mpc52xx_find_ipb_freq(p) / 2;</div><div>}</div><div><b=
r></div><div>How could I make it use the prescaler of 4 without breaking an=
ything that we currently have working ?</div>
<div>I doubt that simply doing=C2=A0=C2=A0return mpc52xx_find_ipb_freq(p) /=
 4 would do the trick ...</div></div>

--000e0cd6ca2c77435b047aeeac83--
