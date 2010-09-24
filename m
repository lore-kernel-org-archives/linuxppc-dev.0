Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id A18B1B70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 17:57:46 +1000 (EST)
Received: by ewy21 with SMTP id 21so677066ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 00:57:43 -0700 (PDT)
Date: Fri, 24 Sep 2010 11:57:40 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] spi_mpc8xxx: issue with using definition of pram in
	Device Tree
Message-ID: <20100924075740.GA20599@oksana.dev.rtsoft.ru>
References: <20100916070503.10046C7391@messagerie.si.c-s.fr>
	<20100924071006.GA21318@angua.secretlab.ca> <4C9C513B.40501@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4C9C513B.40501@c-s.fr>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Fri, Sep 24, 2010 at 09:20:27AM +0200, LEROY Christophe wrote:
> The issue is that cpm_muram_alloc_fixed() allocates memory from the
> general purpose muram area (from 0x0 to 0x1bff).
> Here we need to return a pointer to the parameter RAM, which is
> located somewhere starting at 0x1c00. It is not a dynamic allocation
> that is required here but only to point on the correct location in
> the parameter RAM.
> 
> For the CPM2, I don't know. I'm working with a MPC866.
> 
> Attached is a previous discussion on the subject where I explain a
> bit more in details the issue.

The patch looks OK, I think.

Doesn't explain why that worked on MPC8272 (CPM2) and MPC8560
(also CPM2) machines though. But here's my guess (I no longer
have these boards to test it):

On 8272 I used this node:

+                       spi@4c0 {
+                               #address-cells = <1>;
+                               #size-cells = <0>;
+                               compatible = "fsl,cpm2-spi", "fsl,spi";
+                               reg = <0x11a80 0x40 0x89fc 0x2>;

On that SOC there are two muram data regions 0x0..0x2000 and
0x9000..0x9100. Note that we actually don't want "data" regions,
and the only reason why that worked is that sysdev/cpm_common.c
maps muram(0)..muram(max).

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
