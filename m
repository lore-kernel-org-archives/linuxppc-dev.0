Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CD9C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 22:27:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0172086D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 22:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM87LXcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0172086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Vpcr36PqzF1MV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 09:27:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mM87LXcB";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mM87LXcB"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VpZ52sbYzF13y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 09:25:01 +1100 (AEDT)
Received: by mail-it1-x144.google.com with SMTP id c23-v6so10545524itd.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Kit3xuuWTA955UtTNqGpUEUIsL+3vy5yoJvnXnCW12g=;
 b=mM87LXcBOyFRAzlYZ6FGobIS0Wil3AtX3r/GWf8RZijoVZwK/zjgViuhCinS1cApGN
 FmLOyOKj69p3vvuFBRrLDQ3pH8lWNVWGGu/VIO02WwY5rzCmAgit/dFu7xqWFE2GrdQ8
 myS1sIB3o4Px5LVEp0ONN4WAnfF5pZ0iOC7WXqPVZKhCni4udb6+e6LZ3YThh0Uml6HI
 YNTejrju+wI/kTRGrJwbuJXV4Ur4oew/MewaISTh/2xjBSYv7mpZUt2Dx16o2kon8eDL
 2LgMOtts6d+OSpGIPw2Ij5IUxeNhnockcCxEfe8qSlszoOGX8p1QyhsT+tH35u2VGFhH
 Bgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kit3xuuWTA955UtTNqGpUEUIsL+3vy5yoJvnXnCW12g=;
 b=eGr/dow2btpHFAWHHIwrfdctrC2gVvEvxzFHqE3DIl3c/8u2n8ldG7Kv9ZaNy7a73D
 LzASLrhYFO8Qx3bn9BKY+f1OeL7Ium8cgk9HuxGlIWHgvkAPyzxTrZ3lF2KAlYZCK3J0
 DvOKYAAEq74VHR2P60VsKjJ/W+357DW5IKqQsOBE3QP226FPFQEMN3xdSq2d6LukCHG8
 UHklEN+ou1yn6ipZp7BiGfQsM+N9PsHAvKCZ1RChxWktjYhmOeNI6GiiPTP4+BmaK13C
 KY9vlagjGO0sYDztx+sj9qL5lCPCjkumhpvUb2ZGiA6f5swuQ1k4bT6lvFIKLrLYKuAc
 2fJg==
X-Gm-Message-State: ABuFfojESmbojAOQQIkNRZgtaBzbjFZPtARVfKQemYsoYj5PSKFZ5BJv
 LbAA0c6HopgCZJcLC6zLzmstu4d3sqF5Yq4zf9M=
X-Google-Smtp-Source: ACcGV63KRZLpla8nSR1drjtHL6y4JO63bLxGX5ItafjFCWowFNjfmsDpT4S/O6ZTdEA8kt2S/T0Cgoq/689t0EgUHH0=
X-Received: by 2002:a24:b909:: with SMTP id w9-v6mr2390596ite.0.1539210298726; 
 Wed, 10 Oct 2018 15:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181010060812.20068-1-oohall@gmail.com>
 <20181010060812.20068-2-oohall@gmail.com>
 <857573fb-6839-000b-a64a-c020b0d8faea@linux.vnet.ibm.com>
In-Reply-To: <857573fb-6839-000b-a64a-c020b0d8faea@linux.vnet.ibm.com>
From: Oliver <oohall@gmail.com>
Date: Thu, 11 Oct 2018 09:24:47 +1100
Message-ID: <CAOSf1CGkgwSwrpWX7WBgix8sVh+keBmtk9kxZOU3Ha0LZ0h=dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/pseries: PAPR persistent memory support
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 11, 2018 at 3:36 AM Nathan Fontenot
<nfont@linux.vnet.ibm.com> wrote:
>
> On 10/10/2018 01:08 AM, Oliver O'Halloran wrote:
> > This patch implements support for discovering storage class memory
> > devices at boot and for handling hotplug of new regions via RTAS
> > hotplug events.
> >
> > Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> > ---
> >  arch/powerpc/include/asm/firmware.h       |  3 ++-
> >  arch/powerpc/include/asm/hvcall.h         | 10 +++++++++-
> >  arch/powerpc/include/asm/rtas.h           |  2 ++
> >  arch/powerpc/kernel/rtasd.c               |  2 ++
> >  arch/powerpc/platforms/pseries/Makefile   |  2 +-
> >  arch/powerpc/platforms/pseries/dlpar.c    |  4 ++++
> >  arch/powerpc/platforms/pseries/firmware.c |  1 +
> >  arch/powerpc/platforms/pseries/pseries.h  |  5 +++++
> >  arch/powerpc/platforms/pseries/ras.c      |  3 ++-
> >  9 files changed, 28 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
> > index 7a051bd21f87..113c64d5d394 100644
> > --- a/arch/powerpc/include/asm/firmware.h
> > +++ b/arch/powerpc/include/asm/firmware.h
> > @@ -52,6 +52,7 @@
> >  #define FW_FEATURE_PRRN              ASM_CONST(0x0000000200000000)
> >  #define FW_FEATURE_DRMEM_V2  ASM_CONST(0x0000000400000000)
> >  #define FW_FEATURE_DRC_INFO  ASM_CONST(0x0000000800000000)
> > +#define FW_FEATURE_PAPR_SCM  ASM_CONST(0x0000001000000000)
> >
> >  #ifndef __ASSEMBLY__
> >
> > @@ -69,7 +70,7 @@ enum {
> >               FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
> >               FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
> >               FW_FEATURE_HPT_RESIZE | FW_FEATURE_DRMEM_V2 |
> > -             FW_FEATURE_DRC_INFO,
> > +             FW_FEATURE_DRC_INFO | FW_FEATURE_PAPR_SCM,
> >       FW_FEATURE_PSERIES_ALWAYS = 0,
> >       FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
> >       FW_FEATURE_POWERNV_ALWAYS = 0,
> > diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> > index a0b17f9f1ea4..0e81ef83b35a 100644
> > --- a/arch/powerpc/include/asm/hvcall.h
> > +++ b/arch/powerpc/include/asm/hvcall.h
> > @@ -295,7 +295,15 @@
> >  #define H_INT_ESB               0x3C8
> >  #define H_INT_SYNC              0x3CC
> >  #define H_INT_RESET             0x3D0
> > -#define MAX_HCALL_OPCODE     H_INT_RESET
> > +#define H_SCM_READ_METADATA     0x3E4
> > +#define H_SCM_WRITE_METADATA    0x3E8
> > +#define H_SCM_BIND_MEM          0x3EC
> > +#define H_SCM_UNBIND_MEM        0x3F0
> > +#define H_SCM_QUERY_BLOCK_MEM_BINDING 0x3F4
> > +#define H_SCM_QUERY_LOGICAL_MEM_BINDING 0x3F8
> > +#define H_SCM_MEM_QUERY              0x3FC
> > +#define H_SCM_BLOCK_CLEAR       0x400
> > +#define MAX_HCALL_OPCODE     H_SCM_BLOCK_CLEAR
> >
> >  /* H_VIOCTL functions */
> >  #define H_GET_VIOA_DUMP_SIZE 0x01
> > diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> > index 71e393c46a49..1e81f3d55457 100644
> > --- a/arch/powerpc/include/asm/rtas.h
> > +++ b/arch/powerpc/include/asm/rtas.h
> > @@ -125,6 +125,7 @@ struct rtas_suspend_me_data {
> >  #define RTAS_TYPE_INFO                       0xE2
> >  #define RTAS_TYPE_DEALLOC            0xE3so we might as well
> >  #define RTAS_TYPE_DUMP                       0xE4
> > +#define RTAS_TYPE_HOTPLUG            0xE5
> >  /* I don't add PowerMGM events right now, this is a different topic */
> >  #define RTAS_TYPE_PMGM_POWER_SW_ON   0x60
> >  #define RTAS_TYPE_PMGM_POWER_SW_OFF  0x61
> > @@ -316,6 +317,7 @@ struct pseries_hp_errorlog {
> >  #define PSERIES_HP_ELOG_RESOURCE_MEM 2
> >  #define PSERIES_HP_ELOG_RESOURCE_SLOT        3
> >  #define PSERIES_HP_ELOG_RESOURCE_PHB 4
> > +#define PSERIES_HP_ELOG_RESOURCE_PMEM   6
> >
> >  #define PSERIES_HP_ELOG_ACTION_ADD   1
> >  #define PSERIES_HP_ELOG_ACTION_REMOVE        2
> > diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
> > index 6fafc82c04b0..fad0baddfcba 100644
> > --- a/arch/powerpc/kernel/rtasd.c
> > +++ b/arch/powerpc/kernel/rtasd.c
> > @@ -91,6 +91,8 @@ static char *rtas_event_type(int type)
> >                       return "Dump Notification Event";
> >               case RTAS_TYPE_PRRN:
> >                       return "Platform Resource Reassignment Event";
> > +             case RTAS_TYPE_HOTPLUG:
> > +                     return "Hotplug Event";
> >       }
> >
> >       return rtas_type[0];
> > diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
> > index 7e89d5c47068..892b27ced973 100644
> > --- a/arch/powerpc/platforms/pseries/Makefile
> > +++ b/arch/powerpc/platforms/pseries/Makefile
> > @@ -13,7 +13,7 @@ obj-$(CONFIG_KEXEC_CORE)    += kexec.o
> >  obj-$(CONFIG_PSERIES_ENERGY) += pseries_energy.o
> >
> >  obj-$(CONFIG_HOTPLUG_CPU)    += hotplug-cpu.o
> > -obj-$(CONFIG_MEMORY_HOTPLUG) += hotplug-memory.o
> > +obj-$(CONFIG_MEMORY_HOTPLUG) += hotplug-memory.o pmem.o
> >
> >  obj-$(CONFIG_HVC_CONSOLE)    += hvconsole.o
> >  obj-$(CONFIG_HVCS)           += hvcserver.o
> > diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> > index a0b20c03f078..795996fefdb9 100644
> > --- a/arch/powerpc/platforms/pseries/dlpar.c
> > +++ b/arch/powerpc/platforms/pseries/dlpar.c
> > @@ -357,6 +357,10 @@ static int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
> >       case PSERIES_HP_ELOG_RESOURCE_CPU:
> >               rc = dlpar_cpu(hp_elog);
> >               break;
> > +     case PSERIES_HP_ELOG_RESOURCE_PMEM:
> > +             rc = dlpar_hp_pmem(hp_elog);
>
> You reference a dlpar handler for pmem here but I am not finding a handler
> defined when CONFIG_MEMORY_HOTPLUG is defined. The update to pseries.h below
> only provides a definition when it is not defined.

Ah crap. The file that adds it went missing when I rebased. I'll post a respin.

> Also, do we need to handle dlpar of pmem memory? There have been discussion of
> supporting this in the future but I did not thin it was currently supported.

I think it's something that we're going to need and Barata has already
implemented support for it inside of qemu. The implementation is more
or less the same in the hot and coldplug cases so it's not much work
to support it.

> -Nathan
>
> > +             break;
> > +
> >       default:
> >               pr_warn_ratelimited("Invalid resource (%d) specified\n",
> >                                   hp_elog->resource);
> > diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
> > index a3bbeb43689e..4927de57d8ee 100644
> > --- a/arch/powerpc/platforms/pseries/firmware.c
> > +++ b/arch/powerpc/platforms/pseries/firmware.c
> > @@ -65,6 +65,7 @@ hypertas_fw_features_table[] = {
> >       {FW_FEATURE_SET_MODE,           "hcall-set-mode"},
> >       {FW_FEATURE_BEST_ENERGY,        "hcall-best-energy-1*"},
> >       {FW_FEATURE_HPT_RESIZE,         "hcall-hpt-resize"},
> > +     {FW_FEATURE_PAPR_SCM,           "hcall-scm"},
> >  };
> >
> >  /* Build up the firmware features bitmask using the contents of
> > diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> > index 60db2ee511fb..d0829677c896 100644
> > --- a/arch/powerpc/platforms/pseries/pseries.h
> > +++ b/arch/powerpc/platforms/pseries/pseries.h
> > @@ -63,11 +63,16 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
> >                        struct completion *hotplug_done, int *rc);
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> >  int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
> > +int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog);
> >  #else
> >  static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
> >  {
> >       return -EOPNOTSUPP;
> >  }
> > +int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog)
> > +{
> > +     return -EOPNOTSUPP;
> > +};
> >  #endif
> >
> >  #ifdef CONFIG_HOTPLUG_CPU
> > diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> > index 851ce326874a..ae22fc007276 100644
> > --- a/arch/powerpc/platforms/pseries/ras.c
> > +++ b/arch/powerpc/platforms/pseries/ras.c
> > @@ -237,7 +237,8 @@ static irqreturn_t ras_hotplug_interrupt(int irq, void *dev_id)
> >        * hotplug events on the ras_log_buf to be handled by rtas_errd.
> >        */
> >       if (hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_MEM ||
> > -         hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_CPU)
> > +         hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_CPU ||
> > +         hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_PMEM)
> >               queue_hotplug_event(hp_elog, NULL, NULL);
> >       else
> >               log_error(ras_log_buf, ERR_TYPE_RTAS_LOG, 0);
> >
>
