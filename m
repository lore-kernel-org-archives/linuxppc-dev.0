From: Benjamin Herrenschmidt <bh40@calva.net>
To: <sleemburg@jvc.nl>
Cc: Joseph Garcia <jpgarcia@execpc.com>,
        Francois Felix Ingrand
 <felix@ingrand.net>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Pismo battery support (was 'Re: Debian pmud package available')
Date: Wed, 7 Jun 2000 09:55:01 +0200
Message-Id: <20000607075501.32213@mailhost.mipsys.com>
In-Reply-To: <393DF504.B7F839F8@jvc.nl>
References: <393DF504.B7F839F8@jvc.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jun 7, 2000, Stephan Leemburg <sleemburg@jvc.nl> wrote:

>FYI, in 2.2.16pre4, there is NO support for letting the Pismo and the
>iBook sleep. It is however, as proven by the discussed battery monitors,
>possible to get some info on the battery status. Supporting the KEYLARGO
>is no trivial task, first of all, you need to have a iBook or Pismo to
>experiment with and then get your hands dirty on trial and error kernel
>modifications.

I'm the happy owner of a Pismo since one or two weeks. Implementing sleep
on this machine (and on the iBook) is on my to-do list (I already
gathered various infos on KeyLargo from the Darwin sources and some MacOS
hacking). I will first work on improving the gmac driver, which seems to
be more urgent, and then work on that sleep support.

>As I don't own a iBook or a Pismo, I cannot experiment with it and
>experimenting over the net - that is one person writing the testcode and
>the other testing it on a KEYLARGO based machine - is far to
>inconvenient and will most probably not work.
>
>For what that experimenting is concerned, I believe that in the latest
>Darwin kernel there is some powermanagement code, which could be analysed.

It's still not complete, but there are interesting bits scattered here or
there. The basic mecanism seems to be the same as for the wallstreet and
lombard: the CPU is powered OFF by the PMU after entering a special
sleep-loop. We need to fix this sleep-loop so that it resist to spurrious
wake-ups by the decrementer interrupt, but that's a detail.

The different thing is the way things are powered off before sleep and
turned back on after sleep. It's a lot different for KeyLargo that it was
for Heathrow and Paddington, but Darwin source is helpful here. I plan to
rework (again) the arch/ppc/kernel/features.c stuffs to add more
abstractions that match keylargo and uni-north new FCRs and power control.

>Note that even though you cannot put the machines to sleep, you can have

>pmud signal init that there is a powerfailure and have it shutdown...
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
