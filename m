In-Reply-To: <38062B18.A959825E@mondonet.net>
Date: Thu, 14 Oct 1999 13:06:16 +0200
To: Mario Scarpa <m.scarpa@mondonet.net>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: serial on lombard
Message-Id: <19991014130616.001878@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 14, 1999, Mario Scarpa <m.scarpa@mondonet.net> wrote:

>there's something I cannot get rid of. When I try to
>use minicom to dial with the internal modem of my
>lombard 400MHz I get a "/dev/ttyS0 no such file or dir"
>error; when I try to use setserial or stty on the same
>device everything works ok. I'm using debian potato.
>Attached there 's the 'strace minicom' output: hope this helps.

This exact same problem happens on my wallstreet. I'm not yet 100% sure,
but I think this is because minicom sets up some kind of timeout on the
open call via an alarm signal which fails since the powerbook internal
modem will block the opening process for about 2.5 second in the open
call. We added this tempo since the modem is only powered up when the
port is opened, and it needs approximately this time before beeing able
to answer commands. This used to cause most connection scripts
(especially default PPP scripts) to fail.

Fixing minicom is in my todolist, I'll try to give it a look next we.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
