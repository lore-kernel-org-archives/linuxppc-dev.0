Subject: Re: 2.6.6 kernel oops on ifconfig eth0 mtu 1300
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	"David S. Miller" <davem@redhat.com>
In-Reply-To: <1084693466.4708.18.camel@localhost>
References: <1084643442.4708.3.camel@localhost>
	 <1084669527.6444.2.camel@gaston>  <1084693466.4708.18.camel@localhost>
Content-Type: text/plain
Message-Id: <1084699142.7777.10.camel@gaston>
Mime-Version: 1.0
Date: Sun, 16 May 2004 19:19:03 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-05-16 at 17:44, Soeren Sonnenburg wrote:
> On Sun, 2004-05-16 at 03:05, Benjamin Herrenschmidt wrote:
> > On Sun, 2004-05-16 at 03:50, Soeren Sonnenburg wrote:
> > > Hi.
> > >
> > > When I have some ethernet connection and then do
> > > ifconfig eth0 mtu 1300 I get an immediate kernel panic (kernel 2.6.6)
> > > powerbook g4 15" 1ghz.
> > >
> > > (xmon trace (jpeg) on request)
> >
> > Yes, please, the trace
>
> doesn't it happen when you do ifconfig eth0 mtu 1300 ? anyway here it
> is: use a web-browser to view it (it is a redirect):
> http://www.nn7.de/kernel/mtu1300.jpg

Heh, didn't want to crash the laptop today. I CC'ed David Miller on that
as he is the main author of the driver.

David: the crash is apparently us doing skb_put of ETH_FRAME_LEN + RX_LEN,
so we tune the skb allocator to the MTU ? It's commented out in my bk
snapshot but then, I may be missing something. Should we change sungem to
use the mtu instead of ETH_FRAME_LEN ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
