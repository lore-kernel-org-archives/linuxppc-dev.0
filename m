Subject: Re: Powerbook Pismo not waking from sleep with 2.6.4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <hhwu5eupml.fsf@theorie.physik.uni-muenchen.de>
References: <hhwu5eupml.fsf@theorie.physik.uni-muenchen.de>
Content-Type: text/plain
Message-Id: <1079908705.912.152.camel@gaston>
Mime-Version: 1.0
Date: Mon, 22 Mar 2004 09:38:26 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-03-22 at 03:33, Jens Schmalzing wrote:
> Hi,
>
> I've tried to upgrade the kernel to 2.6.4 on my Pismo Powerbook, and
> found that it doesn't sleep properly any more (which it did with
> 2.6.3-ben2).  Rather, the machine falls asleep, and then wakes up to
> some extent: It gets as far as
>
>  mediabay 0 IDE ready
>
> but never reaches the following message

Try this patch

===== drivers/serial/pmac_zilog.c 1.6 vs edited =====
--- 1.6/drivers/serial/pmac_zilog.c	Wed Mar 10 21:18:32 2004
+++ edited/drivers/serial/pmac_zilog.c	Mon Mar 22 09:35:13 2004
@@ -1563,15 +1563,21 @@
 static int pmz_suspend(struct macio_dev *mdev, u32 pm_state)
 {
 	struct uart_pmac_port *uap = dev_get_drvdata(&mdev->ofdev.dev);
-	struct uart_state *state = pmz_uart_reg.state + uap->port.line;
+	struct uart_state *state;
 	unsigned long flags;

-	if (uap == NULL)
+	if (uap == NULL) {
+		printk("HRM... pmz_suspend with NULL uap\n");
 		return 0;
+	}

 	if (pm_state == mdev->ofdev.dev.power_state || pm_state < 2)
 		return 0;

+	pmz_debug("suspend, switching to state %d\n", pm_state);
+
+	state = pmz_uart_reg.state + uap->port.line;
+
 	down(&pmz_irq_sem);
 	down(&state->sem);

@@ -1607,6 +1613,8 @@
 	up(&state->sem);
 	up(&pmz_irq_sem);

+	pmz_debug("suspend, switching complete\n");
+
 	mdev->ofdev.dev.power_state = pm_state;

 	return 0;
@@ -1616,7 +1624,7 @@
 static int pmz_resume(struct macio_dev *mdev)
 {
 	struct uart_pmac_port *uap = dev_get_drvdata(&mdev->ofdev.dev);
-	struct uart_state *state = pmz_uart_reg.state + uap->port.line;
+	struct uart_state *state;
 	unsigned long flags;
 	int pwr_delay;

@@ -1626,6 +1634,10 @@
 	if (mdev->ofdev.dev.power_state == 0)
 		return 0;

+	pmz_debug("resume, switching to state 0\n");
+
+	state = pmz_uart_reg.state + uap->port.line;
+
 	down(&pmz_irq_sem);
 	down(&state->sem);

@@ -1658,6 +1670,7 @@
 		enable_irq(uap->port.irq);
 	}

+ bail:
 	up(&state->sem);
 	up(&pmz_irq_sem);

@@ -1670,7 +1683,8 @@
 		schedule_timeout((pwr_delay * HZ)/1000);
 	}

- bail:
+	pmz_debug("resume, switching complete\n");
+
 	mdev->ofdev.dev.power_state = 0;

 	return 0;


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
