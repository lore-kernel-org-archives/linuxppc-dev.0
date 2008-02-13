Return-Path: <dhbaird@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 8BB2BDDF34
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Feb 2008 06:02:11 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so163051wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 11:02:10 -0800 (PST)
Message-ID: <440abda90802131102q234e870fx2cbf12fb3119fd0a@mail.gmail.com>
Date: Wed, 13 Feb 2008 12:02:09 -0700
From: "David Baird" <dhbaird@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: TLB Miss booting linux kernel on ppc 405
In-Reply-To: <5ee408090802131049u652ef867wff034b4ccb1067f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5ee408090802130850w130ce09an507ca5c4d41cc5a8@mail.gmail.com>
	<440abda90802130917x79c3c990j6a1fc7c12ba05ed7@mail.gmail.com>
	<5ee408090802130938u7d069636g42a496e489fe5b80@mail.gmail.com>
	<440abda90802130951h7a23743asc85454bf089c7e55@mail.gmail.com>
	<5ee408090802131003m4b8e632cu931769bc77f9b439@mail.gmail.com>
	<440abda90802131032l6e11eef7gbd7eb57352c2ce4@mail.gmail.com>
	<5ee408090802131049u652ef867wff034b4ccb1067f1@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Feb 13, 2008 11:49 AM, Ricardo Ayres Severo <severo.ricardo@gmail.com> wrote:
> Executing without single step the exception doesn't occurs. But at
> __log_buf I get only trash, even after reseting the processor.
> How can I send some characters to uartlite on asm code?

Great.  This confirms that I am not crazy.  You are having similar
results as I did.  But I still don't yet know why single-step and
memory read can't be used in virtual mode...

To use UARTLite, there are some patches you need.  First thing, you
have to setup your TLBs so that uartlite can be accessed in virtual
mode.  I did something like this:

#define MY_UART_LITE_BASE 0x40000000

 lis r3,MY_UART_LITE_BASE@h
 ori r3,r3,MY_UART_LITE_BASE@l
 mr  r4,r3
 clrrwi  r4,r4,12
 ori r4,r4,(TLB_WR|TLB_I|TLB_M|TLB_G)

 clrrwi  r3,r3,12
 ori r3,r3,(TLB_VALID | TLB_PAGESZ(PAGESZ_16M))

 li  r0,0      /* TLB slot 0 */
 tlbwe r4,r0,TLB_DATA
 tlbwe r3,r0,TLB_TAG

Then, you need to add some C code somewhere.  I chose "setup.c" (in
same directory as head_4xx.S) for this purpose:

// Try to get value for XPAR_RS232_UART_BASEADDR:
#include <platforms/4xx/xparameters/xparameters.h>
#include <platforms/4xx/xparameters/xparameters_ml403.h>

void
serial_putc(unsigned char c)
{
 while (((*(volatile uint32_t*)(XPAR_RS232_UART_BASEADDR + 0x8)) & 0x08) != 0);
 *(volatile uint32_t*)(XPAR_RS232_UART_BASEADDR + 0x4) = c;
}

void
print_A()
{
 serial_putc('A');
}

void
print_B()
{
 serial_putc('B');
}


Now, from assembly, things are easy.  Just do this, I think:

 blr print_A
 blr print_B

If this gives you any trouble, try it first from real mode so that you
can easily debug it.

-David
