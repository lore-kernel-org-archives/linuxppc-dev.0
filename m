Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "'Tom Rini'" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: tx_full v.s tx_free race fix in 8xx_io/enet.c?
Date: Wed, 3 Dec 2003 18:08:17 +0100
Message-ID: <002501c3b9c0$0c759e00$0a01a8c0@LUMENTIS02>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <20031203161513.GG912@stop.crashing.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On Tue, Dec 02, 2003 at 12:00:27AM +0100, Joakim Tjernlund wrote:
>
> > It seems to me that the old tx_full stuff is working better that the
> > new tx_free.
>
> What problem are you seeing without making any changes to the
> code as it
> stands?

I have impl. the NAPI method in enet.c and had removed the spin_lock_irq()
in the xmit procedure since I don't belive I need these any more and all was well.
Then I discoverd I had forgotten to apply the tx_free change so I added it and
then I got an oops. Restoring the spin_lock_irq() makes the behaviour identical.

Thats why I wonder what race they are supposed to fix since the only difference
I get is the above oops on a mpc862.

Something I find a bit odd is that I can run ping -s 1472 -f <myTargetIp>
without problems, but if i "jump start" the ping with "ping -s 800 -f <myTargetIp> -l 8"
I start to loose packages. Ifconfig shows no errors for both cases.
Do you get the same?

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
