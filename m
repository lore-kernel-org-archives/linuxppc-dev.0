Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6126F1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 09:05:21 +1100 (EST)
Message-ID: <1321999502.14573.4.camel@pasglop>
Subject: Re: powerpc: dts: Fix canyonlands EMAC interrupt map
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tanmay Inamdar <tinamdar@apm.com>
Date: Wed, 23 Nov 2011 09:05:02 +1100
In-Reply-To: <CACoXjc=RBpB6eYu1zB-kCcYmsV8rdbzYtdxyBJDLTdt6uu04ig@mail.gmail.com>
References: <1321945877-22802-1-git-send-email-tinamdar@apm.com>
 <CA+5PVA7BD9jNoV9LrXjk2+UPBW8MSTPkwpYPFj2y-CNkXCrAhA@mail.gmail.com>
 <CACoXjc=RBpB6eYu1zB-kCcYmsV8rdbzYtdxyBJDLTdt6uu04ig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-11-22 at 19:45 +0530, Tanmay Inamdar wrote:
> 
> On Tue, Nov 22, 2011 at 5:00 PM, Josh Boyer <jwboyer@gmail.com> wrote:
>         On Tue, Nov 22, 2011 at 2:11 AM, Tanmay Inamdar
>         <tinamdar@apm.com> wrote:
>         > Fixing interrupt mapping of EMAC for canyonlands
>         >
>         > Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>         
>         
>         As far as I can tell, your changes aren't really changing
>         anything
>         just making it a bit clearer, correct?  If so, do you mind if
>         I change
>         the commit log to "clear up" instead of fix?
> 
> Actually Rob Herring's commit
> (http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=dc9372808412edbc653a675a526c2ee6c0c14a91) breaks the interrupt mapping in EMAC driver.
> I am trying to fix this issue by mapping interrupts in different way.

No. This commit needs to be reverted. It breaks existing practices.
Pointing to yourself as a parent in order to provide a map is an old
trick and it should be supported.

I'll ask Linus to revert.

Cheers,
Ben.

> If you think "clear up" is fine, then please go ahead.
> 
> Thanks,
> Tanmay
> 
>         
>         josh
>         
>         
>         > ---
>         >  arch/powerpc/boot/dts/canyonlands.dts |   16
>         ++++++----------
>         >  1 files changed, 6 insertions(+), 10 deletions(-)
>         >
>         > diff --git a/arch/powerpc/boot/dts/canyonlands.dts
>         b/arch/powerpc/boot/dts/canyonlands.dts
>         > index 3dc75de..c76bbcd 100644
>         > --- a/arch/powerpc/boot/dts/canyonlands.dts
>         > +++ b/arch/powerpc/boot/dts/canyonlands.dts
>         > @@ -360,13 +360,11 @@
>         >                        EMAC0: ethernet@ef600e00 {
>         >                                device_type = "network";
>         >                                compatible =
>         "ibm,emac-460ex", "ibm,emac4sync";
>         > -                               interrupt-parent = <&EMAC0>;
>         > -                               interrupts = <0x0 0x1>;
>         > -                               #interrupt-cells = <1>;
>         > +                               interrupt-parent = <&UIC2>;
>         >                                #address-cells = <0>;
>         >                                #size-cells = <0>;
>         > -                               interrupt-map = </*Status*/
>         0x0 &UIC2 0x10 0x4
>         > -                                                /*Wake*/
>         0x1 &UIC2 0x14 0x4>;
>         > +                               interrupts = </*Status*/0x10
>         0x4
>         > +                                               /*Wake*/0x14
>         0x4>;
>         >                                reg = <0xef600e00
>         0x000000c4>;
>         >                                local-mac-address =
>         [000000000000]; /* Filled in by U-Boot */
>         >                                mal-device = <&MAL0>;
>         > @@ -390,13 +388,11 @@
>         >                        EMAC1: ethernet@ef600f00 {
>         >                                device_type = "network";
>         >                                compatible =
>         "ibm,emac-460ex", "ibm,emac4sync";
>         > -                               interrupt-parent = <&EMAC1>;
>         > -                               interrupts = <0x0 0x1>;
>         > -                               #interrupt-cells = <1>;
>         > +                               interrupt-parent = <&UIC2>;
>         >                                #address-cells = <0>;
>         >                                #size-cells = <0>;
>         > -                               interrupt-map = </*Status*/
>         0x0 &UIC2 0x11 0x4
>         > -                                                /*Wake*/
>         0x1 &UIC2 0x15 0x4>;
>         > +                               interrupts = </*Status*/0x11
>         0x4
>         > +                                               /*Wake*/0x15
>         0x4>;
>         >                                reg = <0xef600f00
>         0x000000c4>;
>         >                                local-mac-address =
>         [000000000000]; /* Filled in by U-Boot */
>         >                                mal-device = <&MAL0>;
>         > --
>         > 1.6.1.rc3
>         >
>         
>         > --
>         > To unsubscribe from this list: send the line "unsubscribe
>         linux-kernel" in
>         > the body of a message to majordomo@vger.kernel.org
>         > More majordomo info at
>          http://vger.kernel.org/majordomo-info.html
>         > Please read the FAQ at  http://www.tux.org/lkml/
>         >
> 
> CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
> is for the sole use of the intended recipient(s) and contains information 
> that is confidential and proprietary to AppliedMicro Corporation or its subsidiaries. 
> It is to be used solely for the purpose of furthering the parties' business relationship. 
> All unauthorized review, use, disclosure or distribution is prohibited. 
> If you are not the intended recipient, please contact the sender by reply e-mail 
> and destroy all copies of the original message.
