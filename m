Message-ID: <3C084F22.3030505@embeddededge.com>
Date: Fri, 30 Nov 2001 22:31:46 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: frowand@mvista.com
Cc: paulus@samba.org, Ralph Blach <rcblach@us.ibm.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/
References: <OF04BCE99E.8AF57CF2-ON85256B14.00425D94@raleigh.ibm.com > <15368.891.368917.13579@argo.ozlabs.ibm.com> <3C0814AC.455D6FEA@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Frank Rowand wrote:

> ....Some concrete
> examples of core / chip / board are:
>
>   403
>     403GCX
>   405
>     405cr
>     405gp
>       walnut
>       cpci405
>       ep405
>     stb03xxx
>       redwood-4
>     NPe405H
>     NPe405L

I think the 4xx has always had this backward from other PowerPC platform
definiitons.  While we should define processor cores, their peripherals,
and boards, the least common denominator is the processor core.  With the execption
of few boards (the Sandpoint comes to mind), simply configuring a board
type will allow you to know which processor package is used and further
the processor core.  If I say "Walnut" configuration, I already know everything
else, I don't need to be asked all of the other configuration questions.
Our files should also follow this structure.  The Walnut configuration file
should include 405GP (which defines peripherals) which should then include
the processor core definitions (if necessary).  This way, when a new processor
package with a different peripheral configuration is added, all you need to
do is ensure the proper lower level core file is included, you don't have
to update all of the board configuration files with stuff they don't care about.

If, in this example, the Walnut had different processor types available, it
would make sense within that configuration to ask the processor type, but no
one else would (nor should) care.  Again, the file structure would follow,
with the Walnut board configuration including the appropriately configured
processor package.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
