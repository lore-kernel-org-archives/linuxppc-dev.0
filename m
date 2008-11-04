Return-Path: <r.buergel@unicontrol.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.161])
	by ozlabs.org (Postfix) with ESMTP id 5C97EDDDE3
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 21:44:15 +1100 (EST)
Message-ID: <4910274E.5030305@unicontrol.de>
Date: Tue, 04 Nov 2008 11:43:26 +0100
From: =?ISO-8859-1?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org
Subject: [PATCH V2] workaround for mpc52xx erratum #364 (serial may not be
	reset in break state)
References: <490F51E7.3020309@unicontrol.de>
	<fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
In-Reply-To: <fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------000307040200070009010206"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000307040200070009010206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Grant Likely schrieb:
> On Mon, Nov 3, 2008 at 12:32 PM, René Bürgel <r.buergel@unicontrol.de> wrote:
>   
>> Hi
>>
>> This patch is a workaround for bug #364 found in the MPC52xx processor.
>> The errata document can be found under
>> http://www.freescale.com/files/32bit/doc/errata/MPC5200E.pdf?fpsp=1&WT_TYPE=Errata&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Documentation
>>
>>     
>
> This is an MPC5200 errata.  It doesn't exist on the MPC5200B.  The
> bugfix code should be enabled at runtime only if running on the
> original MPC5200.  You can use the value of the compatible property to
> determine whether or not to enable it.  Optionally you can further
> reduce impact by checking if CONFIG_PPC_MPC5200_BUGFIX is defined.
>
>   
This bug is definetly present on the MPC5200B, although it is not listed 
in the errata sheet. I've had the ability to test it. We have custom 
boards using CPU modules from TQ with both processor versions, MPC5200 
and MPC5200B. Both versions show exactly the same behaviour and the 
patch fixes it.

But as the serial driver is also used for the MPC5121, we may have to 
distinguish anyway. Does anyone have the possibility to test if the bug 
in still present  on MPC5121?
I disabled the bugfix on MPC5121-processors.
>> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
>> index 6117d3d..929524b 100644
>> --- a/drivers/serial/mpc52xx_uart.c
>> +++ b/drivers/serial/mpc52xx_uart.c
>> @@ -496,6 +496,27 @@ mpc52xx_uart_break_ctl(struct uart_port *port, int ctl)
>>        spin_unlock_irqrestore(&port->lock, flags);
>>  }
>>
>> +/* macro with helper macros to safely reset rx which mustn't be done in
>> break state.
>> + * This is a workaround for processor bug #364 described in MPC5200 (L25R)
>> Errata.
>> + *
>> + * The workaround resets the baudrate to 4800, waits for a stable state and
>> resets break state repeatedly if necessary
>> + * optionally it can release the lock while waiting.
>> + * 1 character at 4800 baud takes 2ms, 3ms should be enough for 1 character
>> at higher speed and 1 char at lowest
>> + * works only with longer delays
>> + */
>> +#define LOCK(code) code
>> +#define DONT_LOCK(code)
>> +#define mpc52xx_uart_reset_rx(LOCK)
>>                    \
>> +       out_8(&psc->ctur,0x01);
>>                     \
>> +       out_8(&psc->ctlr,0xae);
>>                     \
>> +       do {
>>                    \
>> +               out_8(&psc->command,MPC52xx_PSC_RST_ERR_STAT);
>>                    \
>> +               LOCK(disable_irq(port->irq);
>> spin_unlock_irqrestore(&port->lock, flags));       \
>> +               mdelay(10);
>>                     \
>> +               LOCK(spin_lock_irqsave(&port->lock, flags);
>> enable_irq(port->irq));             \
>> +       } while ((in_be16(&psc->mpc52xx_psc_status)) & MPC52xx_PSC_SR_RB);
>>                    \
>> +       out_8(&psc->command,MPC52xx_PSC_RST_RX);
>> +
>>     
>
> ick.  ugly.  Don't mess about with a macro here, just write a
> function.  Let the compiler decide if it should be inlined.
>
> g.
>
>   
The purpose of the macro wasn't to enforce inlining, but to enhance the 
readability of the call and to ensure, that the was no runtime-check 
needed to decide whether the lock has to be hold or may be released. I'd 
like to avoid the runtime-checking here Anyway, i transformed the macro 
into a function like suggested. Any  proposals on this are welcome :)

-- 
René Bürgel
Software Engineer
Unicontrol Systemtechnik GmbH
OT Dittersbach
Sachsenburger Weg 34
09669 Frankenberg
 
Tel.: 03 72 06/ 88 73 - 19
Fax: 03 72 06/ 88 73 - 60
E-Mail: r.buergel@unicontrol.de
Internet: www.unicontrol.de
 
Unicontrol Systemtechnik GmbH
Geschäftsführer: Dipl.-Ing. Siegfried Heinze
Sitz der Gesellschaft: Frankenberg
Registergericht: Amtsgericht Chemnitz, HRB 15 475



--------------000307040200070009010206
Content-Type: text/plain;
 name="123-mpc52xx_erratum_364.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="123-mpc52xx_erratum_364.patch"

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 6117d3d..6af51b8 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -496,6 +496,37 @@ mpc52xx_uart_break_ctl(struct uart_port *port, int ctl)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+/* macro with helper macros to safely reset rx which mustn't be done in break state.
+ * This is a workaround for processor bug #364 described in MPC5200 (L25R) Errata.
+ *
+ * The workaround resets the baudrate to 4800, waits for a stable state and resets break state repeatedly if necessary.
+ * Optionally it can release the lock while waiting.
+ * 1 character at 4800 baud takes 2ms, 3ms should be enough for 1 character at higher speed and 1 char at lowest
+ * works only with longer delays
+ */
+
+static void mpc52xx_uart_reset_rx(struct uart_port *port, int unlock, unsigned long flags)
+{
+	struct mpc52xx_psc __iomem *psc = PSC(port);
+#ifdef CONFIG_PPC_MPC52xx
+	out_8(&psc->ctur,0x01);
+	out_8(&psc->ctlr,0xae);
+	do {
+		out_8(&psc->command,MPC52xx_PSC_RST_ERR_STAT);
+		if (unlock) {
+			disable_irq(port->irq);
+			spin_unlock_irqrestore(&port->lock, flags);
+		}
+		mdelay(10);
+		if (unlock) {
+			spin_lock_irqsave(&port->lock, flags);
+			enable_irq(port->irq);
+		}
+	} while ((in_be16(&psc->mpc52xx_psc_status)) & MPC52xx_PSC_SR_RB);
+#endif
+	out_8(&psc->command,MPC52xx_PSC_RST_RX);
+}
+
 static int
 mpc52xx_uart_startup(struct uart_port *port)
 {
@@ -510,7 +541,7 @@ mpc52xx_uart_startup(struct uart_port *port)
 		return ret;
 
 	/* Reset/activate the port, clear and enable interrupts */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	mpc52xx_uart_reset_rx(port, false, 0);
 	out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
 	out_be32(&psc->sicr, 0);	/* UART mode DCD ignored */
@@ -529,7 +560,7 @@ mpc52xx_uart_shutdown(struct uart_port *port)
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 
 	/* Shut down the port.  Leave TX active if on a console port */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	mpc52xx_uart_reset_rx(port, false, 0);
 	if (!uart_console(port))
 		out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
@@ -588,9 +619,6 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	/* Get the lock */
 	spin_lock_irqsave(&port->lock, flags);
 
-	/* Update the per-port timeout */
-	uart_update_timeout(port, new->c_cflag, baud);
-
 	/* Do our best to flush TX & RX, so we don't loose anything */
 	/* But we don't wait indefinitly ! */
 	j = 5000000;	/* Maximum wait */
@@ -607,9 +635,12 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 			"Some chars may have been lost.\n");
 
 	/* Reset the TX & RX */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	mpc52xx_uart_reset_rx(port, true, flags);
 	out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
+	/* Update the per-port timeout */
+	uart_update_timeout(port, new->c_cflag, baud);
+
 	/* Send new mode settings */
 	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
 	out_8(&psc->mode, mr1);

--------------000307040200070009010206--
