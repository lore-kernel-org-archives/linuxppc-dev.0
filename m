Date: Mon, 20 Oct 2003 18:54:55 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: [PATCH] Remove 7  instructions in 8xx ITLB Miss when pinned TLBs
 is set
In-reply-to: <3F93FDA1.6030305@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLIEIEGAAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > I have updated the patch to address the modules issue. I have also included my response to Dans mail
> > since I forgot to include the list in that reply.
>
> Fine....I'll check it in.
>
>
> 	-- Dan

Thanks Dan

There is another small optimization that can be done in the TLB Miss/Error handlers. Move
branch instructions 1 instruction away from the test. That will give branch prediction
a chance to do its job. I did a run with LM bench and it did a difference (barley). The
down side is that the code gets harder to read. I found 5 branch instructions that
could be moved:
DTLB Error, 3 branches can be moved.
DTLB Miss, 1 branch can be moved.
ITLB Miss, 1 branch can be moved.

What do you think? Want a patch?

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
