Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: asm inline
Date: Mon, 2 Dec 2002 10:45:32 -0500
Cc: Andreas Schwab <schwab@suse.de>, linuxppc-dev@lists.linuxppc.org
References: <5.2.0.9.2.20021202154112.0512a008@mail.lauterbach.com> <5.2.0.9.2.20021202162114.01d3dad0@mail.lauterbach.com>
In-Reply-To: <5.2.0.9.2.20021202162114.01d3dad0@mail.lauterbach.com>
MIME-Version: 1.0
Message-Id: <200212021045.32879.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Franz,

> I see, but I think there is no chance that this is backported to an
> official 3.2 release. Also 3.3 is only a few month away, so it makes no
> real sense.

My guess is we will stick with gcc 3.2.X series since many distributions
will use that version as the basis for their next releases and not make
the move to gcc 3.3 since we also really need a stable C++ abi and the
constant changes to libstdc++.so versions is creating a bit of a support
nightmare.

Rgiht now to support building on all of the different versions of gcc we
have to do the following:

 .IF "$(CCNUMVER)">="000300000001"

COMID=gcc3
COMNAME=gcc3

.IF "$(CCNUMVER)"=="000300000001"
LIBSTDCPP3="3.0.1"
SHORTSTDCPP3="3"
.ENDIF

.IF "$(CCNUMVER)"=="000300000002"
LIBSTDCPP3="3.0.2"
SHORTSTDCPP3="3"
.ENDIF

.IF "$(CCNUMVER)"=="000300000003"
LIBSTDCPP3="3.0.3"
SHORTSTDCPP3="3"
.ENDIF

.IF "$(CCNUMVER)"=="000300000004"
LIBSTDCPP3="3.0.4"
SHORTSTDCPP3="3"
.ENDIF

.IF "$(CCNUMVER)"=="000300010000"
LIBSTDCPP3="4.0.0"
SHORTSTDCPP3="4"
.ENDIF

.IF "$(CCNUMVER)"=="000300010001"
LIBSTDCPP3="4.0.1"
SHORTSTDCPP3="4"
.ENDIF

.IF "$(CCNUMVER)"=="000300020000"
LIBSTDCPP3="5.0.0"
SHORTSTDCPP3="5"
.ENDIF

.IF "$(CCNUMVER)"=="000300020001"
LIBSTDCPP3="5.0.1"
SHORTSTDCPP3="5"
.ENDIF

.ENDIF

Because mixing libstdc++ versions seems to result in exception handling
issues across shared libraries and many machines seem to have multiple
copies of libstdc++ in various places as well as multiple gcc versions
lying around.

Is the original patch that added this warning someplace I could find and
hopefully modify to use with gcc 3.2.X?

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
