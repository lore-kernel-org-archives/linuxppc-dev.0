Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 54228DDED2
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 02:58:11 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so620241wag
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 07:58:10 -0800 (PST)
Message-ID: <9e4733910711250758i64e1f0abo3916cabd6ef33102@mail.gmail.com>
Date: Sun, 25 Nov 2007 10:58:10 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH revised 3/4] powerpc: Add EXPORT_SYMBOL_GPL for symbols
	required by fs_enet and cpm_uart
In-Reply-To: <47499711.2020409@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4745BDC9.3080602@scram.de> <47499711.2020409@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/25/07, Timur Tabi <timur@freescale.com> wrote:
> Jochen Friedrich wrote:
> > fs_enet and cpm_uart need symbols from commproc.c (for CPM1) or
> > cpm2_common.c. Add EXPORT_SYMBOL_GPL for cpmp, cpm_setbrg and cpm2_immr,
> > so the drivers can be compiled as modules.
>
> Maybe this is a stupid question, but why did you choose EXPORT_SYMBOL_GPL and
> not EXPORT_SYMBOL?

By marking all new exports EXPORT_SYMBOL_GPL it stops new closed
source device drivers from being built. We have to live the the
existing ones, but we certainly don't want to encourage any more to be
built.

Over on lkml there is a thread about moving all symbols of this type
into private name spaces and removing the exports in the final kernel
binary.

>
> --
> Timur Tabi
> Linux Kernel Developer @ Freescale
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Jon Smirl
jonsmirl@gmail.com
