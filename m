Return-Path: <glikely@secretlab.ca>
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com
 [209.85.214.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 52AF02C00F9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 13:56:37 +1000 (EST)
Received: by mail-ob0-f170.google.com with SMTP id ef5so3397575obb.29
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 20:56:35 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <CAMuHMdV=pSG+CtvGqr1c9nDKeHCU0cVQcFkfAo5iMMna2HOvZg@mail.gmail.com>
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
 <1326313337-24603-12-git-send-email-grant.likely@secretlab.ca>
 <CAMuHMdV=pSG+CtvGqr1c9nDKeHCU0cVQcFkfAo5iMMna2HOvZg@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 25 Jul 2013 21:56:14 -0600
Message-ID: <CACxGe6s3wit88ynuzYsBZBvijHmAfJNeY9LH2T5S9iY7kJtg=w@mail.gmail.com>
Subject: Re: [RFC 11/14] powerpc: Eliminate NO_IRQ usage
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@arm.linux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <rob.herring@calxeda.com>, Linux-Next <linux-next@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 25, 2013 at 3:58 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Jan 11, 2012 at 9:22 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> NO_IRQ is evil.  Stop using it in arch/powerpc and powerpc device drivers
>
>> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
>> index 3e06696..55c6ff9 100644
>> --- a/sound/soc/fsl/fsl_ssi.c
>> +++ b/sound/soc/fsl/fsl_ssi.c
>> @@ -666,7 +666,7 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
>>         ssi_private->ssi_phys = res.start;
>>
>>         ssi_private->irq = irq_of_parse_and_map(np, 0);
>> -       if (ssi_private->irq == NO_IRQ) {
>> +       if (!ssi_private->irq) {
>>                 dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
>>                 ret = -ENXIO;
>>                 goto error_iomap;
>
> What's the plan with this patch?
>
> This is now failing on xtensa, as it's one of the architectures that doesn't
> define NO_IRQ. Only arm, c6x, mn10300, openrisc, parisc, powerpc, and sparc
> define it.

Wow. I'd pretty much dropped that patch because I didn't have time to
chase it down. It should be pursued though.

In that particular case it is safe I think to apply the change. PPC
defines NO_IRQ to be 0 anyway.

g.
