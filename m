Return-Path: <dhbaird@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id 2513FDDEF1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 08:47:40 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 25so969463wfa.15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 13:47:40 -0800 (PST)
Message-ID: <440abda90802201347w3945c53dhf47ffd0380aa01aa@mail.gmail.com>
Date: Wed, 20 Feb 2008 14:47:39 -0700
From: "David Baird" <dhbaird@gmail.com>
To: linuxppc-embedded@ozlabs.org, "Robert Woodworth" <rwoodworth@securics.com>,
	"Ricardo Ayres Severo" <severo.ricardo@gmail.com>
Subject: Re: TLB Miss booting linux kernel on ppc 405
In-Reply-To: <5ee408090802201329hdb78359m3a60e987a799f06b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5ee408090802130850w130ce09an507ca5c4d41cc5a8@mail.gmail.com>
	<440abda90802130917x79c3c990j6a1fc7c12ba05ed7@mail.gmail.com>
	<5ee408090802130938u7d069636g42a496e489fe5b80@mail.gmail.com>
	<440abda90802130951h7a23743asc85454bf089c7e55@mail.gmail.com>
	<5ee408090802131003m4b8e632cu931769bc77f9b439@mail.gmail.com>
	<440abda90802131032l6e11eef7gbd7eb57352c2ce4@mail.gmail.com>
	<5ee408090802131049u652ef867wff034b4ccb1067f1@mail.gmail.com>
	<440abda90802131102q234e870fx2cbf12fb3119fd0a@mail.gmail.com>
	<1203542646.4812.38.camel@PisteOff>
	<5ee408090802201329hdb78359m3a60e987a799f06b@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ricardo,

On Feb 20, 2008 2:29 PM, Ricardo Ayres Severo <severo.ricardo@gmail.com> wrote:
> I didn't solve the problem yet. I'm having problems with the memset_io
> in early_init and am studying if the SDRAM is initializing right.
> Any progress I'll send to the list.

It sounds suspiciously like you might be having this problem:

    http://www.nabble.com/Problem-booting-Linux-2.6-on-Virtex-4-td14795525.html
    "Things start to go obviously wrong after early_init calls memset to
    clear the .bss section."

I don't know what the cause of the problem was, but the symptom is
that different memory regions were aliased onto each other (it was
like an address bit wasn't working or something funny was happening
with the cache ... but only in virtual mode).  The problem was fixed
after rebuilding the design in EDK 9.2i.  I don't know what caused the
problem originally though.

Let us know if you get this resolved or have more questions...  I
might not be able answer, but hopefully someone can help.

-David
