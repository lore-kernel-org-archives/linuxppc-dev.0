Message-Id: <4.3.2.20010321082405.00bdb570@falcon.si.com>
Date: Wed, 21 Mar 2001 08:47:14 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: strange problem while booting
In-Reply-To: <3AB8A7B0.3179CF4C@enst.fr>
References: <3AB7E349.8AC5A1B0@enst.fr>
 <3AB7FFF6.EB575041@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The strange characters you were getting are reminiscent of DEC VT-100
"graphics" characters.  On a VT (compatible) display, you can send an
escape sequence which makes the lower case ASCII characters turn into
characters that are line graphics, but the upper case characters are
unchanged.  Note that this became part of the ANSI terminal
specification, and is implemented in most terminal programs.  This
describes the funny characters you are seeing, although the actual
display values are not VT-100 style.  Hmm, more advanced VT terminals
(VT-320++?) allowed downloadable character sets, you could be getting
into these character sets.

References:
http://www.linuxdoc.org/HOWTO/Text-Terminal-HOWTO-20.html
http://www.ecc400.com/java/twproae.htm

If this this theory is correct, you should be able to exit your
terminal program and restart it and the character set would be reset,
giving you back your lower case letters.

If this is what is happening, something is sending a bogus escape
sequence out the console port.

gvb


At 02:08 PM 3/21/01 +0100, Stefan Nunninger wrote:

[snip]

>It might well be that the ramdisk is overwritten though. This could
>explain why it can not be loaded. Still I can not find a reason for
>the kernel to stop or to print such strange characters on the serial
>line.
>
>Do you (or anyone else) have some other suggestion what I could do?
>
>Thank you
>         Stefan
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
