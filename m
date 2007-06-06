Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 56AC6DDE38
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 09:08:16 +1000 (EST)
Message-ID: <46673E57.3020009@am.sony.com>
Date: Wed, 06 Jun 2007 16:08:07 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] [patch 17/18] PS3: Frame buffer system-bus
	rework
References: <20070606024407.786638029@am.sony.com> >	
	<46662399.7030401@am.sony.com>	
	<Pine.LNX.4.62.0706060849530.19499@pademelon.sonytel.be>
	<1181145418.5023.11.camel@daplas>
In-Reply-To: <1181145418.5023.11.camel@daplas>
Content-Type: text/plain; charset=UTF-8
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-fbdev-devel@lists.sourceforge.net, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.

Antonino A. Daplas wrote:
> On Wed, 2007-06-06 at 08:51 +0200, Geert Uytterhoeven wrote:
>> This one should go through linux-fbdev-devel (CC) for review, but Paul can
>> merge it because it depends on the PS3 system bus device rework.
>> 
> 
>> >  
>> > -static void ps3fb_shutdown(struct platform_device *dev)
>> > +static int __devexit ps3fb_remove(struct ps3_system_bus_device *dev)
>> >  {
>> > -	ps3fb_flip_ctl(0);	/* flip off */
>> > -	ps3fb.dinfo->irq.mask = 0;
>> > -	free_irq(ps3fb.irq_no, ps3fb.dev);
>> > -	ps3_irq_plug_destroy(ps3fb.irq_no);
>> > -	iounmap((u8 __iomem *)ps3fb.dinfo);
>> > +	BUG();
> 
> Why BUG()?

remove() doesn't work because lack of support from fbcon.  I'll remove
this though, since it independent of the fbcon fix.

-Geoff
