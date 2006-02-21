Return-Path: <mathieu.deschamps@com2gether.net>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by ozlabs.org (Postfix) with ESMTP id CCB69679E9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Feb 2006 19:57:05 +1100 (EST)
From: Mathieu Deschamps <mathieu.deschamps@com2gether.net>
Subject: Uart on cpm2_io (was: Using modem signal in cpm2 uart for MPC8270)
Date: Tue, 21 Feb 2006 09:58:06 +0100
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-Id: <200602210954.51248.mathieu.deschamps@com2gether.net>
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

Sorry to come with this UART issue again but I had no answer and no
better idea but asking people who knows 82xx uart well, people who 
designed it. 

My issue about this uart could be approched elseway : why is there a 
modem_control conditionnal compilation option when PQ2 SCCs 
(in normal operation mode which is default) take care of CTS,CD signals
(Chap 20-8 GSMR_L register DIAG MPC8280 PQ2 Ref. Manual ) ?

I fell like that is clearly a design-time choice matter that I need to 
clarify.

And simply : 
Is this version is known to be broken when activating this option ? 

Please let me know your thoughts on this, it is very valuable to me, 
thanks.

Best Regards,
Mathieu

----------  Forwarded Message  ----------

Subject: Using modem signal in cpm2 uart for MPC8270
Date: Friday 17 February 2006 11:12
From: Mathieu Deschamps <mathieu.deschamps@com2gether.net>
To: linuxppc-embedded@ozlabs.org

Hello ppc-embedded folks,

I'am looking for a hint in arch/ppc/cpm2_io/uart.c on enable modem signal
handling on MontaVista Linux 2.4.20. I know it's a bit ancient but some of
you may have a good memory :) I mentionned enabling modem signal because this
file seems to support modem, yet I come to the conclusion it is incomplete.

In void rs_8xx_interrupt function I've noticed it needs 'modem_control'
defined to get the call done and modem lines changed on interrup(1). Also it
needs defined 'notdef' to implement this code(2).

===(1)
#ifdef modem_control
        check_modem_status(info);
#endif
===(2)
#ifdef notdef
        /* I need to do this for the SCCs, so it is left as a reminder.
        */
static _INLINE_ void check_modem_status(struct async_struct *info)
{
 [...]
}
#endif
===

Having this done is not sufficient, a lot of registers defined in
linux/serial_reg.h are reported missing. I have included this file, yet
other functions are missing, struct members also.
Here is compilation output :
===========================
uart.c: In function `check_modem_status':
uart.c:603: warning: implicit declaration of function `serial_in'
uart.c:638: error: structure has no member named `tqueue_hangup'
uart.c:650: warning: implicit declaration of function `serial_out'
uart.c:651: warning: passing arg 1 of `rs_sched_event' from incompatible
pointer type
uart.c: In function `rs_8xx_interrupt':
uart.c:709: warning: passing arg 1 of `check_modem_status' from incompatible
pointer type
uart.c: In function `startup':
uart.c:813: error: structure has no member named `MCR'
uart.c:815: error: structure has no member named `MCR'
uart.c: In function `change_speed':
uart.c:993: error: structure has no member named `IER'
uart.c:995: error: structure has no member named `IER'
uart.c:998: error: structure has no member named `IER'
uart.c:1005: error: structure has no member named `IER'
uart.c:1007: error: structure has no member named `IER'
uart.c: In function `rs_8xx_throttle':
uart.c:1255: error: structure has no member named `MCR'
uart.c:1258: error: structure has no member named `MCR'
uart.c: In function `rs_8xx_unthrottle':
uart.c:1284: error: structure has no member named `MCR'
uart.c:1286: error: structure has no member named `MCR'
uart.c: In function `get_modem_info':
uart.c:1327: error: structure has no member named `MCR'
uart.c: In function `set_modem_info':
uart.c:1358: error: structure has no member named `MCR'
uart.c:1360: error: structure has no member named `MCR'
uart.c:1363: error: structure has no member named `MCR'
uart.c:1365: error: structure has no member named `MCR'
uart.c:1370: error: structure has no member named `MCR'
uart.c:1372: error: structure has no member named `MCR'
uart.c:1375: error: structure has no member named `MCR'
uart.c:1377: error: structure has no member named `MCR'
uart.c:1381: error: structure has no member named `MCR'
uart.c:1381: error: structure has no member named `MCR'
uart.c:1398: error: structure has no member named `MCR'
uart.c: In function `begin_break':
uart.c:1417: warning: comparison is always false due to limited range of data
type
uart.c: In function `end_break':
uart.c:1461: warning: comparison is always false due to limited range of data
type
uart.c: In function `rs_8xx_ioctl':
uart.c:1600: error: `cprev' undeclared (first use in this function)
uart.c:1600: error: (Each undeclared identifier is reported only once
uart.c:1600: error: for each function it appears in.)
uart.c:1603: error: structure has no member named `delta_msr_wait'
uart.c: In function `rs_8xx_set_termios':
uart.c:1670: error: structure has no member named `MCR'
uart.c:1672: error: structure has no member named `MCR'
uart.c:1679: error: structure has no member named `MCR'
uart.c:1682: error: structure has no member named `MCR'
uart.c:1685: error: structure has no member named `MCR'
uart.c: In function `rs_8xx_wait_until_sent':
uart.c:1839: warning: unused variable `lsr'
=======

I wonder if modem support is incomplete or even if it was dropped in here but
was conceived for another arch .

Looking forward to read your inputs.


Best regards,


Mathieu Deschamps

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

-------------------------------------------------------
