Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 772A5DDF17
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 17:45:05 +1000 (EST)
In-Reply-To: <18079.63067.248965.356540@cargo.ozlabs.ibm.com>
References: <11847726193856-git-send-email-segher@kernel.crashing.org>
	<5d56173bee3f9ea0050aa508e7f27cc932af7229.1184104284.git.segher@kernel.crashing.org>
	<18078.43412.493174.590540@cargo.ozlabs.ibm.com>
	<FB9F7C22-8598-4E72-B663-130A7989925D@kernel.crashing.org>
	<18079.63067.248965.356540@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2958BF69-6F26-4CBB-BB71-EC13AAC7E293@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Treat ISI faults as read faults on classic 32-bit PowerPC
Date: Fri, 20 Jul 2007 09:42:11 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Should you really be testing VM_READ|VM_WRITE, or should it just
>> be VM_READ?
>
> We test VM_READ | VM_WRITE | VM_EXEC in the read case below, and that
> is because we have no HPTE encoding to say "writable but not readable"
> or "executable but not readable".  Similarly we have no encoding to
> say "writable but not executable" on classic processors, so if you
> have just VM_WRITE set, you get a page that is readable, writable and
> executable.

Ah yes.  I thought "executable requires readable", but
that is with the CPU its flags, not the Linux flags.

Would it be a good idea to map Linux flags to CPU flags
somewhere early in this function?  It might simplify some
code, and things certainly would become more readable.


Segher
