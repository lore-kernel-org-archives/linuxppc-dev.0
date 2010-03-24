Return-Path: <vitalywool@gmail.com>
Received: from mail-fx0-f224.google.com (mail-fx0-f224.google.com
	[209.85.220.224]) by ozlabs.org (Postfix) with ESMTP id 26395B7CEE
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 21:03:09 +1100 (EST)
Received: by fxm24 with SMTP id 24so1992931fxm.23
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 03:03:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100323194401.0B7724C022@gemini.denx.de>
References: <4BA865D4.1090403@freemail.hu>
	<20100323194401.0B7724C022@gemini.denx.de>
Date: Wed, 24 Mar 2010 13:03:05 +0300
Message-ID: <acd2a5931003240303r22fb2deat722b39e7f0d9a3dd@mail.gmail.com>
Subject: Re: Linux patches for XIP on MPC8xx?
From: Vitaly Wool <vitalywool@gmail.com>
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Wolfgang Grandegger <wg@denx.de>,
	=?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> There were very few tests done with later kernel versions, and in all
> practical system configurations we tested we found that XIP did not
> give real benefits. Usually execution from flash was slower than when
> running from RAM, and even booting a (inevitably uncompressed) kernel
> from flash is typically slower than loading a compressed image to RUM
> and booting from there.

at some point we were testing some hybrid approaches for XIP and that
gave some nice results.

First of all, the kernel should not necessarily be uncompressed.
Because .data and friend sections are copied to RAM anyway, you can
compress them.

Besides, we had the "weird" XIP kernel version with only run-once code
run as XIP (like .initdata), copying the rest of kernel to RAM in the
background while initializing things, and it was really fast and
didn't produce performance penalty on the further execution.

> So except for some highly specialized applications (you may also call
> these "exotic" configurations) XIP for the Linux kernel does not make
> much sense to me.

Well, I'd put it this way: plain XIP usage is obsolete in the most
cases, but the idea is still viable if you apply it right :)

Thanks,
   Vitaly
