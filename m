In-Reply-To: <v03130308b3ec440550d3@[192.168.1.1]>
Date: Fri, 27 Aug 1999 16:32:37 +0200
To: "David D. Kilzer" <ddkilzer@computer.org>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: mac-2.3.14.diff: adb
Message-Id: <19990827163237.012324@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 27, 1999, David D. Kilzer <ddkilzer@computer.org> wrote:

>Well, drivers/macintosh is PPC ADB code.  If drivers/macintosh shouldn't
>exist, then shouldn't it be changed or moved at a higher level?
>
>In reality, there is some ADB mouse code in drivers/char, too, so I wonder
>if drivers/char/adb would make more/less sense than drivers/adb?

I personally like drivers/macintosh, from my point of view, it makes
things clearer. except for macserial, which should be killed in favor of
a more generic zilog driver, most of those drivers are really mac-centric
stuffs with no "generic" userland interface. Also, drivers/char is
already enough of a mess like this.

I didn't look at the those new patches, but the adb code in
driver/macintosh was abstracted to use a generic "adb controller"
sub-driver interface some time ago and so adb.c should be platform
independant (useable as-is on PPC and 68k). mac_keyb.c too, with all it's
specific mouse support.

David, did you make a generic (m68k/ppc) cuda driver too ?

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
