From: Benjamin Herrenschmidt <bh40@calva.net>
To: Martin Costabel <costabel@wanadoo.fr>, <linuxppc-dev@lists.linuxppc.org>,
        Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: rtc again...
Date: Thu, 3 Aug 2000 11:30:49 +0200
Message-Id: <20000803093049.3478@mailhost.mipsys.com>
In-Reply-To: <398934C7.663E6BD9@wanadoo.fr>
References: <398934C7.663E6BD9@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I am using it as module both for 2.2.17-bk and for 2.4.0-test5. They
>don't give the same time, and I think it is the one in 2.4.0 that is
>right. I am at GMT+2:00, and the time in 2.2.17 is 2 hours early. When I
>change /etc/sysconfig/clock from "UTC=false" to "UTC=true", both times
>shift by 2 hours, but the discrepancy remains.
>
>The following patch for bitkeeper linuxppc_2_2 fixes this problem for
>me. It brings 2.2.17pre13 in line with 2.4.0-test5 (and MacOS). I cannot
>test the VIAPMU part, so maybe there the offset is necessary, but for
>the VIACUDA part, it seems wrong.

You patch reverts a fix I made some time ago. Basially, what probably
happens is that your RTC is in UTC time, not in local time. The Mac RTC
is supposed to be in local time, the offset corrects the kernel time on
boot to account for this. Previously, without that fix, the kernel used
to boot with a bogus UTC time until userland fixes it.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
