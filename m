Return-Path: <dmitry.torokhov@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.196])
	by ozlabs.org (Postfix) with ESMTP id 0E7636891D
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 09:05:10 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id m7so910693nzf
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 14:05:09 -0800 (PST)
Message-ID: <d120d5000601131405w4e20e37fna17767624a4ebf6@mail.gmail.com>
Date: Fri, 13 Jan 2006 17:05:08 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
In-Reply-To: <1137189319.4854.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051225212041.GA6094@hansmi.ch>
	<1137022900.5138.66.camel@localhost.localdomain>
	<20060112000830.GB10142@hansmi.ch>
	<200601122312.05210.dtor_core@ameritech.net>
	<1137189319.4854.12.camel@localhost.localdomain>
Cc: linux-kernel@killerfox.forkbomb.ch, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-input@atrey.karlin.mff.cuni.cz
Reply-To: dtor_core@ameritech.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/13/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > That should be "MODULE_PARM_DESC(pb_fn_mode, ...)". Also, since this is
> > for compatibility with ADB, why do we have 3 options? Doesn't ADB have
> > only 2?
>
> No, the ADB keyboard can operate in 2 modes that can be set with a PMU
> command, I forgot about that in my earlier comments. In one mode, you get
> the "special" behaviour by default on the Fx keys and you get Fx when
> pressing Fn-Fx, and in the other mode, you get the Fx by default and the
> special behaviour when pressing Fn-Fx.
>

Right, so do we need "no translation, fnkeyfirst and fnkeylast" option
or just "fnkeyfirst and fnkeyast"?

> > > +static inline struct hidinput_key_translation *find_translation(
> >
> > I thought is was agreed that we'd avoid "inlines" in .c files?
>
> Ah ? I have certainly missed that discussion ...

Newer GCCs, unit-at-a-time, etc. etc. - teher was pretty long
discussion about letting GCC decide on inlining.

>
> > > +   struct hidinput_key_translation *table, u16 from)
> > > +{
> > > +   struct hidinput_key_translation *trans;
> > > +
> > > +   /* Look for the translation */
> > > +   for(trans =3D table; trans->from && (trans->from !=3D from); tran=
s++);
> > > +
> > > +   return (trans->from?trans:NULL);
> > > +}
> >
> > I'd prefer liberal amount of spaces applied here </extreme nitpick mode=
>
>
> Me too :)
>
> > > +           try_translate =3D test_bit(usage->code, usbhid_pb_numlock=
)?1:
> > > +                           test_bit(LED_NUML, input->led);
> > > +           if (try_translate) {
> >
> > Isn't this the same as
> >
> >               if (test_bit(usage->code, usbhid_pb_numlock) || test_bit(=
LED_NUML, input->led))
> >
> > but harder to read?
>
> No. If the first one is 0, the second one will not matter in the first
> version, while it will in yours.
>

Huh? You mean 1, right?

    try_translate =3D 0;
    if (test_bit(usage->code, usbhid_pb_numlock))
         try_translate =3D 1;
    else if (test_bit(LED_NUML, input->led))
         try_translate =3D 1;
    else







> Ben.
>
>
>


--
Dmitry
