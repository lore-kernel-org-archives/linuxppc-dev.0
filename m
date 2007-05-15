Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 66BD2DDED9
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 23:24:56 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l4FDLCw8013307
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 09:21:12 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4FDOlmo207886
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 07:24:47 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4FDOkDJ012472
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 07:24:47 -0600
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] powerpc: Fix IO space on PCI busses created from
	of_platform
Date: Tue, 15 May 2007 15:24:39 +0200
References: <20070515041656.41CE7DDECA@ozlabs.org>
In-Reply-To: <20070515041656.41CE7DDECA@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705151524.39805.arnd.bergmann@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 15 May 2007, Benjamin Herrenschmidt wrote:
> +=A0=A0=A0=A0=A0=A0=A0/* Setup IO space. We use the non-dynamic version o=
f that code here,
> +=A0=A0=A0=A0=A0=A0=A0 * which doesn't quite support unplugging. Next ker=
nel release will
> +=A0=A0=A0=A0=A0=A0=A0 * have a better fix for this.
> +=A0=A0=A0=A0=A0=A0=A0 * Note also that we don't do ISA, this will also b=
e fixed with a
> +=A0=A0=A0=A0=A0=A0=A0 * more massive rework.
> =A0=A0=A0=A0=A0=A0=A0=A0 */
> -=A0=A0=A0=A0=A0=A0=A0pci_setup_phb_io_dynamic(phb, 0);
> +=A0=A0=A0=A0=A0=A0=A0pci_setup_phb_io(phb, 0);
> =A0

I think this still needs some logic to make sure we have at least one
primary PHB in the system. On a board that has all phbs probed by
of_platform code, we never set the pci_io_base variable.

The easiest solution might be to statically initialize pci_io_base
to PHBS_IO_BASE. If it is different from that, we are already broken
because we would get _negative_ I/O port numbers for PHBs below
pci_io_base.

	Arnd <><
