Subject: Re: SunGem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031026152004.2bf89e87.pochini@shiny.it>
References: <20031026152004.2bf89e87.pochini@shiny.it>
Content-Type: text/plain
Message-Id: <1067312851.3328.3.camel@gaston>
Mime-Version: 1.0
Date: Tue, 28 Oct 2003 14:47:32 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-10-27 at 01:20, Giuliano Pochini wrote:
> I have a Windtunnel G4 and I'm using the SunGem ethernet module. The G4 is
> connected to a 10mbps hub. When the hub is turned off or when the eth cable
> is not connected at all, it prints these useless messages in the logs all
> the time:
>
> Oct 26 15:00:02 localhost kernel: eth0: switching to forced 10bt
> Oct 26 15:00:23 localhost kernel: eth0: switching to forced 100bt
> Oct 26 15:00:30 localhost kernel: eth0: switching to forced 10bt
> Oct 26 15:00:50 localhost kernel: eth0: switching to forced 100bt
>
> Is it supposed to do so ?

Yes it is. When it finds no link using autoneg, sungem tries repeately
some fixed speeds, this allows it to work with some nasty hubs that
don't play fair with autoneg. Note that a newer version still only in
my tree will actually disable this algorithm on most PHYs used on
Apple machines as those PHYs usually implement this same mecanism.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
