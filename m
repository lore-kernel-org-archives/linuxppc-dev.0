Return-Path: <felix@allot.com>
Received: from exg.allot.com (mail.allot.com [199.203.223.202])
	by ozlabs.org (Postfix) with ESMTP id A89AA2BF07
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Nov 2004 04:42:28 +1100 (EST)
Message-ID: <4190FDED.3080605@allot.com>
Date: Tue, 09 Nov 2004 19:27:09 +0200
From: Felix Radensky <felix@allot.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: 405GPr ioremap problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, folks

I have a 405GPr based board with 512M of RAM.
My kernel is 2.4.17 from Monta Vista Linux 2.1.
I'm  trying to reserve 64M on boot using mem=448M
and map it later by

ioremap(__pa(high_memory), 64*(1<<20));

This worked fine when system had 256M of RAM,
but now ioremap fails. If I understand the kernel
code correctly, by adding more RAM I've reduced
the vmalloc/ioremap space. I can also see that this
space is reduced dramatically on boot by mappings
done in arch/ppc/kernel/ppc4xx_setup.c:m4xx_map_io()

Is there any way to fix problem ? Is it necessary to have
a 1:1 virtual to physical mappings as its done in m4xx_map_io()
or maybe higher virtual addresses can be used, thus
allowing to save some precious ioremap space.

Thanks a lot in advance.

Please CC me, as I'm not on the list.

Felix.
