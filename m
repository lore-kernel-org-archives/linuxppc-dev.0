Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18496.56427.301039.954088@cargo.ozlabs.ibm.com>
Date: Sat, 31 May 2008 15:04:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v4] [POWERPC] Move to runtime allocated exception stacks
In-Reply-To: <1211259767-4796-1-git-send-email-galak@kernel.crashing.org>
References: <1211259767-4796-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> For the additonal exception levels (critical, debug, machine check) on
> 40x/book-e we were using "static" allocations of the stack in the
> associated head.S.
> 
> Move to a runtime allocation to make the code a bit easier to read as
> we mimic how we handle IRQ stacks.  Its also a bit easier to setup the
> stack with a "dummy" thread_info in C code.

Looks fine, with just one very minor comment:

> -	addi	r11,r11,THREAD_SIZE;					     \
> -1:	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
> +1:	addi	r11,r11,THREAD_SIZE;					     \
> +	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame     */\

You could make that a single addi r11,r11,THREAD_SIZE-INT_FRAME_SIZE
now.

Paul.
