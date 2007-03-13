Return-Path: <eswierk@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 77594DDEA0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 10:50:08 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so2509750nfc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Mar 2007 16:50:06 -0700 (PDT)
Message-ID: <c1bf1cf0703131122mb959d30v78694fc03bd1d6b@mail.gmail.com>
Date: Tue, 13 Mar 2007 11:22:07 -0700
From: "Ed Swierk" <eswierk@arastra.com>
Sender: eswierk@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Re: Serial console not working on EP8343M
In-Reply-To: <8BE4BF8E-A32E-4984-9B1B-C3B6ED2A1BCA@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
References: <c1bf1cf0703122005l5014824r3e5fbfd50f1974ce@mail.gmail.com>
	<8BE4BF8E-A32E-4984-9B1B-C3B6ED2A1BCA@kernel.crashing.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 3/13/07, Kumar Gala <galak@kernel.crashing.org> wrote:
> Have you tried make the bootargs just console=ttyS0,115200 (or
> whatever your baud rate is)?

I've tried that too. I just stepped through most of the
console_initcall sequence with gdb and it seems like everything is
getting set up properly, including irq and mmio settings for the
serial devices, but still nothing gets printed. Maybe interrupts
aren't getting routed?

I just discovered the udbg-immortal command line option, which
prevents console_init from optimistically disabling the udbg console.
Debugging this problem should be a lot easier now that I can see
console output past console_init.

--Ed
