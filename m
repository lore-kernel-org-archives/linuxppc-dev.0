Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <393D6CF8.EC5D5777@lucent.com>
Date: Tue, 06 Jun 2000 16:28:24 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
Subject: Re: HELP: Linux Net Driver confusions
References: <393C11DD.1EDA3EC1@lucent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Roberts wrote:
> I am trying to write a network driver [...]
> In particular, I am trying to use non-ethernet headers, and cannot
> get the kernel to deliver a ping packet (ICMP protocol) back to the
> ping program even though the driver delivers the packets OK. BUT --
> essentially the same driver does seem to work on PowerPC linux....

Thanks to Jonathan Brauer, I got it to work.

Remarkably, the value in skb->protocol is in network byte order,
not the natural byte order of the current CPU. So changing:
	skb->protocol = ETH_P_IP;
to:
	skb->protocol = htons(ETH_P_IP);
made it work.

Note that the PowerPC byte order is the same as network order,
which is why it worked on the PowerPC but not the i586.

	[sent to both c.o.l.dev.sys and linuxppc-embedded
	 because I queried both.]


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
