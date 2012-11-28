Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 420F42C0085
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2012 05:43:02 +1100 (EST)
Message-ID: <50B65903.1050400@wwwdotorg.org>
Date: Wed, 28 Nov 2012 11:33:39 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH V7 1/7] kbuild: centralize .dts->.dtb rule
References: <1354058956-7199-1-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1354058956-7199-1-git-send-email-swarren@wwwdotorg.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/27/2012 04:29 PM, Stephen Warren wrote:
> All architectures that use cmd_dtc do so in almost the same way. Create
> a central build rule to avoid duplication. The one difference is that
> most current uses of dtc build $(obj)/%.dtb from $(src)/dts/%.dts rather
> than building the .dtb in the same directory as the .dts file. This
> difference will be eliminated arch-by-arch in future patches.
> 
> MIPS is the exception here; it already uses the exact same rule as the
> new common rule, so the duplicate is removed in this patch to avoid any
> conflict. arch/mips changes courtesy of Ralf Baechle.
> 
> Update Documentation/kbuild to remove the explicit call to cmd_dtc from
> the example, now that the rule exists in a centralized location.

Ben, Paul,

Following this patch (http://lkml.org/lkml/2012/11/27/555), I posted a
series of patches to convert almost all architectures to using the
centralized rule. The one architecture I didn't convert was PowerPC.

I didn't convert it because arch/powerpc/boot/Makefile contains a large
number of rules (to generate *Image.% where % is a board name) that
depend on %.dtb, which is expected to be in arch/powerpc/boot rather
than arch/powerpc/boot/dts. Now, I guess it's possible to convert them
all to expect the .dtb files to be in dts/ and also have
arch/powerpc/boot/Makefile call make in boot/dts/ to make each required
.dtb file. However, the patch would be a bit larger than all the other
architecture patches. Do you want me to do that conversion, or would you
rather I leave PowerPC alone? Thanks for any feedback.
