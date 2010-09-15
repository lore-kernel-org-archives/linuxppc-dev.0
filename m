Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C3716B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 01:31:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 09/10] RapidIO: Add support for IDT CPS Gen2 switches
Date: Wed, 15 Sep 2010 08:30:57 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E5520130321F@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <20100914152049.8d42783f.akpm@linux-foundation.org>
References: <1284476363-1677-1-git-send-email-alexandre.bounine@idt.com><1284476363-1677-10-git-send-email-alexandre.bounine@idt.com>
	<20100914152049.8d42783f.akpm@linux-foundation.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Andrew Morton" <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton <akpm@linux-foundation.org> wrote:

> The handling of `table' is strange.  One would expect the caller of
> this function to provide the correct table index, and for the caller
to
> increment that index at an appropriate time.

Handling of the 'table' parameter is hardware-dependent.
RIO switches (at least all that I know) have a per-port routing tables
(RT)
which can be configured independently. The 'table' parameter is expected
to match
to the port number (or broadcast if GLOBAL).
The route set/get routines in this file use the standard route setting
registers
defined by RapidIO spec, but switches have internal mapping into an
individual
port RT or broadcast capability into all port RTs.
Unfortunately, this HW design uses index 0 as a broadcast option that
offsets
per-port RT numbering by +1 (port 0 =3D=3D table index 1, etc.).   =20

> So I take a look around but cannot find any means by which
> ->add_entry() is called with anything other than RIO_GLOBAL_TABLE.
> Maybe I missed something.  Is this all dead code?

The current RIO enumeration uses only the global routing table concept.
In the past, I had a temptation to remove the 'table' parameter and make
RT settings simpler. But now I see scenarios when per-port routing
tables=20
may be configured by usermode apps. This capability may be implemented=20
through sysfs attributes (probably I have to add them to make standard).
Example: system that uses dual-port endpoints which can be enumerated by
the host through one RIO port (management) and have individual routes
configured for the second port (data path).
