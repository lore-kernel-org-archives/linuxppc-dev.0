Return-Path: <vitaly_@f-m.fm>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 358A067A74
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Feb 2005 04:17:30 +1100 (EST)
Message-ID: <41FFB816.1070904@f-m.fm>
Date: Tue, 01 Feb 2005 20:10:46 +0300
From: Vitaly Bordug <vitaly_@f-m.fm>
MIME-Version: 1.0
To: ning <ningmin@yahoo.co.jp>
References: <20050128100238.27631.qmail@web606.mail.yahoo.co.jp>
In-Reply-To: <20050128100238.27631.qmail@web606.mail.yahoo.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Serial console problem on MPC8272ADS board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ning wrote:

>Hello,Vitaly
>
>Thanks for your reply.
>
>I added SCC4 to rs_table as following:
>static struct serial_state rs_table[] = {
>	/* UART CLK   PORT          IRQ      FLAGS  NUM */
>	{ 0,     0, PROFF_SCC1, SIU_INT_SCC1,   0,   (0 |
>NUM_IS_SCC) }, /* SCC1 ttyS0 */
>	{ 0,     0, PROFF_SCC4, SIU_INT_SCC4,   0,   (3 |
>NUM_IS_SCC) }, /* SCC4 ttyS1 */
>};
>
>ttyS0,ttyS1 work as COM port,but linux boot log only is
>outputed at ttyS0,how can I redirect it at ttyS1?
>After linux boots successfully,linux prompt will display
>at ttyS1,and I use it normally.
>(u-boot parameter: setenv bootargs root=/dev/nfs rw
>console=ttyS1,115200n8
>rootfs: /dev/console --> ttyS1)
>
>at \arch\ppc\boot\simple\m8260_tty.c,Even if I define
>SCC_CONSOLE to 4,Linux boot log is outputed at ttyS0.
>the following  comment is written at m8260_tty.c:
>
>/* If defined, enables serial console.  The value (1
>through 4) should designate which SCC is used, but this
>isn't complete.  Only SCC1 is known to work at this time.
>*/
>
>#ifdef CONFIG_SCC_CONSOLE
>#define SCC_CONSOLE 4
>#endif
>
>
>Maybe it is true.
>  
>
Well, I can only advice to try linuxppc_2_4 or -2.4 repositories, adding
bits to support SCC4 console and so on...
--
Regards,

Vitaly
