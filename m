Message-ID: <3EA94CB4.8050509@embeddededge.com>
Date: Fri, 25 Apr 2003 10:56:52 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: "Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: _PAGE_HWWRITE missing in pte_mkdirty()?
References: <IGEFJKJNHJDCBKALBJLLAEEHFMAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joakim Tjernlund wrote:

> I noticed that pte_mkdirty() does not set the change bit(HWWRITE) when
> dirtying a page. I think it should. Is there a reason why it doesn't?

A dirty page doesn't necessarily indicate a write enabled page.  Setting
_PAGE_HWWRITE without _PAGE_RW is an error.  On PPC, RW and DIRTY are
software status bits, HWWRITE actually contols write access.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
