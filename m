Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BD911B70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 05:50:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 03/10] RapidIO: Use stored ingress port number instead
	of register read
Date: Mon, 20 Sep 2010 12:49:30 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201303EA2@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <20100920121725.66bb96d0.akpm@linux-foundation.org>
References: <1284476363-1677-1-git-send-email-alexandre.bounine@idt.com><1284476363-1677-4-git-send-email-alexandre.bounine@idt.com><20100914151219.5d92c6f9.akpm@linux-foundation.org><0CE8B6BE3C4AD74AB97D9D29BD24E55201303D0E@CORPEXCH1.na.ads.idt.com>
	<20100920121725.66bb96d0.akpm@linux-foundation.org>
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
>=20
> The "variable length array at the end of the struct" thing is pretty
> commonly used and works well.  As long as we never want to change the
> number of switches on the fly (hotplug?).

This is expected to be a "strange" array - its size can be 0 or 1 only.
No number of switches in that array should be changed on the fly.
In the hotplug situation entire rio_dev structure should be added (or
removed).
RIO device can be endpoint or switch. If a RIO device is a switch - the
rio_switch
structure will be added at the end.
