Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 1291BDDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Apr 2008 15:15:36 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so603712anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 01 Apr 2008 21:15:35 -0700 (PDT)
Message-ID: <fa686aa40804012115oe92ed1ald314b25cfaa5805@mail.gmail.com>
Date: Tue, 1 Apr 2008 22:15:35 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marcelo Dalmas" <m_dalmas@yahoo.com.br>
Subject: Re: mpc52xx_mmap_ctl access
In-Reply-To: <132281.10315.qm@web50302.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <132281.10315.qm@web50302.mail.re2.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Apr 1, 2008 at 11:03 AM, Marcelo Dalmas <m_dalmas@yahoo.com.br> wrote:
> Hi all!
>
>  I'm updating a device driver from linux 2.6.16 ppc
>  tree to linux 2.6.24 powerpc in a lite5200 based
>  board.
>
>  I need to access  mpc52xx_mmap_ctl and mpc52xx_cslpc.
>
>  In ppc tree I do:
>
>   mmap_ctl =
>  ioremap(MPC52xx_PA(MPC52xx_MMAP_CTL_OFFSET),
>                      MPC52xx_MMAP_CTL_SIZE)
>
>  How can I access it in powerpc tree?

1) In your device tree, add a new node for the local plus bus control
registers with the correct base address.
2) Use of_find_compatible_node() to get a pointer to the node in your
platform init code.
3) Use of_iomap() to map the registers into the kernel address space.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
