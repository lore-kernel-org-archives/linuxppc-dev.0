Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 784C9DDFF2
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 22:29:55 +1000 (EST)
Date: Tue, 19 Jun 2007 14:29:49 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 5/6] ps3: ROM Storage Driver
In-Reply-To: <d46c75da8a86ab5cd83b63f9dbfee33f@bga.com>
Message-ID: <Pine.LNX.4.62.0706191405190.4069@pademelon.sonytel.be>
References: <d46c75da8a86ab5cd83b63f9dbfee33f@bga.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-894433762-1182256189=:4069"
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-894433762-1182256189=:4069
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 18 Jun 2007, Milton Miller wrote:
> > +config PS3_ROM
> > +	tristate "PS3 ROM Storage Driver"
> > +	depends on PPC_PS3 && BLK_DEV_SR
> > +	select PS3_STORAGE
> > +	help
> > +	  Include support for the PS3 ROM Storage.
> > +
> > +	  This support is required to access the PS3 BD/DVD/CD-ROM drive.
> > +	  In general, all users will say Y or M.
> > +
> 
> 
> When I think ROM I usually dont' start with optical media.
> 
> Have you condered calling this the optical driver?

The name comes from the SCSI device type (0x05 == TYPE_ROM). But if people
prefer ps3atapi, I can change it.

> Or at least putting BD?DVD?CD-ROM on the prompt.
> 
> 
> Why does it depend on BLK_DEV_SR?

Because it needs SCSI CD-ROM support.

> > +static int __devinit ps3rom_probe(struct ps3_system_bus_device *_dev)
> > +{
> > +	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
> > +	int error;
> > +	struct Scsi_Host *host;
> > +	struct ps3rom_private *priv;
> > +
> > +	if (dev->blk_size != CD_FRAMESIZE) {
> > +		dev_err(&dev->sbd.core,
> > +			"%s:%u: cannot handle block size %lu\n", __func__,
> > +			__LINE__, dev->blk_size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev->bounce_size = BOUNCE_SIZE;
> > +	dev->bounce_buf = kmalloc(BOUNCE_SIZE, GFP_DMA);
> > +	if (!dev->bounce_buf) {
> > +		return -ENOMEM;
> > +	}
> > +
> > +	error = ps3stor_setup(dev);
> > +	if (error)
> > +		goto fail_free_bounce;
> > +
> > +	/* override the interrupt handler */
> > +	free_irq(dev->irq, dev);
> > +	error = request_irq(dev->irq, ps3rom_interrupt, IRQF_DISABLED,
> > +			    dev->sbd.core.driver->name, dev);
> > +	if (error) {
> > +		dev_err(&dev->sbd.core, "%s:%u: request_irq failed %d\n",
> > +			__func__, __LINE__, error);
> > +		goto fail_teardown;
> > +	}
> > +
> 
> Somebody's help isn't helpful?  Layering problem?

ps3stor_setup() tries to read from the device to check its accessibility,
and uses a simple interrupt routine for synchronous operations (using the
completion). This interrupt routine is also used for ps3flash.

Ps3rom and ps3disk do asynchronous device accesses, hence they use different
interrupt routines.

I guess I can add synchronous support to the ps3rom interrupt handler (ps3disk
already has this, for sync cache), so ps3stor_setup() can use them for probing,
too.

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-894433762-1182256189=:4069--
