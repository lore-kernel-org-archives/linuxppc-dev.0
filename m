Message-ID: <37D9E4FB.2ED188A6@loomer.com>
Date: Fri, 10 Sep 1999 22:13:35 -0700
From: Hugh Caley <hcaley@loomer.com>
MIME-Version: 1.0
To: khendricks@ivey.uwo.ca
CC: linuxppc-dev@lists.linuxppc.org, Franz.Sirl@munich.netsurf.de
Subject: Re: More with Mozilla and glibc
References: <37D9C729.6BED554E@loomer.com> <99091023185500.02403@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wow.  Well, I'm still thinking that my Mozilla problem is glibc related, even if
the gdb output is bogus  ; ).  I know that Mozilla isn't even alpha yet, but other
people have better luck than I do, and they are using older libraries than I am.
I just don't want do deal with downgrading glibc just to test that (although I
have tried downgrading gcc, but I got the same problems).

Thanks for the info!

Hugh

Kevin Hendricks wrote:

> Hi,
>
> I get this same error trying to debug the native threads version of the jdk.  I
> don't think the problem is in glibc at all.
>
> The problem is in 4.17 versions of gdb under glibc 2.1.  In fact gdb can't
> handle the realtime signals yet and so it stops when it receives one.
> Therefore the error message in no way indicates the actual seg-fault or bug you
> are trying to find and fix.
>
> I think gdb simply has no maintainer yet (Kevin Buettner will be keeping it
> up, if he hasn't started already) and no one has updated it to reflect all of
> the new realtime signals now available in glibc 2.1.  The error message you get
> just prevents me from using gdb 4.17 when debugging any native threads
> (libpthread code).    Once the new thread signals numbers are included, you
> should be able to use the handle nostop command in gdb to prevent the
> libpthread signals from disrupting your debugging.
>
> The only workaround I know of is to rebuild linuxthreads (part of glibc) and
> manually turn off the use of the new realtime signals and instead use the old
> SIGUSR1 and SIGUSR2 signals for libpthreads until gdb gets fixed.
>
> I hope this helps.
>
> Kevin

--
Hugh Caley, Unix Administrator
Babcock & Brown, San Francisco
510-524-1672
hughc@babcockbrown.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
