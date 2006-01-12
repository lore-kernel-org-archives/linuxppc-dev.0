Return-Path: <vojtech@suse.cz>
Received: from mail.suse.cz (styx.suse.cz [82.119.242.94])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 026C268A41
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 20:07:19 +1100 (EST)
Date: Thu, 12 Jan 2006 10:07:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20060112090733.GA7627@midnight.suse.cz>
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<1135575997.14160.4.camel@localhost.localdomain>
	<d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
	<20060111232651.GI6617@hansmi.ch>
	<1137022900.5138.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1137022900.5138.66.camel@localhost.localdomain>
Cc: dtor_core@ameritech.net, linux-kernel@killerfox.forkbomb.ch,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 12, 2006 at 10:41:40AM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2006-01-12 at 00:26 +0100, Michael Hanselmann wrote:
> 
> >   * This is the global environment of the parser. This information is
> > @@ -431,6 +433,14 @@ struct hid_device {							/* device repo
> >  	void (*ff_exit)(struct hid_device*);                            /* Called by hid_exit_ff(hid) */
> >  	int (*ff_event)(struct hid_device *hid, struct input_dev *input,
> >  			unsigned int type, unsigned int code, int value);
> > +
> > +#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
> > +	/* We do this here because it's only relevant for the
> > +	 * USB devices, not for all input_dev's.
> > +	 */
> > +	unsigned long pb_fn[NBITS(KEY_MAX)];
> > +	unsigned long pb_numlock[NBITS(KEY_MAX)];
> > +#endif
> >  };
> 
> I don't understand the comment above ? You are adding this to all struct
> hid_device ? There can be only one of those keyboards plugged at one
> point in time, I don't think there is any problem having the above
> static in the driver rather than in the hid_device structure.

I think having it in struct hid_device is safer. We might want to
dynamically allocate only for PowerBook keyboards, though, to save
memory.

> 
>   .../...
> 
> >  
> > +	if ((hid->quirks & HID_QUIRK_POWERBOOK_HAS_FN) &&
> > +	    hidinput_pb_event(hid, input, usage, value)) {
> > +		return;
> > +	}
> > +
> 
> Dimitry might disagree but it's generally considered bad taste to have
> { and } for a single statement :)

I do agree, though.


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
