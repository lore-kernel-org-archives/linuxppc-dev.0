Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 088F9DDFC4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 03:01:55 +1000 (EST)
Message-ID: <46322CE4.1060004@ru.mvista.com>
Date: Fri, 27 Apr 2007 21:03:32 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Charles Krinke <ckrinke@istor.com>
Subject: Re: How do external irq's get mapped?
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1EE@MERCURY.inside.istor.com>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1EE@MERCURY.inside.istor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>, linuxppc-embedded@ozlabs.org
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

Charles Krinke wrote:

> Let me try a more simplified IRQ question a different way by only
> referring to the 8541.

> There are 12 external interrupt sources, irq[0..11] and as I understand
> it, they all go through one vector, ExternalInput set in
> head_fsl_booke.S and this vector resolves to "do_IRQ()", which I believe
> is in arch/powerpc/kernel/irq.c (not arch/ppc/kernel/...).

> I am striving to understand how mapping of these external pins
> irq[0..11] gets to IRQ numbers as shown with "cat /proc/interrupts".

    IIUC, the external IRQ #'s should follow those occupied by 32 internal IRQs.
    But those shown in that file are "virtual" numbers, i.e. they got re-mapped by the kernel as it sees fit (basically, it tries to assign the same # to IRQs above 15 and remaps those below)

> Could someone point me at some references I can read to understand this
> nuance of the 8541 in a linux-2.6.17.11 kernel, please.

   I'm not sure arch/powerpc/ in 2.6.17 had the complete MPC8541 support...

WBR, Sergei
