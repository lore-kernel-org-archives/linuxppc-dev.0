Message-ID: <3BE18AE4.1070507@mvista.com>
Date: Thu, 01 Nov 2001 12:48:20 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: drivers - modules versus compiled in?
References: <20011031211539.SIZF7882.tomts5-srv.bellnexxia.net@there>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin B. Hendricks wrote:


> Are the allocated memory areas differnt?

Yes, this is usually why you may see different behavior.  First,
the module itself is allocated from kernel memory that other errant
pointers could access that wouldn't otherwise.  Usually, the problem
is related to buffers or data structures the driver allocates that
are further used for DMA operations.  Things like 'virt_to_bus()'
won't work on static objects in a module, while it will in a
compiled driver.

> Any hints as to what might have changed?

Provide some hints to us :-).  What type of system, what
kernel, what driver?

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
