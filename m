Return-Path: <runet@innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Fri, 22 Oct 2004 17:01:54 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DB95@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <Linuxppc-embedded@ozlabs.org>
Cc: 
Subject: RE: CPM2 uart early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> From: Tom Rini [mailto:trini@kernel.crashing.org]=20
> On Thu, Oct 21, 2004 at 04:57:56PM -0500, Rune Torgersen wrote:
> > BTW..
> > What are the device node numbers for ttyCPM[0..5] ?
>=20
> 204 42...45 (devices.txt in linuxppc-2.5, Pantelis ever=20
> figure out what to do about the device # conflict with the=20
> i.MX driver so we can push that small bit upstream ?)

Aparently not that simple.... I looked in the source, and it depends if=20
an 8250 stype serial port is defined or not...

#ifndef CONFIG_SERIAL_8250
#define SERIAL_CPM_MAJOR	TTY_MAJOR
#define SERIAL_CPM_MINOR	64
#else
#define SERIAL_CPM_MAJOR	204
#define SERIAL_CPM_MINOR	42
#endif

Urgh...
