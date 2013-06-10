Return-Path: <michael.guntsche@it-loops.com>
Received: from mail-vb0-x231.google.com (mail-vb0-x231.google.com
 [IPv6:2607:f8b0:400c:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4AE9A2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 03:07:47 +1000 (EST)
Received: by mail-vb0-f49.google.com with SMTP id 12so1020082vbf.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 10:07:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7927838.NMrLdRWptT@pcimr>
References: <CALG0vJu9-640D=Q-2RoSOnWtR=sERwj0fSCibK+ijprcf-T6Ag@mail.gmail.com>
 <7927838.NMrLdRWptT@pcimr>
Date: Mon, 10 Jun 2013 19:07:43 +0200
Message-ID: <CALG0vJtjS2wP_s=-iyG1ABKw_ct=B9OdNXY9YCrnkhAnpaN1Zw@mail.gmail.com>
Subject: Re: [BUG] PCI related panic on powerpc based board with 3.10-rcX
From: Michael Guntsche <michael.guntsche@it-loops.com>
To: Rojhalat Ibrahim <imr@rtschenk.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Good evening,

On Mon, Jun 10, 2013 at 1:41 PM, Rojhalat Ibrahim <imr@rtschenk.de> wrote:
> Hi Mike,
>
> could you please try this patch:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-May/106624.html
> http://patchwork.ozlabs.org/patch/244515/
>
>    Rojhalat
>
>
> On Saturday 08 June 2013 21:39:37 Michael Guntsche wrote:
>> After bisecting I found the responsible commit.
>>
>> 50d8f87d2b3: powerpc/fsl-pci Make PCIe hotplug work with Freescale
>> PCIe controllers
>>
>> Reverting this commit allowed my board to boot again.
>>
>> @Rojhalat: Please have a look at
>> http://marc.info/?l=linux-kernel&m=137071294204858&w=2
>> for my initial bugreport.
>>
>> What I do not understand at all is why this is affecting my platform.
>> AFAIK there is no PCIe hardware on it AND I completely disabled PCIe
>> support in config.
>>
>> Kind regards,
>> Mike

This patch does not fix the problem, during boot the kernel still
panics. I had a closer look at the commit and the following patch
fixes it for me....

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 028ac1f..21b687f 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -814,7 +814,7 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
                if (ret)
                        goto err0;
        } else {
-               fsl_setup_indirect_pci(hose, rsrc_cfg.start,
+               setup_indirect_pci(hose, rsrc_cfg.start,
                                       rsrc_cfg.start + 4, 0);
        }

Apparently the mpc83xx platform code goes through great lengths to
guard the call to fsl_pcie_check_link on NON PCIe platforms, since
apparently this seems to cause the panic. Furthermore it also has its
own PCIe setup code. With this patch applied the system boots fine for
me.

The only problem I have with this patch is that the compiler fails
since -Werror is used and fsl_setup_indirect_pci now is never used.
For testing purposes I removed the function definition. Obviously the
proper fix would be to wrap it in an #ifdef but I did not know the
proper define to check against.

Kind regards,
Mike
