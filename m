Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Barker Michael-r43496" <Michael.D.Barker@motorola.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8xx i2c refers to unspecified chip errata
Date: Thu, 10 Oct 2002 12:35:19 +0200
Message-ID: <IGEFJKJNHJDCBKALBJLLIEPPFGAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <6D4DC8B4AD16D6118E8200D0B76FE262022CCB48@ONT06EXM01>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Also: in the drivers/i2c/i2c-algo-cpm.c or i2c-algo-8xx.c file, I see the following a few times.  What two chip errata
> are the comments referring to?  A specific errata number would be enlightening.

I think these refer to older revision of mpc8xx CPU. In the mpc860 only the latest CPU rev(D4)
has all relevant I2C bugs fixed. The fix below does not work well in my MPC860(rev D4). I think
it's because I2C is disabled before it had a chence to generate a proper STOP condition
and that hangs my DS1337 RTC clock badly(need to reboot to fix it). The driver(i2c-algo-8xx.c) that
comes with the kernel has other severe bugs(memory corruption etc.) as well.

>
> ---------snip
> /* Chip errata, clear enable.
> */
> i2c->i2c_i2mod = 0;
>
> ---------snip
> /* Chip bug, set enable here */
> save_flags(flags); cli();
> i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
> i2c->i2c_i2cer = 0xff;
> i2c->i2c_i2mod = 1;	/* Enable */
> i2c->i2c_i2com = 0x81;	/* Start master */
> ----------snip
>
> Thanks for your attention -
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
