Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Disabling the serial console upsets CPM UARTS
Date: Thu, 5 Aug 2004 09:34:19 +1200
Message-ID: <A3240F62EF3C2749B1A25D3BC9548F4148BC29@ExchWENZ02.wenz.global.vpn>
From: "Richard Williams" <richard_williams@stratexnet.com>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have seen some questions in the archive about people wanting to disable the serial console but not many answers.

We have a custom 860T product running a modified 2.4.4 kernel. The console was disabled by excluding some code in printk.c and this has resulted in strange effects with the CPM UART driver.
#undef ENABLE_SERIAL_CONSOLE
#ifdef ENABLE_SERIAL_CONSOLE
	if( preferred_console < 0 )
    {
		if( console->index < 0 )
        {
			console->index = 0;
        }

		if(( console->setup == NULL ) || ( console->setup( console, NULL ) == 0 ))
        {
			console->flags |= CON_ENABLED;
			console->flags |= CON_CONSDEV;
			preferred_console = 0;
		}
	}
#endif

Disabling the console meant that serial_console_setup() is not called before rs_8xx_init() and according to the comments in uart.c, this is bad. The CPM UART's were initialised while the u-boot enabled UART was still operational. The BD's used by the u-boot enabled UART were allocated to another SMC and this caused problems when this UART was intialised (The tx buffer pointer got out of sync with the rx buffer pointer and we received characters out of order).

I tried disabling the u-boot enabled serial port before rs_8xx_init() is called and this seemed to fix the problem, until now. Another problem has cropped up (with pppd) where closing a CPM UART port causes all the other CPM UARTS's to freeze until it is opened again. Re-enabling the serial console makes the problem go away.

My questions are
1. Is there a better way to disable the serial console (or even better, allow the kernel parameter 'console=' to switch it on of off)?

2. If the console port can be changed by the 'console=' parameter, what is the purpose of the compile time configuration and selection of a console port in uart.c?

Regards,
Richard

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
