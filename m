Return-Path: <mlcreech@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 0B426DDEDF
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 07:36:26 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so1625966ywe.39
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 13:36:24 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 31 Mar 2009 16:30:26 -0400
Message-ID: <5ee96a840903311330y36ed97bet92319da8d118086@mail.gmail.com>
Subject: MPC83xx console : no output after handover
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Sorry if this is a dupe, but I think my first attempt was filtered out)

Hi,

I'm trying to get Linux booting on a custom board based on the MPC8313
ERDB, but there's no output after the console is transferred.  I get
the following:

Using MPC831x RDB machine description
Linux version 2.6.29 (mlcreech@lap) (gcc version 4.3.2 (Sourcery G++ Lite 4.3-50
) ) #2 PREEMPT Tue Mar 31 14:54:27 EDT 2009
console [udbg0] enabled

... (normal boot output) ...

Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 16) is a 16550A
console handover: boot [udbg0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 17) is a 16550A

If I boot with "console=udbg0,115200", then it gets much further along
before printing "turn off boot console udbg0".  So presumably the
kernel is booting beyond this point, but my console isn't printing any
output.  I traced from that last line back up the call stack to the
end of drivers/serial/8250.c:serial8250_init(), and everything seems
okay (it returns 0, and pritnk() still works fine at that point).  I'm
not sure where to go from there to figure out where the problem lies.
Could someone point me in the right direction, or suggest what might
cause a console problem like this?

Thanks!

-- 
Matthew L. Creech
