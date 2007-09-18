Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by ozlabs.org (Postfix) with ESMTP id 3701CDDE24
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 00:01:22 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1459599rvf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Sep 2007 07:01:21 -0700 (PDT)
Message-ID: <fa686aa40709180701w17273a11wda8c9ece79aad483@mail.gmail.com>
Date: Tue, 18 Sep 2007 08:01:20 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Leopold Stotch" <l.butterz@gmail.com>
Subject: Re: PSC in UART mode on TQM5200S
In-Reply-To: <53b5d6e90709180313n7ef053ddqfb771f44d9bd44ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <53b5d6e90709180313n7ef053ddqfb771f44d9bd44ef@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/18/07, Leopold Stotch <l.butterz@gmail.com> wrote:
> Hello, everyone !
>
> I have TQM5200S module and development board.
> It runs factory UBoot and latest DENX's linuxppc_2_4_devel kernel.
> I want to configure all TQM5200S's onboard PSC's as UART's.
>  TQM5200S's onboard PSC's are connected to custom board
>  that makes all electrical things as my hardware engineer says...
> So changed
> $HOME/linuxppc_2_4_devel/arch/ppc/platforms/tqm5200.h
> the following way:
>
> #ifdef CONFIG_PS2MULT
> #define RS_TABLE_SIZE  4
> #else
> #if defined(CONFIG_SPI_EVAL) || defined(CONFIG_TB5200)
> #define RS_TABLE_SIZE  2
> #elif defined(CONFIG_CAM5200)
> #define RS_TABLE_SIZE  6
> #else
> #define RS_TABLE_SIZE  3
> #endif
> #endif
>
> changed to
>
> #ifdef CONFIG_PS2MULT
> #define RS_TABLE_SIZE  4
> #else
> #if defined(CONFIG_SPI_EVAL) || defined(CONFIG_TB5200)
> #define RS_TABLE_SIZE  2
> #elif defined(CONFIG_CAM5200)
> #define RS_TABLE_SIZE  6
> #else
> #define RS_TABLE_SIZE  6
> #endif
> #endif
>
> and
>
> #else /* default */
> #define SERIAL_PORT_DFNS    \
>     STD_PSC_OP(1)        \
>     STD_PSC_OP(2)        \
>     STD_PSC_OP(3)
> #endif
>
> changed to
>
> #else /* default */
> #define SERIAL_PORT_DFNS    \
>     STD_PSC_OP(1)        \
>     STD_PSC_OP(2)        \
>     STD_PSC_OP(3)        \
>     STD_PSC_OP(4)        \
>     STD_PSC_OP(5)        \
>     STD_PSC_OP(6)
> #endif
>
> After rebuilding the kernel, dmesg says:
>
> ...
> ttyS0 on PSC1
> ttyS1 on PSC2
> ttyS2 on PSC3
> ttyS3 on PSC4
> ttyS4 on PSC5
> ttyS5 on PSC6
> ...
>
> But when i do "echo 1 > /dev/ttyS4" i receive nothing at the other end.

Have you made the appropriate changes to the port_config register?

Cheers,
g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
