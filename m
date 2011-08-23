Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C6C2AB6FAF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 23:02:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] RapidIO: Fix use of non-compatible registers
Date: Tue, 23 Aug 2011 05:55:35 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552020BFA25@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <20110822122807.5b558d65.akpm@linux-foundation.org>
References: <1311703646-3453-1-git-send-email-alexandre.bounine@idt.com>
	<20110822122807.5b558d65.akpm@linux-foundation.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Kim, Chul" <Chul.Kim@idt.com>, linux-kernel@vger.kernel.org,
	Thomas Moll <thomas.moll@sysgo.com>,
	linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 26 Jul 2011 14:07:26 -0400
> Alexandre Bounine <alexandre.bounine@idt.com> wrote:
>=20
> > Replace/remove use of RIO v.1.2 registers/bits that are not forward-
> compatible
> > with newer versions of RapidIO specification.
> >
> > RapidIO specification v. 1.3 removed Write Port CSR, Doorbell CSR,
> > Mailbox CSR and Mailbox and Doorbell bits of the PEF CAR.
> >
.....
> You did a cc:stable but provided no reason (that I can understand) for
> backporting the patch.  Please explain why the problem is sufficiently
> serious to warrant this action.

My reason for this is that use of removed (since RIO v.1.3) register
bits
affects users of currently available 1.3 and 2.x compliant devices who
may
use not so recent kernel versions.

Removing checks for unsupported bits makes corresponding routines
compatible
with all versions of RapidIO specification. Therefore, backporting makes
stable
kernel versions compliant with RIO v.1.3 and later as well.=20
