Date: Fri, 5 Jan 2001 15:25:00 -0500 (EST)
From: alex avriette <alex@macachu.yi.org>
Reply-To: <alex@cosmo.allay.net>
To: <linuxppc-dev@lists.linuxppc.org>
cc: <drscholl@users.sourceforge.net>
Subject: Endianness and comparing IP's
Message-ID: <Pine.LNX.4.31.0101051513430.1016-100000@macachu.ex-pressnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am still working with the opennap software (available at
opennap.sourceforge.net) to resolve a strange issue whereby two IP's are
reported as equal, but fail a conditional for equality. the code in
question is here:

  if (BSWAP32(ip) != con->ip)
  {
    log ("server_login: ip=%u con->ip=%u", BSWAP32(ip), con->ip);
    log ("server_login: %s does not match %s (%s)",
         con->host, fields[0], my_ntoa (ip));
    con->destroy;
    return;
   }

the output of this is here:

server_login: ip=523706576 con->ip=523706576
server_login: 208.32.55.31 does not match cygnus.theblackmoor.net
(208.32.55.31)

so what I see happening is that BSWAP32(ip) doesnt equal con->ip which is
reported by the log (as seen earlier on the list, it uses a v*printf
followed by a fputs) as indeed being equal. I dont have host entries for
this host nor any of the other hosts I am trying to connect to.

Apparently this software is developed on x86 machines and tested in
Solaris on Suns for big endian compatibility. The code works fine on PC's
in this configuration:

    if (ip != BSWAP32 (con->ip))
    {
      log ("server_login: %s does not match %s (%s)",
           con->host, fields[0], my_ntoa (ip));
      con->destroy;
      return;
    }

I am not familiar with the concept of endianness and it hasnt quite been
explained sufficiently to me. I have Cc'ed the primary developer of
opennap on this message, though I am pretty familiar with the concepts and
workings of the code.

Thanks in advance.

alex


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
