From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15612.47259.378190.93509@argo.ozlabs.ibm.com>
Date: Tue, 4 Jun 2002 22:54:51 +1000 (EST)
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: More details on the telnet with CONFIG_PIN_TLB problems
In-Reply-To: <20020603075322.GI6765@zax>
References: <20020603075322.GI6765@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Looks like Ben and I have found the problem; Ben added an isync and a
sync to set_context() after setting the PID register and that seems to
have fixed it.  It makes sense, as isync invalidates the shadow DTLB
and ITLB.  (The sync may be unnecessary.)

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
