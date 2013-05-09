Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 02DF92C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 22:27:12 +1000 (EST)
Message-ID: <1368102412.25488.182.camel@pasglop>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Thu, 09 May 2013 22:26:52 +1000
In-Reply-To: <20130509082112.GE2263@pek-khao-d1.corp.ad.wrs.com>
References: <51885F49.6060605@windriver.com> <1367892390.3398.12@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF3F00D0@039-SN2MPN1-013.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700E50E@039-SN2MPN1-011.039d.mgd.msft.net>
 <518B54A6.1070505@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700E563@039-SN2MPN1-011.039d.mgd.msft.net>
 <20130509080813.GD2263@pek-khao-d1.corp.ad.wrs.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700E5F5@039-SN2MPN1-011.039d.mgd.msft.net>
 <20130509082112.GE2263@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-09 at 16:21 +0800, Kevin Hao wrote:
> > Is it because that we cannot afford to lose perfmon interrupt for
> more accurate capturing of data ?
> 
> Yes, I think this will definitely improve the perf sample quality.

This is one of the primary reason why we implemented lazy disabling in
the first place and why I recently reworked it to decrease the periods
where we are hard disabled.

The other reasons are that storing bytes to the PACA is faster than
manipulating EE on many processors.

Cheers,
Ben.
