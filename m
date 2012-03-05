Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD805B6FF8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 07:54:03 +1100 (EST)
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH] rapidio/tsi721: fix bug in inbound doorbell handler
Date: Mon, 5 Mar 2012 20:53:54 +0000
Message-ID: <8D983423E7EDF846BB3056827B8CC5D101019D@corpmail1.na.ads.idt.com>
References: <1330979585-29429-1-git-send-email-alexandre.bounine@idt.com>
 <20120305123714.0750129e.akpm@linux-foundation.org>
In-Reply-To: <20120305123714.0750129e.akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Kim, Chul" <Chul.Kim@idt.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, March 05, 2012 3:37 PM Andrew Morton wrote:
> Alexandre Bounine <alexandre.bounine@idt.com> wrote:
>=20
> > Fixes queue wrapping bug in Inbound Doorbell handling routine.
>=20
> The changelog doesn't describe the user-visible impact of the bug.
> Please always include this so that people know whether to backport the
> fix into their kernels, and so they can determine whether the patch
> will fix a problem which they are observing.

This patch fixes the bug that causes kernel panic when number of received
doorbells is larger than number of entries in the inbound doorbell
queue (current default value =3D 512).
Another possible indication for this bug is large number of spurious
doorbells reported by tsi721 driver after reaching the queue size maximum.
