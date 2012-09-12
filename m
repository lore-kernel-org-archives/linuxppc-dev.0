Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CEC962C04FC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 18:43:07 +1000 (EST)
Message-ID: <1347439382.2603.97.camel@pasglop>
Subject: Re: [v3][PATCH 2/3] ppc/kprobe: complete kprobe and migrate
 exception frame
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Date: Wed, 12 Sep 2012 18:43:02 +1000
In-Reply-To: <505049FE.8060204@windriver.com>
References: <1347330053-27039-1-git-send-email-tiejun.chen@windriver.com>
 <1347330053-27039-2-git-send-email-tiejun.chen@windriver.com>
 <1347342718.2603.38.camel@pasglop> <505049FE.8060204@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-09-12 at 16:38 +0800, tiejun.chen wrote:
> > So you need to store that old r1 somewhere fist then retrieve it
> > after the memcpy call. That or open-code the memcpy to avoid all
> > the clobbering problems.
> 
> Maybe we can use copy_and_flush() since looks copy_and_flush() only
> clobber r0, 
> r6 and LR explicitly.
> 
> I'll resync these comments for v4. 

I'd say just open code it. You already have src and dst in registers,
the length can easily be put in ctr... easier that way, not clobbering
to worry about nor stack frame to create etc...

Cheers,
Ben.
