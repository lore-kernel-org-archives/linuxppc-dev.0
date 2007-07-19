Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 2CAAEDDE3D
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 22:13:35 +1000 (EST)
Date: Thu, 19 Jul 2007 14:13:33 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [patch 1/3] ps3: Disk Storage Driver
In-Reply-To: <20070719140038.606abd44@gondolin.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.62.0707191411060.8661@pademelon.sonytel.be>
References: <20070716161539.075822000@pademelon.sonytel.be>
	<20070716162206.392129000@pademelon.sonytel.be>
	<20070718163637.3f0e0164.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0707191039430.8661@pademelon.sonytel.be>
	<20070719112602.5e3cb21a@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.62.0707191132150.8661@pademelon.sonytel.be>
	<20070719140038.606abd44@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-175469791-1184847213=:8661"
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
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

---584337861-175469791-1184847213=:8661
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 19 Jul 2007, Cornelia Huck wrote:
> On Thu, 19 Jul 2007 11:36:31 +0200 (CEST),
> Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> 
> > We have a probe thread that checks for new storage devices and adds them to the
> > bus with ps3_system_bus_device_register(), which calls device_register().
> > 
> > I guess the actual bus probe() routine gets called through the notifier call
> > chain? That's where I got lost...
> 
> No, ->probe() is called from device_register() directly. If you just
> have one probe thread, you should have enough serialization.

IC, through bus_attach_device() in device_add().

Any chance this will change? I already added a mutex to ps3disk to protect
against this.

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
---584337861-175469791-1184847213=:8661--
