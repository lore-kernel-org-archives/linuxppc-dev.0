Subject: Re: Endianness and comparing IP's
To: <alex@cosmo.allay.net>
Cc: <linuxppc-dev@lists.linuxppc.org>, <drscholl@users.sourceforge.net>
Message-ID: <OF469E46EB.09315C5A-ON852569CB.0073FA54@pok.ibm.com>
From: "Jerome L Quinn" <jlquinn@us.ibm.com>
Date: Fri, 5 Jan 2001 16:07:50 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Check your types.  I suspect that you've got an implicit typecast between
unsigned int and something else going on.  So printf gives you the right
results, but the actual compare does not.

Jerry Quinn



alex avriette <alex@macachu.yi.org>@lists.linuxppc.org on 01/05/2001
03:25:00 PM

Please respond to <alex@cosmo.allay.net>

Sent by:  owner-linuxppc-dev@lists.linuxppc.org


To:   <linuxppc-dev@lists.linuxppc.org>
cc:   <drscholl@users.sourceforge.net>
Subject:  Endianness and comparing IP's




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
