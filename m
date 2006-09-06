Return-Path: <jonscully@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.193])
	by ozlabs.org (Postfix) with ESMTP id 54E0367BD2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Sep 2006 10:06:56 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so910233nzh
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 05 Sep 2006 17:06:55 -0700 (PDT)
Message-ID: <53107f6e0609051706i67eac762y114ad03bf2065548@mail.gmail.com>
Date: Tue, 5 Sep 2006 17:06:55 -0700
From: "Jon Scully" <jonscully@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8245 reset register
In-Reply-To: <198592450609051149h47423ebev9c94eb8aefc2a3fb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <198592450609021546x57c71e48r9aed561b61f6e8aa@mail.gmail.com>
	<53107f6e0609021647l1f1cd84du496e3cd7219b603@mail.gmail.com>
	<198592450609051149h47423ebev9c94eb8aefc2a3fb@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/5/06, Reeve Yang <yang.reeve@gmail.com> wrote:
>  I'm kind of curious what's the proper way to reset the
> 8245 CPU? For anyone who doesn't know MPC8245, which is 603e core.

You could starve the watchdog (assuming SWE=1 in SYPCR).  If you own
the hardware design, you could add an addressable WO latch (FPGA) that
asserts reset for the right number of clock cycles (what I would
normally provide or ask for in a design -- but *only* during
development).  Otherwise... If this is for development purposes,
consider using JTAG (Boundary Scan) to control /SRESET.

(My reference to RST was supposed to be humorous -- as in, remember
the good old days when you could do that in S/W?! ('RST 7' in Z80 &
8085)  Sorry for my bad humor.)
