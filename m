Message-ID: <294FD9D3403A0340BDAC38E48DCEFFDCA83C@RES-EXCH>
From: Lokesh Kumar <kumar.lokesh@wrx-us.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: i2c hangs board 
Date: Fri, 28 May 2004 09:11:52 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have mpc8xx based board, with 2.4.18 kernel. I have m41t81 RTC chip hooked
on i2c bus. I am using i2c drivers from the denx ppc dev tree, and 8xx algo.
I modified the m41t11 driver of denx for my m41t81 chip. When my m41t81
based module calls cpm_iic_write function of i2c-algo-8xx, it hangs the
board. It hangs somewhere here..




	if(count > 16){
		/* Chip bug, set enable here */

		local_irq_save(flags);
		i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
		i2c->i2c_i2cer = 0xff;
		i2c->i2c_i2mod |= 1;	/* Enable */
		i2c->i2c_i2com |= 0x80;	/* Begin transmission */

		/* Wait for IIC transfer */
		tmo = interruptible_sleep_on_timeout(&iic_wait,1*HZ);

		local_irq_restore(flags);

	} else {  /* busy wait for small transfers, its faster */
		i2c->i2c_i2cmr = 0x00;	/* Disable I2C interupts */
		i2c->i2c_i2cer = 0xff;


		i2c->i2c_i2mod |= 1;	/* Enable */

		/*CRAHSES SOMEWHERE HERE....*/
		i2c->i2c_i2com |= 0x80;	/* Begin transmission */
		tmo = jiffies + 1*HZ;

		while(!(i2c->i2c_i2cer & 0x12 || time_after(jiffies, tmo)));
/* Busy wait, with a timeout */
	}


Any help is appreciated.


Thanks
Lokesh Kumar
Wireless Matrix USA Inc.
703-262-4032


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
