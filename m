Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8A188DDEC8
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 01:14:09 +1000 (EST)
Date: Thu, 7 Jun 2007 10:20:41 -0500
To: Timur Tabi <timur@freescale.com>
Subject: Re: MPC8349ea Random Device Generator driver
Message-ID: <20070607152041.GA2851@lixom.net>
References: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
	<46672DB4.80504@freescale.com> <20070606220913.GA27820@lixom.net>
	<46673009.6000109@freescale.com> <20070606222456.GA28225@lixom.net>
	<466735F3.7040504@freescale.com> <20070606235440.GA28400@lixom.net>
	<466814E7.3090101@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <466814E7.3090101@freescale.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, sl@powerlinux.fr,
	Philippe Lachenal <philippe.lachenal@hotmail.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 07, 2007 at 09:23:35AM -0500, Timur Tabi wrote:
> Olof Johansson wrote:
> >On Wed, Jun 06, 2007 at 05:32:19PM -0500, Timur Tabi wrote:
> >>Olof Johansson wrote:
> >>
> >>> - you can never assign a __le16 type to any other integer type or any 
> >>>   other bitwise type. You'd get a warnign about incompatible types. 
> >>>   Makes sense, no?
> >>Then why do the in_be functions return an unsigned int instead of a __be 
> >>type?  Isn't that effectively removing the endian-ness from the type?
> >
> >Because they read a big endian register and returns the contents in the
> >native byte order for the machine.
> 
> In other words, the in_le16() function exists so that we can "assign a 
> __le16 type to any other integer type or any other bitwise type."

No. in_le16 exists so you can read a little-endian 16 bit register on
a device, and store it to a regular 16-bit integer variable. It
has nothing to do with assignment.

__le16 is just a type with hints for the programmer: "Hey, this is a
16-bit variable, but we're storing it in little-endian format. So if you
need to use it as a native data type, you need to swap it by hand first",
and sparse is able to help you find places where you didn't.

If you use the accessors to read/write hardware (as you are supposed to
do), then you don't need special types in your structs, just make sure
you use the right accessors.

-Olof
