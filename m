To: Alban Wood <awood@bloodwolf.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc8xx fpu emu 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Sep 2002 14:52:20 EDT."
             <Pine.LNX.4.44.0209111451510.1731-100000@manoir.bloodwolf.org>
Date: Wed, 11 Sep 2002 23:54:41 +0200
Message-Id: <20020911215446.8E0C1FA8B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Alban,

in message <Pine.LNX.4.44.0209111451510.1731-100000@manoir.bloodwolf.org> you wrote:
>
> Basically, I have an RPX Lite-M board. The mpc850 does not have an fpu,
> but I have a need for non-intensive fpu operations. I don't want to
> compile applications and librairies with -msoft-float - for my needs the
> fpu emulator is really the way to go.

Believe me: it is _not_.

> I also compiled a very simple application that does a floating point
> division and prints it. I explicitly specified -msoft-hard. (same with the
> kernel btw), checked out the resulting assembly and did in fact find an
> fdiv instruction.

You can do this, and you may even get simple  programs  working.  But
other  simple program may crash, or produce bad results, or both. Not
to speak about complicated programs.

The FPU emulation code is *far* from being production quality.

Do NOT use it. You have been warned.


And BTW: why should you want to use it? If you just have to deal with
"non-intensive fpu operations" then software FP is just  fine  -  you
probably won;t even notice the slightly larger memory footprint - but
you definitely will notice the much, much higher speed of soft-float.

> I didn't compile my own toolchain. I switch between the binary
> distributions I got from www.qslinux.org and timesys. I'm not sure this is
> a good idea.

Be aware that you cannot mix harware FP and software FP in one binary
and the libraries you link against.

> Any ideas as to what could be wrong? Could it be that the libs in the root
> filesystem I'm using for the board were compiled with -msoft-float,  and
> that as a result printf cannot properly output a float? (even though it's
> been properly handled by the fpu emulator?)

This is very likely the cause.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Here's a fish hangs in the net like a poor man's right in  the  law.
'Twill hardly come out."     - Shakespeare, Pericles, Act II, Scene 1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
