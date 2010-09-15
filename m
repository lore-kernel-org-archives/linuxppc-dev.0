Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CFF1CB70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 05:28:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 03/10] RapidIO: Use stored ingress port number instead
	of register read
Date: Wed, 15 Sep 2010 12:28:06 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201303364@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <20100914151219.5d92c6f9.akpm@linux-foundation.org>
References: <1284476363-1677-1-git-send-email-alexandre.bounine@idt.com><1284476363-1677-4-git-send-email-alexandre.bounine@idt.com>
	<20100914151219.5d92c6f9.akpm@linux-foundation.org>
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
=20
> What is the locking for rdev?  In other patches I see pointer chases
> with no obvious locking against concurrent changes?

This rdev should be safe because it is intended for use only by
rio_switch
attached to the same rdev. Therefore rio_global_list_lock will work
here.

I will check for safe locking in all my patches - this set and earlier.
