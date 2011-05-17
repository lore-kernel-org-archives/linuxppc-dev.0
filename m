Return-Path: <paulus@ozlabs.org>
Date: Tue, 17 May 2011 20:28:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 11/13] kvm/powerpc: Handle some PAPR hcalls in the kernel
Message-ID: <20110517102840.GA7924@brick.ozlabs.ibm.com>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104530.GL2837@brick.ozlabs.ibm.com>
	<2C53DD5C-4F74-4FC4-9C65-4F401AE9AF78@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2C53DD5C-4F74-4FC4-9C65-4F401AE9AF78@suse.de>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 17, 2011 at 09:54:35AM +0200, Alexander Graf wrote:

> Not sure I like the name - when is it used? :)

When the real-mode hcall handler decides it can't handle the hcall and
wants to pass it up.

> Also, if it's not in the PAPR, the guest should never receive it, right?

Right.  It's purely an internal value.

> > +	/* See if this is something we can handle in real mode */
> > +	cmpwi	r12,0xc00
> 
> use the define please

OK

> > +	beq	hcall_real_mode
> 
> This is simply a hcall helper, as the name suggests. So the comment
> is slightly misleading - it should rather read like "Try to handle
> hypercalls in real mode".

Hmmm, OK, that's what it was trying to indicate.  I could add "try" to
the name if you like.

> > +	cmpdi	r3,H_TOO_HARD
> > +	beq	hcall_real_fallback
> 
> Ah, very good. Please mark the constant as "for internal use only"
> then, as that's certainly fine :).

Cool, will do.

> > +	li	r12,0xc00
> 
> use the define please :)

OK.

Thanks,
Paul.
