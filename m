Date: Fri, 29 Oct 1999 12:34:30 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David Edelsohn <dje@watson.ibm.com>
cc: Lou Langholtz <ldl@chpc.utah.edu>, linuxppc-dev@lists.linuxppc.org,
        gdt@linuxppc.org, cort@cs.nmt.edu
Subject: Re: linux-2.2.13pre15 stability w/ head.S patch 
In-Reply-To: <9910281739.AA35624@marc.watson.ibm.com>
Message-ID: <Pine.HPX.4.10.9910291132120.18743-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 28 Oct 1999, David Edelsohn wrote:

> 
> 	The general, conservative procedure that should be followed for
> any BAT change is:
> 
> 	li	rX, 0
> 	mtdbatu N, rX
> 	isync
> 	mtdbatl N, rL
> 	mtdbatu N, rU
> 	isync
> 
> I do not see the posted assembly code performing any isync's to prevent
> speculation.  mtspr does not produce complete serialization in the
> pipeline, and the serialization is implementation-dependent.

Is it true even if you know that you have address translation turned off ?  
I thought that mtspr (to privileged registers, not ctr/lr) are executed
strictly in the order they appear, so that no intermediate incoherent
state could appear.

OTOH when address translation is turned on (or when the its state is
unknown) I would have put an isync _before_ the first mtdbatu to make
sure that it does not interfere with previous instructions (this is
required from the manuals AFAICT).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
