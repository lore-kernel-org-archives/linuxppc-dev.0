Return-Path: <jaka@activetools.si>
From: Jaka =?iso-8859-2?Q?Mo=E8nik?= <jaka@activetools.si>
To: Embedded PPC Linux Mailing List <Linuxppc-embedded@ozlabs.org>
In-Reply-To: <1109842283.29455.9.camel@x.at.lan>
References: <1109842283.29455.9.camel@x.at.lan>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Mar 2005 16:12:29 +0100
Message-Id: <1109862749.29455.49.camel@x.at.lan>
Mime-Version: 1.0
Subject: Re: BCM5421 PHY on TSEC on MPC8560
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-03-03 at 10:31 +0100, Jaka Mo=C4=8Dnik wrote:
> I have a BroadCom BCM5421 PHY attached to MPC8560 TSEC. I have added
> support for its aux status register and its initialization (via another
> phy_info entry) to gianfar_phy.c and configured the kernel with Gianfar
> driver without NAPI support. It seems that the link is established OK
> (at least the switch that the board is connected to suggests so) and the
> gfar_transmit() gets called, signalling that the buffers are being sent.
> however, no packets seem to be thrown on the wire (nothing ever gets to
> the other side).
never mind: the board does not support the "phy interrupt", so the
driver has to use timer to poll for link changes in order to call adjust
link. removing the unfortunate flag from device definition for my board
was all it took. now it's time to make it 1000BT aware;)

regards,
	jaKa

--=20

w3: http://fish.homeunix.org/people/jaka
email: jaka@activetools.si
