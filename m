Subject: Re: provision of "driver" type facilities from user-space
To: iain@sandoe.co.uk (Iain Sandoe)
Date: Fri, 9 Mar 2001 21:31:24 -0800 (PST)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010309181506.CB5212F00E@apollo.valhalla.net> from "Iain Sandoe" at Mar 09, 2001 06:15:03 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20010310053124.2FB452B54B@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Have you looked at the ALSA project? They have both a new kernel driver
and a user-space library that does extra capabilities. It is backward
compatible with OSS through an optional kernel module, and was just
recently ported to PowerMacs (beta only).

http://www.alsa-project.org/

I'm not sure it's exactly what you're trying to do, but it might be worth
investigating so you don't waste effort doing something that's already
being worked on. I haven't taken the time to read all their documentation,
but it might be a good place to start.

        Brad Boyer
        flar@pants.nu

Iain Sandoe wrote:
>
>
> hi list,
>
> I want to put a layer in between user-space and a driver (dmasound).
>
> The reason is - that I want to provide facilities (transparently) to
> applications and these facilities cannot be (sensibly) placed in the driver
> [e.g. rate conversion and so on].
>
> In this case to make dmasound look like it can do "anything" and help
> support (easily) apps that don't really bother to check for h/w capabilities
> properly.
>
> It isn't really the best solution to bloat each and every app with code to
> do the job - some form of sharing seems to be the right way.
>
> so solution 1:
>
> provide a pseudo-oss interface via a library:
>
> psuedo_oss_open(), pseudo_oss_read() .... etc. etc.
>
> so app source is amended and then linked with a lib providing the
> appropriate stuff in user-space...
>
> not, probably, going to be popular...
>
> solution 2:
>
> ??? is there a way of doing this without the apps being amended but _still_
> making sure that code that belongs in user-space resides and is executed
> there?
>
> preferably allowing apps to think they are just talking to /dev/dsp
>
> ciao,
> Iain.
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
