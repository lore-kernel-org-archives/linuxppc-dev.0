Return-Path: <bmeng.cn@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 23F8DB70F8
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2010 16:26:06 +1100 (EST)
Received: by iwn37 with SMTP id 37so1005498iwn.15
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Oct 2010 22:26:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CBB4D80.3030007@extricom.com>
References: <4CADBD7B.3000506@extricom.com> <1286756363.2463.517.camel@pasglop>
	<4CB2E517.8020401@extricom.com> <1286796721.5220.2.camel@pasglop>
	<4CBB4D80.3030007@extricom.com>
Date: Mon, 18 Oct 2010 13:26:02 +0800
Message-ID: <AANLkTiky_xyJtFmeyuVzw+aaa6rWYB3hWajXWsjkhkOK@mail.gmail.com>
Subject: Re: Freescale P2020 CPU Freeze over PCIe abort signal
From: Bin Meng <bmeng.cn@gmail.com>
To: Eran Liberty <liberty@extricom.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 18, 2010 at 3:24 AM, Eran Liberty <liberty@extricom.com> wrote:
<snip>

> In P2020 if I do any of those the CPU is left hung over the transaction.
>
> something like:
> in_le32(addr)
>
> is turned into:
> 7c 00 04 ac =A0 =A0 sync =A0 7c 00 4c 2c =A0 =A0 lwbrx =A0 r0,0,r9
> 0c 00 00 00 =A0 =A0 twi =A0 =A0 0,r0,0
> 4c 00 01 2c =A0 =A0 isync
>
> assembly code, where in r9 (in this example) hold an address which is
> physically mapped into the PCIe resource space.
>
> The CPU will hang over the load instruction.
>
> Just for the fun of it, I have wrote my own assembly function omitting
> everything but the load instruction; still freeze.
> Replace "lwbrx" with a simple "lwz"; still freeze.
>
> It looks like the CPU snoozes till the PCIe transaction is done with no
> timeouts, ignoring any abort signal.
>

It sounds like a similar issue I got with the 83xx PCIe host controller.

If there is no valid link established under the PCIe host controller
(ie: no device connected), or the device under the PCIe host
controller does not respond the configuration access correctly,
the host will hang at the instruction of "lwz" when trying to access
the PCIe configuration space (in 83xx, it's memory mapped)

And I remember the same issue exists in 8548, not sure if it is fixed in P2=
020.

<snip>

Bin

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
