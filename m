Message-Id: <200210021451.JAA26306@popmail.austin.ibm.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hollis Blanchard <hollis@austin.ibm.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Is it binutils-2.13.90.0.4 or is it me?
Date: Wed, 2 Oct 2002 09:54:14 -0500
References: <20021002010320.GA601@dd.nec.com.au>
In-Reply-To: <20021002010320.GA601@dd.nec.com.au>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tuesday 01 October 2002 20:03, Erik Christiansen wrote:
>    Following the mini-howto on penguinppc.org, I started with compilation
> of binutils.
>
>    ./configure --target=powerpc-linux finished in a happy frame of mind,
> but make spat the dummy, flagging errors on some rather elusive
> scripting:
>
> cd .. \
>   && CONFIG_FILES=po/Makefile.in:po/Make-in \
>      CONFIG_HEADERS= /bin/sh ./config.status
> creating po/Makefile.in
> make[3]: Leaving directory `/usr/local/src/binutils-2.13.90.0.4/bfd/po'
> make[3]: Entering directory `/usr/local/src/binutils-2.13.90.0.4/bfd/po'
> file=./`echo sv | sed 's,.*/,,'`.gmo \
>   && rm -f $file && PATH=../src:$PATH no -o $file sv.po
> /bin/sh: no: command not found
>
>    Now, grep -r 'no -o' /usr/local/src/binutils-2.13.90.0.4/bfd/po draws
> a blank, so before looking further for where it could be fixed, I
> thought I'd ask whether going back a version or two might provide
> smoother sailing?

This typically means someone did their autoconf wrong. You're missing some
feature ("Checking for /bin/foo... no") but the script doesn't actually check
for an error, and uses 'no' where it obviously shouldn't.

It is a bug; you should submit a bug report once you figure out what app it
is.

-Hollis

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
