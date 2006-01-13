Return-Path: <dmitry.torokhov@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.194])
	by ozlabs.org (Postfix) with ESMTP id 9BB636893D
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 09:08:33 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id n1so767914nzf
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 14:08:32 -0800 (PST)
Message-ID: <d120d5000601131408s41d1a60amfa31a3821019389c@mail.gmail.com>
Date: Fri, 13 Jan 2006 17:08:31 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
In-Reply-To: <d120d5000601131405w4e20e37fna17767624a4ebf6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051225212041.GA6094@hansmi.ch>
	<1137022900.5138.66.camel@localhost.localdomain>
	<20060112000830.GB10142@hansmi.ch>
	<200601122312.05210.dtor_core@ameritech.net>
	<1137189319.4854.12.camel@localhost.localdomain>
	<d120d5000601131405w4e20e37fna17767624a4ebf6@mail.gmail.com>
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

On 1/13/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 1/13/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > > That should be "MODULE_PARM_DESC(pb_fn_mode, ...)". Also, since this =
is
> > > for compatibility with ADB, why do we have 3 options? Doesn't ADB hav=
e
> > > only 2?
> >
> > No, the ADB keyboard can operate in 2 modes that can be set with a PMU
> > command, I forgot about that in my earlier comments. In one mode, you g=
et
> > the "special" behaviour by default on the Fx keys and you get Fx when
> > pressing Fn-Fx, and in the other mode, you get the Fx by default and th=
e
> > special behaviour when pressing Fn-Fx.
> >
>
> Right, so do we need "no translation, fnkeyfirst and fnkeylast" option
> or just "fnkeyfirst and fnkeyast"?
>
> > > > +static inline struct hidinput_key_translation *find_translation(
> > >
> > > I thought is was agreed that we'd avoid "inlines" in .c files?
> >
> > Ah ? I have certainly missed that discussion ...
>
> Newer GCCs, unit-at-a-time, etc. etc. - teher was pretty long
> discussion about letting GCC decide on inlining.
>
> >
> > > > +   struct hidinput_key_translation *table, u16 from)
> > > > +{
> > > > +   struct hidinput_key_translation *trans;
> > > > +
> > > > +   /* Look for the translation */
> > > > +   for(trans =3D table; trans->from && (trans->from !=3D from); tr=
ans++);
> > > > +
> > > > +   return (trans->from?trans:NULL);
> > > > +}
> > >
> > > I'd prefer liberal amount of spaces applied here </extreme nitpick mo=
de>
> >
> > Me too :)
> >
> > > > +           try_translate =3D test_bit(usage->code, usbhid_pb_numlo=
ck)?1:
> > > > +                           test_bit(LED_NUML, input->led);
> > > > +           if (try_translate) {
> > >
> > > Isn't this the same as
> > >
> > >               if (test_bit(usage->code, usbhid_pb_numlock) || test_bi=
t(LED_NUML, input->led))
> > >
> > > but harder to read?
> >
> > No. If the first one is 0, the second one will not matter in the first
> > version, while it will in yours.
> >
>
> Huh? You mean 1, right?
>
>    try_translate =3D 0;
>    if (test_bit(usage->code, usbhid_pb_numlock))
>         try_translate =3D 1;
>    else if (test_bit(LED_NUML, input->led))
>         try_translate =3D 1;
>    else
>

Uhg, accidentially hit send, sorry... Ok, nevermind, I see your other messa=
ge ;)

--
Dmitry
