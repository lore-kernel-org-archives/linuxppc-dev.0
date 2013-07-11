Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8EA3B2C02F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 22:33:14 +1000 (EST)
Message-ID: <1373545982.19894.82.camel@pasglop>
Subject: Re: [PATCH 6/8] KVM: PPC: Add support for multiple-TCE hcalls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 11 Jul 2013 22:33:02 +1000
In-Reply-To: <51DE3ECB.7080803@ozlabs.ru>
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
 <1373123227-22969-7-git-send-email-aik@ozlabs.ru>
 <51DC4228.7010607@suse.de> <51DCEA76.9070808@ozlabs.ru>
 <D10E7B99-3A7C-4275-9A49-3CB15598E705@suse.de> <51DE3ECB.7080803@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-07-11 at 15:12 +1000, Alexey Kardashevskiy wrote:
> >> Any debug code is prohibited? Ok, I'll remove.
> > 
> > Debug code that requires code changes is prohibited, yes.
> > Debug code that is runtime switchable (pr_debug, trace points, etc)
> > are allowed.

Bollox.

$ grep DBG\( arch/powerpc/ -r | wc -l
418

Also pr_devel is not runtime switchable in normal kernels either and
still an "official" kernel interface.

> Is there any easy way to enable just this specific udbg_printf (not all of
> them at once)? Trace points do not work in real mode as we figured out.

The cleaner way to do it is to use some kind of local macro that you
enable/disable by changing a #define at the top of the function, possibly
several.

Cheers,
Ben.
