From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Fink <billfink@mindspring.com>
Cc: Anton Blanchard <anton@samba.org>,
	<linuxppc-dev@lists.linuxppc.org>,
	"David S. Miller" <davem@redhat.com>
Subject: Re: GigE Performance Comparison of GMAC and SUNGEM Drivers
Date: Mon, 19 Nov 2001 13:54:59 +0100
Message-Id: <20011119125459.20923@smtp.adsl.oleane.com>
In-Reply-To: <20011119111548.F4531@krispykreme>
References: <20011119111548.F4531@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>
>Hi,
>
>> The GMAC driver had significantly better performance.  It sustained
>> 663 Mbps for the 60 second test period, and used 63 % of the CPU on
>> the transmitter and 64 % of the CPU on the receiver.  By comparison,
>> the SUNGEM driver only achieved 588 Mbps, and utilized 100 % of the
>> CPU on the transmitter and 86 % of the CPU on the receiver.  Thus,
>> the SUNGEM driver had an 11.3 % lower network performance while
>> using 58.7 % more CPU (and was in fact totally CPU saturated).

This is weird and unexpected as GMAC will request interrupt for each
transmitted packet while sungem won't

However, I noticed that sungem is getting a lot of rxmac and txmac
interrupts, I'll investigate this a bit more.

(Could you check the difference of /proc/interrupts between a test
with gmac and a test with sungem ?)

Note that I just updated sungem in my rsync tree, it now has all of
the power management and ethtool/miitool support.
I plan to replace gmac with sungem completely, so it would be nice to
figure out where that problem comes from.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
