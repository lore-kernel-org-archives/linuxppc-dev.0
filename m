Message-ID: <3E43D74F.9000208@embeddededge.com>
Date: Fri, 07 Feb 2003 10:57:03 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: GUARDED attribute not set by consistent_alloc()
References: <IGEFJKJNHJDCBKALBJLLKEANFKAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> ioremap() adds _PAGE_GUARDED if _PAGE_NO_CACHE is set. Should not
> consistent_alloc() also add _PAGE_GUARDED?

No.  ioremap() is used to map device registers, where operation
order is important.  consistent_alloc() maps real memory, where
setting guarded wouldn't change any behavior and would cost
significant pipeline drain cycles.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
