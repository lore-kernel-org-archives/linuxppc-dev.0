Message-ID: <3E161656.1040108@embeddededge.com>
Date: Fri, 03 Jan 2003 18:01:42 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel patch: 8xx FEC extensions
References: <20021230162621.1741CC6139@atlas.denx.de>	<3E10EF1C.5040505@embeddededge.com> <15894.4788.289339.561234@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:


> If we have a variable which is being updated both by the mainline and
> an interrupt handler,...

In this case, it wasn't being updated by both.  It was updated in
an interrupt handler, then a mainline function would test the value later.
The mainline function had the optimization habit of caching the value
in a processor register since it didn't know it was being changed outside
of the scope of the function.  The volatile declaration works just fine
in this case.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
