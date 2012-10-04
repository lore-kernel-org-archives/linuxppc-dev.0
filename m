Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7F5952C03B5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2012 03:27:50 +1000 (EST)
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH 1/5] rapidio: fix blocking wait for discovery ready
Date: Thu, 4 Oct 2012 17:20:09 +0000
Message-ID: <8D983423E7EDF846BB3056827B8CC5D1499FC794@corpmail2.na.ads.idt.com>
References: <1349291923-22860-1-git-send-email-alexandre.bounine@idt.com>
 <1349291923-22860-2-git-send-email-alexandre.bounine@idt.com>
 <20121003152001.665c9373.akpm@linux-foundation.org>
In-Reply-To: <20121003152001.665c9373.akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, October 03, 2012 6:20 PM
Andrew Morton <akpm@linux-foundation.org> wrote:
>=20
> On Wed,  3 Oct 2012 15:18:39 -0400
> Alexandre Bounine <alexandre.bounine@idt.com> wrote:
>=20
> > Fix blocking wait loop in the RapidIO discovery routine to avoid
> > warning dumps about stalled CPU on x86 platforms.
> >
> > ...
> >
> > +		to_end =3D jiffies + CONFIG_RAPIDIO_DISC_TIMEOUT * HZ;
> > +		while (time_before(jiffies, to_end)) {
> > +			if (rio_enum_complete(mport))
> > +				goto enum_done;
> > +
> 	schedule_timeout_uninterruptible(msecs_to_jiffies(10));
>=20
> I think a simple msleep(10) would suffice here?
>=20
Agree, same thing but looks simpler. Will update.
