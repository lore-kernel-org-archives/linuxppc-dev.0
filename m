Message-ID: <3AA8480F.F5E09C8E@ncal.verio.com>
Date: Thu, 08 Mar 2001 19:03:43 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Pismo Aty128fb problem in 2.4.3-pre*?
References: <3AA41B77.73470672@ncal.verio.com> <3AA5113F.A0B78521@ncal.verio.com> <3AA621D3.755358F7@iiic.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
>
> Henry Worth wrote:
> >
> > Narrowed down the problem a bit more. Specifying
> > "video=aty128fb:mode:17" works; also without the mode.
> > But, adding a depth parm (8,16,24, or 32) causes the
> > fb init failure. It defaults to 8 and fbset works for
> > 8,15,16,32 but 24 causes a blurry image.
>
> The last is - *tadda* - an endianness error. aty128fb incorrectly enables byte
> swapping for 24 bit, which can easily be fixed; look for CONFIG_CNTL .
>

Great, one more bug bites the dust. On the first I had picked
up the incorrect keyword somewhere ("depth" instead of "cmode"),
and had been using it from day one. On 2.2 it was ignored and
the display left at 8bpp, in 2.4 it now causes init to leave
the display in a strange state. If that doesn't help you
find it, I'll dig into the code in a couple of days. With cmode
all is fine.

Is there any hope that the ATI 128 DRI stuff is going to
get reenabled soon?

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
