Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 31BA9B7CF0
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 08:37:14 +1100 (EST)
Message-ID: <50040.84.105.60.153.1269553028.squirrel@gate.crashing.org>
In-Reply-To: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
Date: Thu, 25 Mar 2010 22:37:08 +0100 (CET)
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Csdncannon" <csdncannon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>          In my program, the value of the 64-bit time base register is read
> out, and you will find the later value is even smaller than the earlier
> value from the log “log_timebase”.

>          Do you have any idea about this problem, thanks for your any
> advice. Attached is the code and log.

Your code has a problem, you do (upper << 32) | lower, it should
be ((unsigned long long)upper << 32) | lower .

That is not the problem though: in your TBL, the bit with value
0x40 is stuck to 1.  Broken hardware?


Segher
