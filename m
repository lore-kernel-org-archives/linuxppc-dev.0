Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17526.59069.781220.922878@cargo.ozlabs.ibm.com>
Date: Fri, 26 May 2006 21:30:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] force 64bit mode in system_reset_fwnmi for broken POWER4
	firmware
In-Reply-To: <20060523130717.GA22364@suse.de>
References: <20060522164111.GA14462@suse.de> <20060523130717.GA22364@suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> According to this change for EXCEPTION_PROLOG_COMMON, I get still into
> decremeter_common, but its not fatal anymore because the cpu is now in
> 64bit mode and the stack is forced to PACAKSAVE(r13).
> 
>         subi    r1,r1,INT_FRAME_SIZE;   /* alloc frame on kernel stack  */ \
>         beq-    1f;                                                        \
>         ld      r1,PACAKSAVE(r13);      /* kernel stack to use          */ \
> -1:     cmpdi   cr1,r1,0;               /* check if r1 is in userspace  */ \
> +1:                                     \
> +       cmpdi   cr1,r29,0x42;           \

Ummm, what's r29 supposed to have in it here?

> +       bne     cr1,2f;                 \
> +       li      r29,2f@l;               \

And why are we setting it?

Does it look like the SRR0 and SRR1 values are correct when we get
this problem occurring?  Is it just the MSR that is bogus?

Paul.
