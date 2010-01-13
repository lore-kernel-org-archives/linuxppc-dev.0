Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1261487856.10767.128.camel@concordia>
References: <1261474791.289871.854376051633.1.gpush@pororo>
	<1261478868.10767.2.camel@concordia>
	<200912221854.37572.jeremy.kerr@canonical.com>
	<1261487856.10767.128.camel@concordia>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 12 Jan 2010 23:43:15 -0700
Message-ID: <fa686aa41001122243v31e25e9et5db40b4f7ea8a56f@mail.gmail.com>
Subject: Re: [PATCH] of/flattree: use callback to setup initrd from /chosen
To: michael@ellerman.id.au
Content-Type: text/plain; charset=ISO-8859-1
Cc: microblaze-uclinux@itee.uq.edu.au, Jeremy Kerr <jeremy.kerr@canonical.com>,
	linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 22, 2009 at 6:17 AM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> On Tue, 2009-12-22 at 18:54 +0800, Jeremy Kerr wrote:
>> Hi Michael,
>>
>> > > =A0void early_init_dt_setup_initrd_arch(unsigned long start,
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsi=
gned long end);
>> >
>> > arch_early_init_dt_setup_initrd() makes more sense to me, but ..
>>
>> <foo>_arch has been the general convention for arch-specific hooks in
>> drivers/of/.
>
> Yuck, doh, guess I should have read those patches before they went in :)

It's not necessarily permanent.  My first goal is to get the common
code merged.  Then I want to look closely at it for patterns and
refactor how the common code calls out to arch specific hooks (or
maybe turn it around and have arch code calling out to the common
bits).

>
>> > > +#ifdef CONFIG_BLK_DEV_INITRD
>> > > +void __init early_init_dt_setup_initrd_arch(unsigned long start,
>> > > + =A0 =A0 =A0 =A0 unsigned long end)
>> > > +{
>> > > + initrd_start =3D (unsigned long)__va(start);
>> > > + initrd_end =3D (unsigned long)__va(end);
>> > > + initrd_below_start_ok =3D 1;
>> > > +}
>> > > +#endif
>> >
>> > Given you have two identical implementations why not make that the
>> > default and make it weak, and let ARM override it.
>>
>> Yeah, that would be good too; just been avoiding weak as a potential sou=
rce of
>> magic voodoo complexity. Grant - up to you on this one.
>
> Yeah, depends on what toolchains you're supporting, modern ones should
> be OK but it can be troublesome.

I'll look at this.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
