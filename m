Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C7AA49D.8020809@embeddededge.com>
Date: Mon, 25 Feb 2002 15:54:53 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Ashley <dash@xdr.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
References: <200202252027.g1PKRqt01988@xdr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Ashley wrote:


> #define ADDR 0xf0010000
> #define SIZE 0x00002000

Oh, now I remember......I found it amusing someone could think they
could just map the CPM memory and start reading and writing it.
You can't do stuff like that and expect the system to keep running
correctly.  The first 128 bytes of the DPRAM are initialized for
the SMC (whether you use it or not).  You have to be really, really
careful when you map anything like this, and you have to understand
the interaction of everything else that may also have access to these
memory spaces.  A common mistake is people map things like GPIO into
application space, and then think they can atomically update the
registers.  This doesnt' work because there may be drivers that
also do the same thing.

> The above program fails at about iteration 228 on linux 2.4.17. On 2.4.14
> it fails at an unpredictable iteration, from maybe 180 to 350. The number
> of other seemingly harmless shell comands executed, like "ls",

How does it fail?  If you are actually using the SMC as a console device
I'm surprised it runs that long.

There isn't anything wrong with mmap()......


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
