Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0C3C12C007B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2012 10:33:30 +1100 (EST)
Message-ID: <1354145291.2179.147.camel@pasglop>
Subject: Re: [PATCH V7 1/7] kbuild: centralize .dts->.dtb rule
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 29 Nov 2012 10:28:11 +1100
In-Reply-To: <50B65903.1050400@wwwdotorg.org>
References: <1354058956-7199-1-git-send-email-swarren@wwwdotorg.org>
 <50B65903.1050400@wwwdotorg.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-11-28 at 11:33 -0700, Stephen Warren wrote:

> Following this patch (http://lkml.org/lkml/2012/11/27/555), I posted a
> series of patches to convert almost all architectures to using the
> centralized rule. The one architecture I didn't convert was PowerPC.
> 
> I didn't convert it because arch/powerpc/boot/Makefile contains a large
> number of rules (to generate *Image.% where % is a board name) that
> depend on %.dtb, which is expected to be in arch/powerpc/boot rather
> than arch/powerpc/boot/dts. Now, I guess it's possible to convert them
> all to expect the .dtb files to be in dts/ and also have
> arch/powerpc/boot/Makefile call make in boot/dts/ to make each required
> .dtb file. However, the patch would be a bit larger than all the other
> architecture patches. Do you want me to do that conversion, or would you
> rather I leave PowerPC alone? Thanks for any feedback.

Kumar, any objection to moving the dtb's to arch/powerpc/boot/dtb/ ?
Other than breaking a script or two out there ...

Cheers,
Ben.
