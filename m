To: Owen Green <owenjinggreen@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Fast HDLC driver
References: <20021119161020.83422.qmail@web20104.mail.yahoo.com>
From: Roland Dreier <roland@topspin.com>
Date: 19 Nov 2002 08:55:08 -0800
In-Reply-To: <20021119161020.83422.qmail@web20104.mail.yahoo.com>
Message-ID: <52ptt1bitv.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Owen" == Owen Green <owenjinggreen@yahoo.com> writes:

    Owen> most of them calls netif_rx from inside interrupt_handler (I
    Owen> don`t think this is the best place for doing that, watchdog
    Owen> may expire if the interface gets very busy..)

I don't have a specific answer about HDLC, but I think calling
netif_rx() from interrupt context is correct.  netif_rx() doesn't do
anything except queue the packet for processing and then mark the
network softirq.  In fact if you want to call netif_rx() from
non-interrupt context then you have to use the netif_rx_ni() function
to make sure the softirq runs soon enough.

Best,
  Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
