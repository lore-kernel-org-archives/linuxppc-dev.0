From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B236B6@penguin.adic.com>
To: wd@denx.de, brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: FW: Need openssh for embedded linux on 440GP 
Date: Wed, 12 Mar 2003 07:47:45 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the reply Wolfgang.

(1) I did set CROSS_COMPILE flags in the openssh Makefile, for CC and
others, and it barfed when compiling on the host. There doesn't seem to be a
lot of info out there on openssh cross-compiling ...

(2) Based on your response below, compiling on the target using the ppc_4xx
target filesytem tools provided (gcc etc...), the expectation is that
openssh should run, correct? My bandwidth right now is tied up on other
stuff right now, so I can't get into openssh debugging, but I hope to have
that chance soon.

I looked through the openssh code and they appeared to make judicious use of
htonl/s and ntohl/s which should alleviate an endianness issues ... correct
me if I'm wrong. When I get I chance, I'll double check the hton and ntoh
macros to make sure that's the case.

Thanks again,

-- Brian

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Wednesday, March 12, 2003 9:11 AM
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FW: Need openssh for embedded linux on 440GP

In message <995FF289C9D69747A09E42992644595405B236B3@penguin.adic.com> you
wrote:
>
> Is there any particular reason why openssh is not included in the ELDK
> target package?

None of our customers asked for it yet, and nobody  else  contributed
it either.

> As an update to what's written below, I did try cross-compiling and that
was
> even less successful than compiling on my embedded target.

I'm not surprised.

> The error I receive is: "Disconnecting: Corrupted MAC on input"

I guess you mis-configured the tools so you now  run  into  endianess
problems?

> I am trying to get openssh installed and running on my embedded 440
> platform. 'openssh' is not part of the target packages provided with the
> ELDK, so I figure there's 2 ways to do it:
>
> (a) cross-compile on my host
> (b) compile it on my target system
>
> I haven't tried (a) yet, as openssh does not seem to be very cross-compile
> friendly and I'm still getting comfortable with the whole
'cross-compiling'
> from source using ELDK.

In general,  cross  compiling  is  as  trivial  as  adding  a  "CC  =
$(CROSS_COMPILE)gcc"  line  to  the Makefile. At least for any source
that was  portably  written  and  does  not  need  any  autoconfig  /
configure stuff to be built.

> I went ahead and proceeded with (b). I retrieved the latest source from
> www.openssh.com, unpacked and built it on my target system (filesytem nfs
> mounted). It took a while, but everything built ok. I thought I was home
> free until I tried to either:
>
>   (i)  start the sshd daemon
>        The daemon starts OK. However, when I ssh to the
>        Target, it barfs on a 'CRC' error.

Did you turn on debugging?

>   (ii) ssh to another machine from the target
>        When I try to connect, I get an error message related
>        Errors at the MAC addr level.

Did you turn on debugging?

> Can't provide more detail at this point on the specific errors as I'm
> rebuilding ssh as I write this (on the target) and can't get the info.
>
> Is the direction I'm going in the logical direction? I've worked on
embedded
> systems for years, but this is the first with embedded linux, and the
first
> time I've actually built something on my target!! It feels unusual, but I
> don't see why it shouldn't work, and seems like a better choice than
> cross-compiling.

It should work.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"We don't care.  We don't have to.  We're the Phone Company."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
