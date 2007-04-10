Return-Path: <sshtylyov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 7C59BDDEFC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 00:18:50 +1000 (EST)
Message-ID: <461B9D04.2000109@ru.mvista.com>
Date: Tue, 10 Apr 2007 18:19:48 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Michael <michaelzwrk@gmail.com>
Subject: Re: IDE driver in polling mode
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
In-Reply-To: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

Michael wrote:

> I'd like to know whether it is possible to use IDE driver (ide-disk)
> in polling mode, instead of using IRQ.

    I generally wouldn't recommend using this mode since the ATA polling 
protocol had been racy for years, WRT to the interrupt pending condition.

> In case you wonder - the reason why I need this weired thing is that I
> have a compact flash connected directly to the host local bus using
> memory mode. It is more-or-less IDE-compatible, except that it doesn't
> issue interrupts.

    Ah, no interrupts at all...
    The old IDE core in drivers/ide/ certainly doesn't support polling mode 
and IRQ-less devices. AFAICS, libata also doesn't support the latter...

MBR, Sergei
