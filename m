Message-ID: <20010119080217.1791.qmail@web11802.mail.yahoo.com>
Date: Fri, 19 Jan 2001 00:02:17 -0800 (PST)
From: xuelong wang <wang_xuelong@yahoo.com>
Subject: Questions about compliing ppcboot-0.6.2
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear sir,
I have a target board with a flash on it, and I¡¯d
like to put ppcboot-0.6.2 into it by a writer. But
when I compile ppcboot-0.6.2 under the environment of
RedHat Linux 6.2 and with the help of ppc_8xx-gcc
which is a compiling utility included by CDK1.2, the
following problems appeared.

1. A file can not be complied, the error message is:

>/usr/local/src/ppcboot/ppcboot->0.6.2/include/ppc_asm.tmpl:232:
Error:Rest of line >ignored. First >ignored character
is ¡®\¡¯.
>¡­
>¡­
>/usr/local/src/ppcboot/ppcboot->0.6.2/include/ppc_asm.tmpl:242:
Error:Rest of line >ignored. First >ignored character
is ¡®\¡¯.
>/usr/local/src/ppcboot/ppcboot->0.6.2/include/ppc_asm.tmpl:243:
Error:Rest of line >ignored. First >ignored character
is ¡®\¡¯.

These lines located in ppcboot-0.6.2/include/ppc_asm.
tmpl can be writed as follows:

>#define STD_EXCEPTION(n, label, hdlr)	\
>	. = n;				\
>label:					\
>	EXCEPTION_PROLOG;			\
>	lwz	r3,GOT(transfer_to_handler);\
>	mtlr	r3;		          \
>	addi	r3,r1,STACK_FRAME_OVERHEAD; \
>	li	r20,MSR_KERNEL;		 \
>	rlwimi	r20,r23,0,25,25;		 \
>	blrl	; 			 \
.>L_ ## label :				 \
>  .long	  hdlr - _start + EXC_OFF_SYS_RESET;\
>  .long	int_return - _start + EXC_OFF_SYS_RESET

Can you give me a hint to explain what happened.

2. When I read the Makefile of ppcboot-0.6.2/ (i.e.
ppcboot-0.6.2/Makefile), I find 4 lines like this:

> subdirs:
>  @for dir in $(SUBDIRS) ; do $(MAKE) -C $$dir ||
>exit 1 ; done
>depend dep:
> @for dir in $(SUBDIRS) ; do $(MAKE) -C >$$dir
.depend ; done

but I can not find the definition of ¡°MAKE¡± in this
file or the other files included by this package. Can
you tell me what ¡°MAKE ¡± is and where the definition
locates?

    3. If you think that I use the wrong versions of
RedHat Linux, or that I use the wrong CDK , or that
the way I compile ppcboot-0.6.2 is absolutely stupid,
please don't hesitate giving me a message.

   Thanks in advance.
          Best Regards
                 Yours sincerely  Xuelong Wang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
