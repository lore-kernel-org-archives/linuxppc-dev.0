Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 44B9DDDEB8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 03:35:11 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1175662ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 Apr 2007 10:35:10 -0700 (PDT)
Message-ID: <528646bc0704231035g6a1ac904wc6b9b7b77afd1037@mail.gmail.com>
Date: Mon, 23 Apr 2007 11:35:10 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: Mirek23 <miroslaw.dach@psi.ch>
Subject: Re: zImage.elf loads but does not start
In-Reply-To: <10142161.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <10079346.post@talk.nabble.com> <10142161.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/23/07, Mirek23 <miroslaw.dach@psi.ch> wrote:
>
> I have revised the xparameters_ml403.h and the setup of the FPGA part. I have
> found that the interrupt for the RS232 was not configured. Right now I was
> able to come to the point when the kernel was uncompressed but it did not
> start:
>
> Linux/PPC load: console=ttl0,9600 ip=129.129.129.29 root=/dev/ram rw

This doesn't look right.  It should be either 'console=ttyS0,<speed>'
for a full UART, or 'console=ttyUL0' for a uartlite.

BTW, serial console output is polled, not interrupt driven (but
regular serial I/O does use IRQs), so the unconfigured interrupt line
was probably not your immediate problem.

g.
-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
