Return-Path: <srs0=7foq=lm=buserror.net=oss@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420xGV3gHtzF35q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 05:56:50 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 420xGV32Ktz8w0l
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 05:56:50 +1000 (AEST)
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 420xGT60kgz9ryn
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2018 05:56:49 +1000 (AEST)
Message-ID: <8ca7e76b239a14e322f00cd1a0eac141472ab2bd.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: sgosavi1 <Sachin.Gosavi@emerson.com>, linuxppc-dev@ozlabs.org
Date: Wed, 29 Aug 2018 14:16:23 -0500
In-Reply-To: <1535541276673-0.post@n7.nabble.com>
References: <1535541276673-0.post@n7.nabble.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Not able to boot cuImage for the target board with MPC8270
 processor
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-08-29 at 04:14 -0700, sgosavi1 wrote:
> Press <foo> to STOP AUTOBOOT!:autoboot in 2 seconds
> ## Booting image at ffc00000 ...
>    Image Name:   Linux-4.15.13
>    Created:      2018-08-29  10:45:39 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1166748 Bytes =  1.1 MB
>    Load Address: 00400000
>    Entry Point:  004007a4
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> 
> 
> I also checked the kernel dump at location associated with "_log_buf" symbol
> in the System.map file in RAM but did not get any debug info.

If you didn't get any output beyond this then it's probably[1] failing in the
bootwrapper, not the kernel itself -- so neither _log_buf nor
CONFIG_PPC_EARLY_DEBUG would help.

> Please can anyone suggest if I am missing something here and how can I get
> the debug output on my serial console during bootup.

To debug, if you aren't able to use JTAG, add code to the bootwrapper to
manually poke at known CPM serial addresses early on, to see how far it's
progressing.

Are you sure the device tree you're using is correct for your board, including
all addresses being where your U-Boot configured them?

-Scott

[1] Another possibility would be that it's booting, but serial output isn't
working.
