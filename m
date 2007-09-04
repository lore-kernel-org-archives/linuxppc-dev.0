Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 1/2] PS3: Clear SPU Class 0 interrupts in handler
Date: Wed, 5 Sep 2007 00:50:30 +0200
References: <46DD4777.8050402@am.sony.com>
In-Reply-To: <46DD4777.8050402@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200709050050.30968.arnd@arndb.de>
Cc: "Noguchi, Masato" <Masato.Noguchi@jp.sony.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 04 September 2007, Geoff Levand wrote:
> From: Masato Noguchi <Masato.Noguchi@jp.sony.com>
>=20
> Fix a bug that causes the PS3 to hang on the SPU Class 0 interrupt.
>=20
> The Cell BE Architecture spec states that the SPU MFC Class 0 interrupt
> is delivered as a pulse. =C2=A0The current spu interrupt handler assumes =
this
> behavior and does not clear the interrupt status.
>=20
> The PS3 hypervisor visualizes all SPU interrupts as level, and on return
> from the interrupt handler the hypervisor will deliver a new virtual
> interrupt for any unmasked interrupts which for which the status has not
> been cleared. =C2=A0This fix clears the interrupt status in the interrupt
> handler.

Right, we have this one in the sdk3.0/2.6.22-arnd2 kernel since I pulled
in all of the ps3-linux tree, so it was already part of our testing,
and the explanation makes sense, so we should certainly have it
upstream.

Jeremy, please add this to your patch queue.

> Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
