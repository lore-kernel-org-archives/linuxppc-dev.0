Return-Path: <martijn.de.gouw@prodrive.nl>
Received: from mail.prodrive.nl (mail.prodrive.nl [212.61.153.67])
 by ozlabs.org (Postfix) with ESMTP id CD9E72C00FE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2012 23:16:22 +1100 (EST)
Message-ID: <5093B318.9040305@prodrive.nl>
Date: Fri, 2 Nov 2012 12:48:40 +0100
From: Martijn de Gouw <martijn.de.gouw@prodrive.nl>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: powerpc: Don't silently handle machine checks from userspace
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Micha Nelissen <micha.nelissen@prodrive.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The following commit:

http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=commit;h=e49b1fae0ba4d06b29bd753a961abb447566bf4a

causes confusion, because it prints "Machine check in kernel mode" also when the bus error is actually in user space. When using RapidIO memory mapped access, and the device is removed or powered off, then a bus error is generated. This is on a freescale mpc8548 powerpc. Due to removing the user_mode check, the kernel calls "die" which causes the process to die with a BUS error, regardless of having a SIGBUS handler or not.

Therefore I request to put this check back, and even to put the removed code at the top of the machine check handler because there is no point in trying to recover from a user space bus error anyway.

Best regards,

-- 
Martijn de Gouw
Engineer
Prodrive B.V.
Mobile: +31 63 17 76 161
Phone:  +31 40 26 76 200
