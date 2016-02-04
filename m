Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA0AB1A007F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 00:56:49 +1100 (AEDT)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 8E384440D96_6B3589CB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 13:56:44 +0000 (GMT)
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com
 [209.85.220.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 27F3243E070_6B3589CF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 13:56:44 +0000 (GMT)
Received: by mail-qk0-f180.google.com with SMTP id s5so21038381qkd.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Feb 2016 05:56:44 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 4 Feb 2016 14:56:42 +0100
Message-ID: <CAPk1OjGDTCy6TzX1B3oi6NA3s==23vRgTdRh2SKfyVj-K7k75Q@mail.gmail.com>
Subject: Question about code which uses MPIC_NO_RESET on 85XX
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Can we change this code (from mpc85xx_ds.c)

if (of_flat_dt_is_compatible(root, "fsl,MPC8572DS-CAMP")) {
    mpic = mpic_alloc(NULL, 0,
        MPIC_NO_RESET |
        MPIC_BIG_ENDIAN |
        MPIC_SINGLE_DEST_CPU,
        0, 256, " OpenPIC  ");
} else {
    mpic = mpic_alloc(NULL, 0,
        MPIC_BIG_ENDIAN |
        MPIC_SINGLE_DEST_CPU,
        0, 256, " OpenPIC  ");
}

in this one

mpic = mpic_alloc(NULL, 0,
    MPIC_BIG_ENDIAN |
    MPIC_SINGLE_DEST_CPU,
    0, 256, " OpenPIC  ");

using "pic-no-reset" in the device tree?

Thanks!

Ciao,
Alessio
