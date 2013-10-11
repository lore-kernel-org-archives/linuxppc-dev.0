Return-Path: <computersforpeace@gmail.com>
Received: from mail-oa0-x231.google.com (mail-oa0-x231.google.com
 [IPv6:2607:f8b0:4003:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 460332C032E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2013 04:33:33 +1100 (EST)
Received: by mail-oa0-f49.google.com with SMTP id j10so134880oah.36
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 10:33:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131010213747.4e56ca1f@crub>
References: <1380295718-10700-1-git-send-email-gsi@denx.de>
 <20131009192931.GC23337@ld-irv-0074.broadcom.com>
 <20131010180948.4350ebda@crub>
 <CAN8TOE8o-34zFP=0q3NjondqpA6UA1szitN+kgKcbaNOWhrscg@mail.gmail.com>
 <20131010213747.4e56ca1f@crub>
Date: Fri, 11 Oct 2013 10:33:29 -0700
Message-ID: <CAN8TOE_0sqG1ZKz-Y=R=ULZ9XJv38Z9AcT7ZMzW1PKYO3TXp+A@mail.gmail.com>
Subject: Re: [v1] powerpc/mpc512x: silence build warning upon disabled DIU
From: Brian Norris <computersforpeace@gmail.com>
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gerhard Sittig <gsi@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Thu, Oct 10, 2013 at 12:37 PM, Anatolij Gustschin <agust@denx.de> wrote:
> On Thu, 10 Oct 2013 11:23:55 -0700
> Brian Norris <computersforpeace@gmail.com> wrote:
>> > Yes, we also have to remove CONFIG_FB_FSL_DIU ifdef in
>> > arch/powerpc/sysdev/fsl_soc.h and building should work then.
>>
>> Still want it around this line, probably, so we'll get compiler errors
>> and not linker errors if someone tries to use it?
>>
>>     extern struct platform_diu_data_ops diu_ops;

I was wrong about this: we need to remove the #ifdef for this extern
as well, because the 'diu_ops' symbol is used in either case with my
patch. Sending out my patch now.

Brian
