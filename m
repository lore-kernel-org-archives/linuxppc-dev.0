Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvZ6c56d2zDqTj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 21:14:00 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Balbir Singh <bsingharora@gmail.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com,
 kexec@lists.infradead.org, dyoung@redhat.com, Petr Tesarik <ptesarik@suse.cz>,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Wed, 20 Jul 2016 13:12:20 +0200
Message-ID: <34243612.Gid3QHG1hd@wuerfel>
References: <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160720083530.GK1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, July 20, 2016 8:47:45 PM CEST Michael Ellerman wrote:
> At least for stdout-path, I can't really see how that would significantly help
> an attacker, but I'm all ears if anyone has ideas.

That's actually an easy one that came up before: If an attacker controls
a tty device (e.g. network console) that can be used to enter a debugger
(kdb, kgdb, xmon, ...), enabling that to be the console device
gives you a direct attack vector. The same thing will happen if you
have a piece of software that intentially gives extra rights to the
owner of the console device by treating it as "physical presence".

	Arnd
