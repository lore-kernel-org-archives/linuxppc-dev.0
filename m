Date: Thu, 7 Oct 1999 18:21:56 +0200
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: ADB probing
Message-Id: <19991007182156.030455@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 7, 1999, Michael Schmitz
<schmitz@opal.biophys.uni-duesseldorf.de> wrote:

>I'd rather not poll the ADB bus if it can be avoided. How does MacOS detect
>a new mouse device? But you could always force a bus reset and rescan via 
>/dev/adb. 

Be careful that the bus reset will cause an automatic re-probing and
re-init of the bus and devices by the drivers in mac_keyb.c. (This way,
we could make a userland tool that sends the bus reset and have a real
hot-swap ADB, just reset the bus after the hot swap). This feature is
mainly used by the sleep code for now.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
