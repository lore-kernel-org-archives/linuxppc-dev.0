Return-Path: <ningmin@yahoo.co.jp>
Received: from web606.mail.yahoo.co.jp (web606.mail.yahoo.co.jp [211.14.15.80])
	by ozlabs.org (Postfix) with SMTP id 3BC6467AA2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Jan 2005 21:02:40 +1100 (EST)
Message-ID: <20050128100238.27631.qmail@web606.mail.yahoo.co.jp>
Date: Fri, 28 Jan 2005 19:02:38 +0900 (JST)
From: ning <ningmin@yahoo.co.jp>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <41F602F8.1090007@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
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

Hello,Vitaly

Thanks for your reply.

I added SCC4 to rs_table as following:
static struct serial_state rs_table[] = {
	/* UART CLK   PORT          IRQ      FLAGS  NUM */
	{ 0,     0, PROFF_SCC1, SIU_INT_SCC1,   0,   (0 |
NUM_IS_SCC) }, /* SCC1 ttyS0 */
	{ 0,     0, PROFF_SCC4, SIU_INT_SCC4,   0,   (3 |
NUM_IS_SCC) }, /* SCC4 ttyS1 */
};

ttyS0,ttyS1 work as COM port,but linux boot log only is
outputed at ttyS0,how can I redirect it at ttyS1?
After linux boots successfully,linux prompt will display
at ttyS1,and I use it normally.
(u-boot parameter: setenv bootargs root=/dev/nfs rw
console=ttyS1,115200n8
rootfs: /dev/console --> ttyS1)

at \arch\ppc\boot\simple\m8260_tty.c,Even if I define
SCC_CONSOLE to 4,Linux boot log is outputed at ttyS0.
the following  comment is written at m8260_tty.c:

/* If defined, enables serial console.  The value (1
through 4) should designate which SCC is used, but this
isn't complete.  Only SCC1 is known to work at this time.
*/

#ifdef CONFIG_SCC_CONSOLE
#define SCC_CONSOLE 4
#endif


Maybe it is true.

--- Vitaly Bordug <vvv75@yandex.ru> からのメッセージ：
> Ning,
> Well, AFAIK the serial console on the second UART
> (and second UART on 
> SCC4 as well) haven't been included yet to the
> community tree. To be 
> sure you can take a look in the 8260_io/uart.c where
> in rs_table 
> structure second entry should be {0, 0, PROFF_SCC4
> ... Implementation is 
> not that hard, you need only make proper mentioned
> entry, enable 
> transceiver (BCSR+4), and program parallel port pins
> (take a look at 
> chapter 37 of MPC8272 reference manual, grep for
> SCC4).
> 
> --
> Regards, Vitaly

__________________________________
Let's Celebrate Together!
Yahoo! JAPAN
http://pr.mail.yahoo.co.jp/so2005/
