Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 1674BDE274
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 01:36:35 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so842511anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 06 May 2008 08:36:32 -0700 (PDT)
Message-ID: <fa686aa40805060836o519bff20yf2506676ff1c3e6@mail.gmail.com>
Date: Tue, 6 May 2008 09:36:31 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Fabio Tosetto" <tosettofabio83@libero.it>
Subject: Re: MPC5200b MMC over SPI into PSC6
In-Reply-To: <481F4DFD.1000702@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <481F4DFD.1000702@libero.it>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 5, 2008 at 12:12 PM, Fabio Tosetto <tosettofabio83@libero.it> wrote:
> Hello, I have an embedded system with an on-board processor powerpc MPC5200B
>  and Linux kernel 2.6.22,
>  I must turn over to MMC SPI on the PSC6.
>
>  First, I
>  have enabled PSC6:
>
>  in ../arch/ppc/platforms/lite5200.c added PSC6 in SPI mode

You're using arch/ppc which is depreciated.  You should move to using
arch/powerpc (set ARCH=powerpc when compiling).  Devices are then
enabled in the device tree source file
arch/powerpc/boot/dts/lite5200b.dts.

Many things have changed with MPC5200 support in the last year, you
should also use the latest kernel release (2.6.25.2 when it is
released.  If you use 2.6.25.1, then there is a trivial bug in the psc
serial port driver that you'll need to fix.  I'll include the link to
the patch below)

Cheers,
g.

http://ozlabs.org/pipermail/linuxppc-dev/2008-April/055495.html

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
