Message-ID: <3E5CE524.5020802@devcom.cz>
Date: Wed, 26 Feb 2003 17:02:44 +0100
From: Jan Damborsky <jan.damborsky@devcom.cz>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Unstable MPC8245 board
References: <20030225164619.B2761@saturn.billgatliff.com> <20030225230333.GA20099@mail.cryptoapps.com> <20030225193437.A3753@saturn.billgatliff.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


William A. Gatliff wrote:

 >What's a C construct that would virtually guarantee a burst read or
 >write?
 >
 >
I use MPC8xx and I had some problem with RWM bursting a two month ago.
PPC core uses bursting in several situations, not always.
For example, with I-cache and D-cache disabled, there are no bursts when
reading
instructiontions or reading or writting data from or to RWM, there are
only single beat
read or write cycles occuring on bus.
When enabled I-cache or D-cache in write-through mode, there are only
burst reads used,
no burst writes. In order to force PPC core to use burst-write cycles,
it is necessary to enable
D-cache working in copyback mode.
So when I want to test burst reads and burst writes:
[1] I enable D-cache in copyback mode (not so trivial as enable only
I-cache working)
[2] allocate a large array of longs (for example ten times more then
size of D-cache is)
[3] writting pseudo random data to this array.
[4] Verifying written data.
What happens:
When writting data, these are stored in D-cache until there is no free
place in D-cache.
Then when writting more data, older data from D-cache are stored in RWM
by means
of burst writes in order to make free place for newer data.
When verifiyng, data are read to cache from RWM by means of burst reads.
It is only a little example I used.
                                                                      HANYS


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
