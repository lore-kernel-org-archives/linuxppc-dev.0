Return-Path: <l.butterz@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id 2E274DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Sep 2007 20:13:30 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so4192987pyi
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Sep 2007 03:13:29 -0700 (PDT)
Message-ID: <53b5d6e90709180313n7ef053ddqfb771f44d9bd44ef@mail.gmail.com>
Date: Tue, 18 Sep 2007 14:13:28 +0400
From: "Leopold Stotch" <l.butterz@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: PSC in UART mode on TQM5200S
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_15980_20179774.1190110408517"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_15980_20179774.1190110408517
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, everyone !

I have TQM5200S module and development board.
It runs factory UBoot and latest DENX's linuxppc_2_4_devel kernel.
I want to configure all TQM5200S's onboard PSC's as UART's.
TQM5200S's onboard PSC's are connected to custom board
that makes all electrical things as my hardware engineer says...
So changed $HOME/linuxppc_2_4_devel/arch/ppc/platforms/tqm5200.h
the following way:

#ifdef CONFIG_PS2MULT
#define RS_TABLE_SIZE  4
#else
#if defined(CONFIG_SPI_EVAL) || defined(CONFIG_TB5200)
#define RS_TABLE_SIZE  2
#elif defined(CONFIG_CAM5200)
#define RS_TABLE_SIZE  6
#else
#define RS_TABLE_SIZE  3
#endif
#endif

changed to

#ifdef CONFIG_PS2MULT
#define RS_TABLE_SIZE  4
#else
#if defined(CONFIG_SPI_EVAL) || defined(CONFIG_TB5200)
#define RS_TABLE_SIZE  2
#elif defined(CONFIG_CAM5200)
#define RS_TABLE_SIZE  6
#else
#define RS_TABLE_SIZE  6
#endif
#endif

and

#else /* default */
#define SERIAL_PORT_DFNS    \
    STD_PSC_OP(1)        \
    STD_PSC_OP(2)        \
    STD_PSC_OP(3)
#endif

changed to

#else /* default */
#define SERIAL_PORT_DFNS    \
    STD_PSC_OP(1)        \
    STD_PSC_OP(2)        \
    STD_PSC_OP(3)        \
    STD_PSC_OP(4)        \
    STD_PSC_OP(5)        \
    STD_PSC_OP(6)
#endif

After rebuilding the kernel, dmesg says:

...
ttyS0 on PSC1
ttyS1 on PSC2
ttyS2 on PSC3
ttyS3 on PSC4
ttyS4 on PSC5
ttyS5 on PSC6
...

But when i do "echo 1 > /dev/ttyS4" i receive nothing at the other end.

The questions are:

Is it possible to reconfigure all PSC's as UART's ?
Should i change something in UBoot or everything i did was wrong ?

P.S. Sorry for my poor english and newbie questions :-)

-- 
Best regards,
Leopold Stotch

------=_Part_15980_20179774.1190110408517
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, everyone !<br><br>I have TQM5200S module and development board.<br>It runs factory UBoot and latest DENX&#39;s linuxppc_2_4_devel kernel.<br>I want to configure all TQM5200S&#39;s onboard PSC&#39;s as UART&#39;s.<br>
TQM5200S&#39;s onboard PSC&#39;s are connected to custom board<br>
that makes all electrical things as my hardware engineer says...<br>So changed $HOME/linuxppc_2_4_devel/arch/ppc/platforms/tqm5200.h<br>the following way:<br><br>#ifdef CONFIG_PS2MULT<br>#define RS_TABLE_SIZE&nbsp; 4<br>#else
<br>#if defined(CONFIG_SPI_EVAL) || defined(CONFIG_TB5200)<br>#define RS_TABLE_SIZE&nbsp; 2<br>#elif defined(CONFIG_CAM5200)<br>#define RS_TABLE_SIZE&nbsp; 6<br>#else<br>#define RS_TABLE_SIZE&nbsp; 3<br>#endif<br>#endif<br><br>changed to 
<br><br>#ifdef CONFIG_PS2MULT<br>#define RS_TABLE_SIZE&nbsp; 4<br>#else<br>#if defined(CONFIG_SPI_EVAL) || defined(CONFIG_TB5200)<br>#define RS_TABLE_SIZE&nbsp; 2<br>#elif defined(CONFIG_CAM5200)<br>#define RS_TABLE_SIZE&nbsp; 6<br>#else
<br>#define RS_TABLE_SIZE&nbsp; 6<br>#endif<br>#endif<br><br>and <br><br>#else /* default */<br>#define SERIAL_PORT_DFNS&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp; STD_PSC_OP(1)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp; STD_PSC_OP(2)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp; STD_PSC_OP(3)<br>#endif<br><br>changed to
<br><br>#else /* default */<br>#define SERIAL_PORT_DFNS&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp; STD_PSC_OP(1)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp; STD_PSC_OP(2)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp; STD_PSC_OP(3)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp; STD_PSC_OP(4)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp; STD_PSC_OP(5)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp; STD_PSC_OP(6)
<br>#endif<br><br>After rebuilding the kernel, dmesg says:<br><br>...<br>ttyS0 on PSC1<br>ttyS1 on PSC2<br>ttyS2 on PSC3<br>ttyS3 on PSC4<br>ttyS4 on PSC5<br>ttyS5 on PSC6<br>...<br><br>But when i do &quot;echo 1 &gt; /dev/ttyS4&quot; i receive nothing at the other end.
<br><br>The questions are:<br><br>Is it possible to reconfigure all PSC&#39;s as UART&#39;s ?<br>Should i change something in UBoot or everything i did was wrong ?<br><br>P.S. Sorry for my poor english and newbie questions :-)
<br><br>-- <br>Best regards,<br>Leopold Stotch

------=_Part_15980_20179774.1190110408517--
