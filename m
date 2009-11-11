Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 1A8C8B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 08:57:41 +1100 (EST)
Received: by yxe9 with SMTP id 9so1702326yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Nov 2009 13:57:39 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <9e4733910911111334o24f3114as6baaef82d7b17a05@mail.gmail.com>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083358.18908.10635.stgit@angua>
	<9e4733910911070451y28073dbeke6ced6246f5a5c24@mail.gmail.com>
	<fa686aa40911071051y3cf63e55ibe7fbc65c30bd15e@mail.gmail.com>
	<20091107201233.GC31789@sirena.org.uk>
	<9e4733910911110838w6010cf3atcfcd30c85f0764a1@mail.gmail.com>
	<20091111183753.GA31815@rakim.wolfsonmicro.main>
	<fa686aa40911111124i12b72196xdba7000b13b3bdc@mail.gmail.com>
	<9e4733910911111334o24f3114as6baaef82d7b17a05@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 Nov 2009 14:57:19 -0700
Message-ID: <fa686aa40911111357q22f57728va1b4bc8b5bc0425f@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/6] ASoC/mpc5200: get rid of the appl_ptr
	tracking nonsense
To: Jon Smirl <jonsmirl@gmail.com>
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

On Wed, Nov 11, 2009 at 2:34 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Wed, Nov 11, 2009 at 2:24 PM, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>> On Wed, Nov 11, 2009 at 11:37 AM, Mark Brown
>> <broonie@opensource.wolfsonmicro.com> wrote:
>>> On Wed, Nov 11, 2009 at 11:38:06AM -0500, Jon Smirl wrote:
>>>> > Providing a final valid data point to the driver would possibly even
>>>> > make things worse since if it were used then you'd have the equivale=
nt
>>>> > race where the application has initialized some data but not yet man=
aged
>>>> > to update the driver to tell it it's being handed over; if the drive=
r
>>>
>>>> That's an under run condition.
>>>
>>> Yes, of course - the issue is that this approach encourages them, makin=
g
>>> the system less robust if things are on the edge. =A0The mpc5200 seems =
to
>>> be not just on the edge but comfortably beyond it for some reason.
>>
>> I can't reproduce the issue at all as long at the dev_dbg() statement
>> in the trigger stop path is disabled. =A0With it enabled, I hear the
>> problem every time. =A0The 5200 may not be a speedy beast, but it is
>> plenty fast enough to shut down the audio stream before stale data
>> starts getting played out.
>
> "fast enough" - you just said it is a race.
> I've been saying it is a race too.

Yes, it is a race; but not the kind that is dangerous.  Audio playout
is always a real-time problem; whether in the middle of a stream or at
the end.  If the CPU gets nailed with an unbounded latency, then there
will be audible artifacts - Regardless of whether the driver knows
where the end of data is or not.  If it does know, then audio will
stutter.  If it doesn't know, then there will be repeated samples.
Both are nasty to the human ear.  So, making the driver do extra work
to keep the extra data in sync will probably force larger minimum
latencies for playout (trouble for VoIP apps) so the CPU can keep up,
and won't help one iota for making audio better.

The real solution is to fix the worst case latencies.

> There are two options:
> 1) Eliminate the race by developing a system to deterministically flag
> the end of valid data.
> 2) Fudge everything around making it almost impossible to lose the
> race, but the race is still there.

3) eliminate the unbounded latencies (fix the PSC driver and/or use a
real time kernel)
4) make sure userspace fills all the periods with silence before
triggering stop.  Gstreamer seems to already do this.  I suspect
pulseaudio does the same.

> The dev_dbg() aggravates the race until it is obviously visible every
> time. A deterministic solution would not be impacted by the dev_dbg().

But it still wouldn't help a bit when the same latency occurs in the
middle of playback.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
