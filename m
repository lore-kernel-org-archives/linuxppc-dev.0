Message-ID: <3F660AC4.8050003@embeddededge.com>
Date: Mon, 15 Sep 2003 14:53:56 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jean-Denis Boyer <jdboyer@m5t.com>
Cc: Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
References: <AB5AF73EAF23304EA1B932174137CED70303EA@m5tmail.m5t.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jean-Denis Boyer wrote:

> I have just tested your patch on 8260 and it fixes the problem when printk is called ...

The use of printk is strictly a debug function.  If it is necessary to see
it print out pretty, then use a different I/O path for the application or
dump out the log buffer separately.  Serial ports don't guarantee any
transactional operation with multiple users, printk isn't any different
although it does the bad thing of blocking interrupts while it processes
the message.

Adding this patch adds lots of interrupt latency and I would recommend
against it.  It appears there is a bug that should be fixed to ensure
the proper synchronization of the BDs, but not with such large scale
blocking of interrupts.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
