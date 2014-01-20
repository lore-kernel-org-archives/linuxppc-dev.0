Return-Path: <olof@lixom.net>
Received: from mail-qa0-f53.google.com (mail-qa0-f53.google.com
 [209.85.216.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 51BE12C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jan 2014 15:16:57 +1100 (EST)
Received: by mail-qa0-f53.google.com with SMTP id cm18so5116125qab.40
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jan 2014 20:16:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52D970C0.3020600@xenosoft.de>
References: <52D970C0.3020600@xenosoft.de>
Date: Sun, 19 Jan 2014 20:16:53 -0800
Message-ID: <CAOesGMgE6TkBO1fp0D_GUAHWv1wOJGy7RtwyPEvr2u=0G=-EWg@mail.gmail.com>
Subject: Re: linuxppc-dev@lists.ozlabs.org
From: Olof Johansson <olof@lixom.net>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Fri, Jan 17, 2014 at 10:04 AM, Christian Zigotzky
<chzigotzky@xenosoft.de> wrote:

[Removed some fairly verbose patch description]

> diff -rupN linux-3.13/arch/powerpc/platforms/pasemi/Kconfig
> linux-3.13-nemo/arch/powerpc/platforms/pasemi/Kconfig
> --- linux-3.13/arch/powerpc/platforms/pasemi/Kconfig    2013-12-06
> 18:34:04.000000000 +0100
> +++ linux-3.13-nemo/arch/powerpc/platforms/pasemi/Kconfig 2013-12-14
> 10:31:19.896353725 +0100
> @@ -14,6 +14,13 @@ config PPC_PASEMI
>  menu "PA Semi PWRficient options"
>      depends on PPC_PASEMI
>
> +config PPC_PASEMI_SB600
> +       bool "Nemo SB600 South Bridge Support"
> +       depends on PPC_PASEMI
> +       select PPC_I8259
> +       help
> +       Workarounds for the SB600 South Bridge.
> +
>  config PPC_PASEMI_IOMMU
>      bool "PA Semi IOMMU support"
>      depends on PPC_PASEMI
>
> Is it possible to integrate the support of the Nemo board to the official
> kernel sources? Thanks a lot to this list for the help to solve the boot
> problems with the kernel 3.13. Sorry, my English isn't very well. I hope you
> understand my email. But I'll learn more English. I promise it gets better.

We'd be happy to integrate support for it, but you should expect to
have to rework the patches to a form where they will be to our liking.

Your english seems to be quite sufficient so far, there are many
kernel developers who do not have english as main language. Ask if you
need something clarified when we reply to you.

Unfortunately, this patch alone doesn't do much good -- it just adds a
kernel config option without telling us much about what it's doing. It
would make more sense to also include the code changes that the config
option will result in (or makefile changes and c file additions, if
any).

In this case, isn't the southbridge just another PCI-e device? I don't
see how we would need a machine-specific configuration option to
enable it, but seeing the code changes that go along with it would
help explain to us.


-Olof
