From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15440.55617.344240.588918@argo.ozlabs.ibm.com>
Date: Fri, 25 Jan 2002 15:04:17 +1100 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: OpenPIC_NumInitSenses
In-Reply-To: <3C50C615.7090503@embeddededge.com>
References: <15439.64102.68217.293733@argo.ozlabs.ibm.com>
	<3C50C615.7090503@embeddededge.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> Just like the comment states, we need it because of the way the
> 107/EPIC maps on the "standard" OpenPIC structure.  The simple

Well, you need some way to tell the openpic code how many ISRs there
are.  You don't _need_ to use OpenPIC_NumInitSenses to do that. :)

> answer is the interrupts are offset by 16 on the EPIC, so the
> interrupt numbers don't match the offset value.  The EPIC may
> say there are only 24 vectors, but for the code to work we need
> to tell the OpenPIC code there are up to 16 more than that.

... and they are not contiguous either (I just looked at the MPC107
manual).  Who designed this thing?

Anyway, openpic_set_sources will let you say clearly and explicitly
where the ISRs are and how many of them there are.  I have checked it
in, have a look - I think it should let you handle the MPC107 quite
painlessly, but if not let me know what else is needed.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
