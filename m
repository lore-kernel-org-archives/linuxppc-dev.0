Return-Path: <eswierk@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id 90D7BDDE17
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 11:28:03 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so2521937nfc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Mar 2007 17:28:02 -0700 (PDT)
Message-ID: <c1bf1cf0703131202y3039420csb5862fcedebd3241@mail.gmail.com>
Date: Tue, 13 Mar 2007 12:02:20 -0700
From: "Ed Swierk" <eswierk@arastra.com>
Sender: eswierk@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Re: Serial console not working on EP8343M
In-Reply-To: <c1bf1cf0703131122mb959d30v78694fc03bd1d6b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
References: <c1bf1cf0703122005l5014824r3e5fbfd50f1974ce@mail.gmail.com>
	<8BE4BF8E-A32E-4984-9B1B-C3B6ED2A1BCA@kernel.crashing.org>
	<c1bf1cf0703131122mb959d30v78694fc03bd1d6b@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

OK, problem solved. Once I kicked out that nasty IPMI driver,
everything works, including the serial console without udbg-immortal.

Lessons learned:

- passing "udbg-immortal loglevel=9 initcall_debug" to the kernel will
give you much more visibility into early init problems (at least on
powerpc arch circa 2.6.20)

- building U-Boot 1.2.0 with DEBUG defined in ft_build.c helps in
troubleshooting flat device tree problems

- the Abatron BDI2000 is an incredibly useful tool: source-level
debugging of U-Boot and the Linux kernel, starting at instruction zero
*swoon*

--Ed
