From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15460.50887.161245.222054@argo.ozlabs.ibm.com>
Date: Sat, 9 Feb 2002 17:50:47 +1100 (EST)
To: Val Henson <val@nmt.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix heartbeat
In-Reply-To: <20020208184610.E28166@boardwalk>
References: <20020208184610.E28166@boardwalk>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Val Henson writes:
>
> The heartbeat function will not execute properly on Gemini without
> this patch. (Check for cpu 0 removed from gemini_heartbeat.)

CHRP needs the heartbeat function called on all cpus, IIRC.

Clearly the heartbeat_count needs to be per-cpu or else pushed into
the heartbeat function.  How about we make it just

	if (ppc_md.heartbeat)
		ppc_md.heartbeat();

and let the heartbeat function do the if (!smp_processor_id()) and the
if (!heartbeat_count--) if it wants?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
