To: bradbosch@attbi.com
Cc: "Mark A. Greer" <mgreer@mvista.com>, Q-ha Park <qha@infoeq.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: using bdi2000 to debug ppcboot on mpc7455 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 25 Sep 2003 09:25:51 CDT."
             <16242.64239.133401.668446@waldo.lisle.iphase.com>
Date: Tue, 30 Sep 2003 23:32:41 +0200
Message-Id: <20030930213246.6FC87C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <16242.64239.133401.668446@waldo.lisle.iphase.com> you wrote:
>
> In addition to the issue Mark pointed out, you can't use soft
> breakpoints while you are running from ROM which is the common case
> for the early init parts of U-Boot.
>
> Also, once U-Boot has relocated itself, you need to identify the new
> base address and inform gdb of the new load address.

And not to forget that, in the very  early  startup  code  (like  the
symbol  "boot_cold" mentioned by Q-ha Park), the memory controller is
still running in the reset configuration, i. e.  the  PC  will  still
point  to the reset vector area (0x0000'01xx or 0xFFF0'01xx), and NOT
yet  to  the  addresses  in  the  U-Boot  symbol  table.  Only  after
"in_flash" the symbols are correct.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"A little knowledge is a dangerous thing."                - Doug Gwyn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
