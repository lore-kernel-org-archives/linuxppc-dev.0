Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2C21EB7CC2
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 20:01:29 +1100 (EST)
Message-ID: <51142.84.105.60.153.1269594081.squirrel@gate.crashing.org>
In-Reply-To: <51131.84.105.60.153.1269593558.squirrel@gate.crashing.org>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<1269505301.8599.238.camel@pasglop> <201003251105.10033.arnd@arndb.de>
	<43c137a81003250800n660195c5k42c8516068aeda8d@mail.gmail.com>
	<1269549524.8599.243.camel@pasglop>
	<43c137a81003251811s52ac72eaud921d187e9747098@mail.gmail.com>
	<50253.84.105.60.153.1269566569.squirrel@gate.crashing.org>
	<43c137a81003251901h229b873bh7593c59a5ef66ae9@mail.gmail.com>
	<51131.84.105.60.153.1269593558.squirrel@gate.crashing.org>
Date: Fri, 26 Mar 2010 10:01:21 +0100 (CET)
Subject: Re: Continual reading from the PowerPc time base register is not   
	stable
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Csdncannon" <csdncannon@gmail.com>,
	"Segher Boessenkool" <segher@kernel.crashing.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, "Arnd Bergmann" <arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Yes indeed.  Could you post the relevant piece if disassembly from
> your original binary (the one that has the problem)?  Or send me the
> binary (not to the mailing list), I'll do it then.

Ah scratch that.  I compiled your original code (after fixing the
compile errors -- there is no such type as "bool" in C).

The problem is that  (upper << 32) | lower  thing.  "upper" is a 32-bit
type, so shifting it by 32 or more bits is undefined.  GCC compiles this
to (shortened):

0: mftbu 9 ; mftbl 11 ; mftbu 0 ; cmpw 0,9 ; bne 0b  # so far so good
   slwi 0,0,0 ; or 4,0,11 ; li 3,0 ; blr

so it shifts by 0, i.e. it does  upper | lower .

Case closed, no hardware problem :-)


Segher
