Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 384A0DDF0C
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2009 03:23:10 +1000 (EST)
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com
	[47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id
	n3OHMxg07215
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 17:22:59 GMT
Message-ID: <49F1F56C.8000708@nortel.com>
Date: Fri, 24 Apr 2009 11:22:52 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: help with inline assembly code?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I've got a function that is used to overwrite opcodes in order to create 
self-modifying code.  It worked just fine with previous compilers, but 
with gcc 4.3 it seems like it sometimes (but not always) causes problems 
when inlined.  If I force it to never be inlined, it works fine.

First, here's the code:

void alter_opcode(unsigned long *addr, unsigned long opcode)
{
	asm volatile(
                 "stw    %1,0(%0)	\n\t"
                 "dcbf   0,%0		\n\t"
                 "sync			\n\t"
                 "icbi   0,%0,		\n\t"
                 "isync			\n\t"
                     :: "r" (addr), "r" (opcode): "memory");
}

The symptom of the problem is a segfault on the "stw" instruction.  I've 
verified that the address it's trying to write to is the expected 
address, and that the opcode being written is the expected opcode.

I assume I've mixed up the registers or constraints or 
something...anyone want to take a crack at it?

Chris
