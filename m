Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/22] powerpc: convert idle_loop to use hard_irq_disable()
Date: Tue, 21 Nov 2006 11:14:45 +0100
References: <20061120174454.067872000@arndb.de>
	<20061120180520.418063000@arndb.de>
	<1164070425.8073.40.camel@localhost.localdomain>
In-Reply-To: <1164070425.8073.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200611211114.46305.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 21 November 2006 01:53, Benjamin Herrenschmidt wrote:
> +
> +=A0=A0=A0=A0=A0=A0=A0/*
> +=A0=A0=A0=A0=A0=A0=A0 * We need to hard disable interrupts, but we also =
need to mark them
> +=A0=A0=A0=A0=A0=A0=A0 * hard disabled in the PACA so that the local_irq_=
enable() done by
> +=A0=A0=A0=A0=A0=A0=A0 * our caller upon return propertly hard enables.
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0hard_irq_disable();
> +=A0=A0=A0=A0=A0=A0=A0get_paca()->hard_enabled =3D 0;
> +

Yes, this looks good. Paul, please use this patch instead of mine.
Do we need to do the same thing for any of the other power_save functions?
IIRC, all new CPUs are supposed to use the same mechanism based on the
0x100 vector.

	Arnd <><
