From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@samba.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: More details on the telnet with CONFIG_PIN_TLB problems
Date: Tue, 4 Jun 2002 18:43:44 +0200
Message-Id: <20020604164344.26329@smtp.wanadoo.fr>
In-Reply-To: <3CFCF31B.50103@embeddededge.com>
References: <3CFCF31B.50103@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>> Looks like Ben and I have found the problem;
>
>Cool.  I know this works OK on 8xx, I just haven't finished a working
>tlb miss handler that will work regardless of the page size.

>From my understanding, it seems the problem on 4xx is that the
shadow TLBs aren't keeping the PID. Thus the following scenario
would break (entirely in kernel, no rfi, no interrupt) :

   - copy_tofrom_user
   - context switch
   - copy_tofrom_user

In that case, the PID is changed, but stale DLB entries are still
around, thus screwing up the second copy_tofrom_user.

The isync;sync I added fixes it by clearing the shadow DTLB.
I haven't yet tested without the sync, the 405 doc is unclear about
what instruction flush the shadow DTLB, unlike it does for the shadow
ITLB. The isync may be enough.

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
