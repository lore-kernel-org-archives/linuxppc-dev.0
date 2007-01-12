Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1BC9EDDDFC
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 23:03:21 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E816A18@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816A18@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <009dcf6d65c2d14067471cb2df09fae2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with
	IEEE-754standard
Date: Fri, 12 Jan 2007 13:03:53 +0100
To: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> When floating-point underflow exceptions are disabled
> (SPEFSCR[FUNFE] is cleared) and the result of a floating-point 
> operation
> underflows, a signed zero result is produced.

You probably want to make at least this one tweakable
per-process; on some important algorithms (some FFTs
etc.) the results are perfectly acceptable with underflow-
to-zero and the performance difference is huge.  AltiVec
can do this per-process too, for example -- it has a
user register for setting this, you need some other
interface though.


Segher
