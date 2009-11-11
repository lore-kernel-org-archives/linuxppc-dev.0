Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f198.google.com (mail-qy0-f198.google.com
	[209.85.221.198]) by ozlabs.org (Postfix) with ESMTP id 27F12B7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 08:34:31 +1100 (EST)
Received: by qyk36 with SMTP id 36so689583qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Nov 2009 13:34:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40911111124i12b72196xdba7000b13b3bdc@mail.gmail.com>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083358.18908.10635.stgit@angua>
	<9e4733910911070451y28073dbeke6ced6246f5a5c24@mail.gmail.com>
	<fa686aa40911071051y3cf63e55ibe7fbc65c30bd15e@mail.gmail.com>
	<20091107201233.GC31789@sirena.org.uk>
	<9e4733910911110838w6010cf3atcfcd30c85f0764a1@mail.gmail.com>
	<20091111183753.GA31815@rakim.wolfsonmicro.main>
	<fa686aa40911111124i12b72196xdba7000b13b3bdc@mail.gmail.com>
Date: Wed, 11 Nov 2009 16:34:29 -0500
Message-ID: <9e4733910911111334o24f3114as6baaef82d7b17a05@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/6] ASoC/mpc5200: get rid of the appl_ptr
	tracking nonsense
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Bonesio <bones@secretlab.ca>, alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@lists.ozlabs.org, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 11, 2009 at 2:24 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Wed, Nov 11, 2009 at 11:37 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Wed, Nov 11, 2009 at 11:38:06AM -0500, Jon Smirl wrote:
>>> > Providing a final valid data point to the driver would possibly even
>>> > make things worse since if it were used then you'd have the equivalen=
t
>>> > race where the application has initialized some data but not yet mana=
ged
>>> > to update the driver to tell it it's being handed over; if the driver
>>
>>> That's an under run condition.
>>
>> Yes, of course - the issue is that this approach encourages them, making
>> the system less robust if things are on the edge. =A0The mpc5200 seems t=
o
>> be not just on the edge but comfortably beyond it for some reason.
>
> I can't reproduce the issue at all as long at the dev_dbg() statement
> in the trigger stop path is disabled. =A0With it enabled, I hear the
> problem every time. =A0The 5200 may not be a speedy beast, but it is
> plenty fast enough to shut down the audio stream before stale data
> starts getting played out.

"fast enough" - you just said it is a race.
I've been saying it is a race too.

There are two options:
1) Eliminate the race by developing a system to deterministically flag
the end of valid data.
2) Fudge everything around making it almost impossible to lose the
race, but the race is still there.

The dev_dbg() aggravates the race until it is obviously visible every
time. A deterministic solution would not be impacted by the dev_dbg().

Implementing a deterministic solution requires support from ALSA core.

--=20
Jon Smirl
jonsmirl@gmail.com
