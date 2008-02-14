Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 000DBDDF2D
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 22:40:08 +1100 (EST)
Message-ID: <47B42874.7040406@scram.de>
Date: Thu, 14 Feb 2008 12:39:32 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Nima Montaser <nima@nortel.com>
Subject: Re: [PATCH/RFC] [POWERPC] Add i2c pins to dts and board setup on
	01-31-08
References: <87AC5F88F03E6249AEA68D40BD3E00BE1418A0B3@zcarhxm2.corp.nortel.com>
In-Reply-To: <87AC5F88F03E6249AEA68D40BD3E00BE1418A0B3@zcarhxm2.corp.nortel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Nima,

> I've got a couple of comments about the above patch - I'm not quite sure
> how to add my comments to the ozlab.org site.

simply replying to the original mail will add your comments.

> 1 -
> -- a/arch/powerpc/boot/dts/mpc8272ads.dts
> [snip]
> +                       i2c@11860 {
> +                               compatible = "fsl,mpc8248-i2c",  
> [NIMA] Are you sure it should be mpc8248, or do you want 8272. I know
> they are essentially the same chip, but just to avoid confusion, it
> maybe better as 8272.

Good catch, thanks! As i don't have a CPM2 chip myself, i had a tester with
a MPC8248. I just took his dts parts.

> 2-
> +++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
> @@ -96,6 +96,11 @@  static struct cpm_pin mpc8272_ads_pins[] = {
>         {1, 31, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
>         {2, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
>         {2, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
> +
> +       /* I2C */
> +       {3, 26, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
> +       {3, 27, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
> 
> [NIMA] The MPC8272 manual states that it should be pins 14/15 and not
> 26/27.

Ah thanks. 

> However, in all my accesses,
> - 1st write is successful
> - 1st read fails (times out)
> - 2nd read succeeds
> 
> Here is the debug log:
> i2c-adapter i2c-0: ioctl, cmd=0x703, arg=0x40
> i2c-dev: i2c-0 writing 2 bytes.
> i2c-adapter i2c-0: master_xfer[0] W, addr=0x40, len=2
> i2c-adapter i2c-0: i2c-algo-cpm.o: R: 0 T: 0
> i2c-adapter i2c-0: cpm_iic_write(abyte=0x80)
> i2c-adapter i2c-0: tx sc 0 bc00
> i2c-adapter i2c-0: test ready.
> i2c-adapter i2c-0: not ready.
> i2c-adapter i2c-0: Interrupt: 2
> i2c-adapter i2c-0: Interrupt: 1
> i2c-adapter i2c-0: test ready.
> i2c-adapter i2c-0: ready.
> i2c-adapter i2c-0: tx sc 0 3c00
> i2c-dev: i2c-0 reading 1 bytes.
> i2c-adapter i2c-0: master_xfer[0] R, addr=0x40, len=1
> i2c-adapter i2c-0: i2c-algo-cpm.o: R: 0 T: 0
> i2c-adapter i2c-0: cpm_i2c_read(abyte=0x81)
> i2c-adapter i2c-0: test ready.
> i2c-adapter i2c-0: not ready.
> i2c-adapter i2c-0: I2C read: timeout!
> i2c-adapter i2c-0: cpm_i2c_force_close()
> i2c-dev: i2c-0 reading 1 bytes.
> i2c-adapter i2c-0: master_xfer[0] R, addr=0x40, len=1
> i2c-adapter i2c-0: i2c-algo-cpm.o: R: 0 T: 0
> i2c-adapter i2c-0: cpm_i2c_read(abyte=0x81)
> i2c-adapter i2c-0: test ready.
> i2c-adapter i2c-0: not ready.
> i2c-adapter i2c-0: Interrupt: 1
> i2c-adapter i2c-0: test ready.
> i2c-adapter i2c-0: ready.
> i2c-adapter i2c-0: rx sc 2c00, rx sc 1800
> 
> Any ideas?

What does you chip expect? Start-Write-Start-Read-Stop or Start-Write-Stop, Start-Read-Stop? 
Did you try chaining the write and read request (put them into the same msg)?

Thanks,
Jochen
