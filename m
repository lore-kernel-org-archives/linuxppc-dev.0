To: Ricardo Scop <scop@digitel.com.br>
Cc: Owen Green <owenjinggreen@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Fast HDLC driver
References: <20021119161020.83422.qmail@web20104.mail.yahoo.com>
	<52ptt1bitv.fsf@topspin.com> <200211201439.45731.scop@digitel.com.br>
From: Roland Dreier <roland@topspin.com>
Date: 20 Nov 2002 09:41:59 -0800
In-Reply-To: <200211201439.45731.scop@digitel.com.br>
Message-ID: <52r8dg9lzs.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Ricardo" == Ricardo Scop <scop@digitel.com.br> writes:

    Roland> I don't have a specific answer about HDLC, but I think
    Roland> calling netif_rx() from interrupt context is correct.
    Roland> netif_rx() doesn't do anything except queue the packet for
    Roland> processing and then mark the network softirq.  In fact if
    Roland> you want to call netif_rx() from non-interrupt context
    Roland> then you have to use the netif_rx_ni() function to make
    Roland> sure the softirq runs soon enough.

    Ricardo> Hmm, is this true? QSLinux driver calls netif_rx() from
    Ricardo> thew interrupts bottom half; it it ok?

This should probably be OK.  First, a bottom half is still interrupt
context.  Second, if I recall correctly, Linux 2.2 does not even
define netif_rx_ni().  If the driver works well there's no reason to
change it.

Best,
  Roland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
