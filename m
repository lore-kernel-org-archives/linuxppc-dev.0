Message-ID: <F4A375A73CC9D411987A00C00D004A310D8BB2@EMAIL>
From: "Clayton,Keith - Programmer" <Clayton@ltcc.cc.ca.us>
To: "'alex@cosmo.allay.net'" <alex@cosmo.allay.net>,
        linuxppc-dev@lists.linuxppc.org
Cc: drscholl@users.sourceforge.net
Subject: RE: Endianness and comparing IP's
Date: Fri, 5 Jan 2001 13:45:33 -0800 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is the BSWAP32 macro a destructive macro . . destructive in the sense that
the value ip is modified?

If so, you run BSWAP32(ip) in the condition and ip is modified.  Conditional
fails . . pass ip through BSWAP32 again and the byte order is back to the
original!

Its quite possible that ip is coming to you in a form that is already
byte-order correct . .

Try this . . remove all the BSWAP32 refs and before the condition put in
this line

log ("server_login: ip=%u con->ip=%u", ip, con->ip);


I'd venture a guess that ip will show as equivalent to con->ip . . so the
use of BSWAP32 here is incorrect


Keith Clayton
Programmer/Analyst, Lake Tahoe Community College
clayton@ltcc.cc.ca.us

"If you don't trust me with your source code, why should I trust you with my
computer"

No electrons were harmed in the creation of this email

> -----Original Message-----
> From:	alex avriette [SMTP:alex@macachu.yi.org]
> Sent:	Friday, January 05, 2001 12:25 PM
> To:	linuxppc-dev@lists.linuxppc.org
> Cc:	drscholl@users.sourceforge.net
> Subject:	Endianness and comparing IP's
>
>
> I am still working with the opennap software (available at
> opennap.sourceforge.net) to resolve a strange issue whereby two IP's are
> reported as equal, but fail a conditional for equality. the code in
> question is here:
>
>   if (BSWAP32(ip) != con->ip)
>   {
>     log ("server_login: ip=%u con->ip=%u", BSWAP32(ip), con->ip);
>     log ("server_login: %s does not match %s (%s)",
>          con->host, fields[0], my_ntoa (ip));
>     con->destroy;
>     return;
>    }
>
> the output of this is here:
>
> server_login: ip=523706576 con->ip=523706576
> server_login: 208.32.55.31 does not match cygnus.theblackmoor.net
> (208.32.55.31)
>
> so what I see happening is that BSWAP32(ip) doesnt equal con->ip which is
> reported by the log (as seen earlier on the list, it uses a v*printf
> followed by a fputs) as indeed being equal. I dont have host entries for
> this host nor any of the other hosts I am trying to connect to.
>
> Apparently this software is developed on x86 machines and tested in
> Solaris on Suns for big endian compatibility. The code works fine on PC's
> in this configuration:
>
>     if (ip != BSWAP32 (con->ip))
>     {
>       log ("server_login: %s does not match %s (%s)",
>            con->host, fields[0], my_ntoa (ip));
>       con->destroy;
>       return;
>     }
>
> I am not familiar with the concept of endianness and it hasnt quite been
> explained sufficiently to me. I have Cc'ed the primary developer of
> opennap on this message, though I am pretty familiar with the concepts and
> workings of the code.
>
> Thanks in advance.
>
> alex
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
