Return-Path: <michael.guntsche@it-loops.com>
Received: from mail-vc0-f178.google.com (mail-vc0-f178.google.com
 [209.85.220.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6B6A82C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Jun 2013 05:39:40 +1000 (EST)
Received: by mail-vc0-f178.google.com with SMTP id id13so3508229vcb.23
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Jun 2013 12:39:37 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 8 Jun 2013 21:39:37 +0200
Message-ID: <CALG0vJu9-640D=Q-2RoSOnWtR=sERwj0fSCibK+ijprcf-T6Ag@mail.gmail.com>
Subject: Re: [BUG] PCI related panic on powerpc based board with 3.10-rcX
From: Michael Guntsche <michael.guntsche@it-loops.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rojhalat Ibrahim <imr@rtschenk.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After bisecting I found the responsible commit.

50d8f87d2b3: powerpc/fsl-pci Make PCIe hotplug work with Freescale
PCIe controllers

Reverting this commit allowed my board to boot again.

@Rojhalat: Please have a look at
http://marc.info/?l=linux-kernel&m=137071294204858&w=2
for my initial bugreport.

What I do not understand at all is why this is affecting my platform.
AFAIK there is no PCIe hardware on it AND I completely disabled PCIe
support in config.

Kind regards,
Mike
