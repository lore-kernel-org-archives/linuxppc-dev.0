Date: Wed, 09 Apr 2003 16:32:14 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: dcbz works on 862 everywhere!
In-reply-to: <3E8DA82A.9070809@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>
Cc: Till Straumann <strauman@slac.stanford.edu>,
	Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLAEODFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> As I said in the past, I'm sensitive to the code in the TLB exception
> processing.  So do something to remove code and streamline the process
> and I'm really interested.  Do something to add more code and it's
> going to get placed pretty low in my pile of things to do.
>
> Thanks.

If you make swapper_pg_dir 64KB aligned, you can removed
ori r21, r21, swapper_pg_dir@l instructions in
DataStoreTLBMiss, DataTLBError and InstructionTLBMiss

I did it with the following, ugly, hack in vmliunx.lds:
 swapper_pg_dir = ALIGN(0x10000);
 . = . + 4096;

I guess there is a better way to this.

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
