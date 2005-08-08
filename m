Return-Path: <joakim.tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A262667F51
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Aug 2005 18:08:25 +1000 (EST)
Received: from jockewin (fw [172.31.1.1]) (authenticated bits=0)
	by dmz.lumentis.net (8.12.8/8.12.8) with ESMTP id j7888KVJ030142
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Mon, 8 Aug 2005 10:08:21 +0200
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>
Date: Mon, 8 Aug 2005 10:08:20 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEEKEALDFAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Volunteers to test i2c-algo-8xx on v2.6?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

Had a look at my old driver and it needs a little care.

Basically this block has changed 

> +	if(count > 16){
> +		/* Chip bug, set enable here */
> +		local_irq_save(flags);
> +		i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
> +		i2c->i2c_i2cer = 0xff;
> +		i2c->i2c_i2mod |= 1;	/* Enable */
> +		i2c->i2c_i2com |= 0x80;	/* Begin transmission */
> +
> +		/* Wait for IIC transfer */
> +		tmo = interruptible_sleep_on_timeout(&iic_wait,1*HZ);
> +		local_irq_restore(flags);
> +	} else { /* busy wait for small transfers, its faster */
> +		i2c->i2c_i2cmr = 0x00;	/* Disable I2C interupts */
> +		i2c->i2c_i2cer = 0xff;
> +		i2c->i2c_i2mod |= 1;	/* Enable */
> +		i2c->i2c_i2com |= 0x80;	/* Begin transmission */
> +		tmo = jiffies + 1*HZ;
> +	       	/* Busy wait, with a timeout */
> +		while(!(i2c->i2c_i2cer & 0x11 || time_after(jiffies, tmo)));
> +	}

into

> +		/* Chip bug, set enable here */
> +		local_irq_save(flags);
> +		i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
> +		i2c->i2c_i2cer = 0xff;
> +		i2c->i2c_i2mod |= 1;	/* Enable */
> +		i2c->i2c_i2com |= 0x80 | 0x01; /* Begin transmission and force master.
                                              Some errors(CL) clears the M/S bit */
> +
> +		/* Wait for IIC transfer */
> +		tmo = interruptible_sleep_on_timeout(&iic_wait,1*HZ);
> +		local_irq_restore(flags);

I have done this for cpm_iic_read, cpm_iic_write and cpm_iic_try_address.
Also note the the addition of "| 0x01" to i2c->i2c_i2com.
