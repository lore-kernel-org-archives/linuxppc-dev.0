Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "'Mark Phillips'" <thewalthamgroup@netscape.net>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Networking problems, linuxppc2.4, RPX CLLF, Montavista
Date: Fri, 4 May 2001 16:55:57 +0200
Message-ID: <000001c0d4aa$53d6d190$0a01a8c0@Win1>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <76690476.23485428.C7F6CBA8@netscape.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks!

This solved my problem. I saw that ip address 127.0.0.1 was used in
a telnet session and that made me to look over my dhcp server conf.
Once I gave my board a real hostname and removed the nis domain option
things started to work!

It seems that 2.4 needs a real hostname(2.2 does not) to operate
correctly. If no hostname is specified in the dhcp conf, Linux will
use the IP address as hostname and dnsdomaninname.

   Jocke

-----Original Message-----
From: Mark Phillips [mailto:thewalthamgroup@netscape.net]
Sent: Friday, May 04, 2001 15:53
To: joakim.tjernlund@lumentis.se
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Networking problems, linuxppc2.4, RPX CLLF, Montavista


Jocke,

You can try adding /bin/strace before /bin/telnetd in your /etc/inetd.conf
file on the target, so the line looks like:
telnet stream tcp nowait root /bin/strace /bin/telnetd telnetd -L/bin/login
Then try to telnet to the target.  See what files it's reading, etc. before
it boots you off.  This may point you in the right direction.

HTH,
Mark Phillips
<joakim.tjernlund@lumentis.se> wrote:
>
>
> Hi all
>
> I have this strange network problem and I can not figure out whats wrong.
>
> I running linuxppc2.4 from Cort's tree on a RPX CLLF(cpu PPC860T) and a
file
> system
> from the Montavista CDK 1.2(with the latest updates). I NFS mount my root
> fs, created a
> local user(I can login on my local user). Ping works both ways(from RPX to
> my Linux host
> and vice versa).
>
> But I can not telnet or ftp from my linux host to RPX, I get "connection
> refused"(inetd is
> running on RPX) and if I telnet(or ftp) from RPX to my Linux host it takes
> 1-2 minutes
> until I get a login prompt.
>
> BUT if I boot the 2.2.14 kernel that came with the Montavista CDK 1.2
> everything works!
>
> I have no idea what I am doing wrong. I have searched all www & mailing
> lists I can think of
> but I seem to alone with this problem.
>
> Please help.
>
>        Jocke
>
>
>
>
--
Please reply to markphillips@alum.mit.edu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
