Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33E22681BB
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 08:55:36 +1100 (EST)
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <200601122312.05210.dtor_core@ameritech.net>
References: <20051225212041.GA6094@hansmi.ch>
	<1137022900.5138.66.camel@localhost.localdomain>
	<20060112000830.GB10142@hansmi.ch>
	<200601122312.05210.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 08:55:19 +1100
Message-Id: <1137189319.4854.12.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@killerfox.forkbomb.ch, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-input@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> That should be "MODULE_PARM_DESC(pb_fn_mode, ...)". Also, since this is
> for compatibility with ADB, why do we have 3 options? Doesn't ADB have
> only 2?

No, the ADB keyboard can operate in 2 modes that can be set with a PMU
command, I forgot about that in my earlier comments. In one mode, you get
the "special" behaviour by default on the Fx keys and you get Fx when
pressing Fn-Fx, and in the other mode, you get the Fx by default and the
special behaviour when pressing Fn-Fx.

> > +static inline struct hidinput_key_translation *find_translation(
> 
> I thought is was agreed that we'd avoid "inlines" in .c files?

Ah ? I have certainly missed that discussion ...

> > +	struct hidinput_key_translation *table, u16 from)
> > +{
> > +	struct hidinput_key_translation *trans;
> > +
> > +	/* Look for the translation */
> > +	for(trans = table; trans->from && (trans->from != from); trans++);
> > +
> > +	return (trans->from?trans:NULL);
> > +}
> 
> I'd prefer liberal amount of spaces applied here </extreme nitpick mode>

Me too :)

> > +		try_translate = test_bit(usage->code, usbhid_pb_numlock)?1:
> > +				test_bit(LED_NUML, input->led);
> > +		if (try_translate) {
> 
> Isn't this the same as 
> 
> 		if (test_bit(usage->code, usbhid_pb_numlock) || test_bit(LED_NUML, input->led))
> 
> but harder to read?

No. If the first one is 0, the second one will not matter in the first
version, while it will in yours.

Ben.
