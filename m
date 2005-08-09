Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 4E94767F99
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 02:18:06 +1000 (EST)
Date: Tue, 9 Aug 2005 09:18:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Message-ID: <20050809161801.GK3187@smtp.west.cox.net>
References: <JPEALJAFNGDDLOPNDIEEKEALDFAA.joakim.tjernlund@lumentis.se>
	<20050808130523.GF5210@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050808130523.GF5210@cathedrallabs.org>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Volunteers to test i2c-algo-8xx on v2.6?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Aug 08, 2005 at 10:05:23AM -0300, Aristeu Sergio Rozanski Filho wrote:
> Hi,
> > I have done this for cpm_iic_read, cpm_iic_write and cpm_iic_try_address.
> > Also note the the addition of "| 0x01" to i2c->i2c_i2com.
> the updated patch is attached, thanks Joakim.
> seems Debora need this too for 2.4 version. Debora, could you please
> generate a diff against latest Wolfgang's development tree and submit to
> him?

I've tested this version with my cheesy sttm reader on an rpxlite, and
with the following, things work:

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

diff --git a/drivers/i2c/busses/i2c-rpx.c b/drivers/i2c/busses/i2c-rpx.c
--- a/drivers/i2c/busses/i2c-rpx.c
+++ b/drivers/i2c/busses/i2c-rpx.c
@@ -55,17 +55,7 @@ rpx_iic_init(struct i2c_algo_8xx_data *d
 	data->i2c = (i2c8xx_t *)&(((immap_t *)IMAP_ADDR)->im_i2c);
 }
 
-static int rpx_install_isr(int irq, void (*func)(void *, void *), void *data)
-{
-	/* install interrupt handler */
-	cpm_install_handler(irq, (void (*)(void *, struct pt_regs *)) func, data);
-
-	return 0;
-}
-
-static struct i2c_algo_8xx_data rpx_data = {
-	.setisr = rpx_install_isr
-};
+static struct i2c_algo_8xx_data rpx_data;
 
 static struct i2c_adapter rpx_ops = {
 	.owner		= THIS_MODULE,

-- 
Tom Rini
http://gate.crashing.org/~trini/
