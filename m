Message-Id: <200111141233.HAA74509@p2.parker.boston.ma.us>
To: IGOR LURI <iluri@fagorautomation.es>
Cc: =?ISO-8859-1?Q?EMBEDDED_LINUXPPC_=28Correo_electr=F3nico=29?= <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: USB host controller on FADS board 
In-reply-to: Your message of "Tue, 13 Nov 2001 08:05:12 +0100."
             <CA78D1B723D8D411AF0300508BDCF74F3F6CE9@NTCORREO>
Date: Wed, 14 Nov 2001 07:33:32 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


IGOR LURI wrote:
>
>After booting Linux I have the following mesages:
>
...
>Freeing unused kernel memory: 60k init
>m8xxhci: assert reset
>wait_for_qe(qe=c022a27c) done; urb 00000000, status -110
>
>### Initial RAM disk starting interactive shell ###
>BusyBox v0.60.0 (2001.10.05-20:58+0000) Built-in shell (msh)
>Enter 'help' for a list of builtm8xxhci: assert reset
>-in commands.
>
>
>m8xxhci: assert reset
>wait_for_qe(qe=c022a27c) done; urb 00000000, status -110

Those messages are not necessarily bad.  The "poll for hub" code sends
out requests looking for a device.  If nothing is connected it gets an
error.  I thought the messages only came out if "verbose" was
enabled...  (I need to check)

I don't know what the FADS h/w looks like - if their are no pullups on
the D+/D- lines and the it has the 15k pull *downs* on both lines you
can use the normal RXP/RNX insert detection code (i.e. you can turn
off the polling code).

Is there a device connected?

btw: I thought the 1khz timer signal needed to go to DREQ0, not DREQ1

-brad


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
