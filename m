In-Reply-To: <199910141600.SAA10832@opal.biophys.uni-duesseldorf.de>
Date: Thu, 14 Oct 1999 18:10:31 +0200
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: serial on lombard
Message-Id: <19991014181031.019116@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 14, 1999, Michael Schmitz
<schmitz@opal.biophys.uni-duesseldorf.de> wrote:

>And I fixed it by modifying the serial port startup() code. Seems to work as
>well - do we really need to wait that long for the modem to power up, or
>will the modem just refuse to handshake while initializing?

What did you change in the startup() code ?

On the wallstreet, at least, (and possibly on the Lombard, if Paul could
check that the FCR bits are actually the same), without this delay, the
modem will not answer to AT commands. This causes almost all PPP dialers
out there to fail with their default scripts. It's possible to work
around this on some dialers (kppp has a tempo setting) but not all of
them. That's the main reason why we added this code. (I think Paul added
the clean sleep code, I originally throwed an horrible mdelay() which
locked the entire kernel waiting for the modem).


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
