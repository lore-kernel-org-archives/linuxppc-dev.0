Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AE6C3B7CF5
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 09:19:13 +1100 (EST)
Message-ID: <4BABDD16.4080705@nortel.com>
Date: Thu, 25 Mar 2010 16:00:54 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Csdncannon <csdncannon@gmail.com>
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>	<1269505301.8599.238.camel@pasglop>
	<201003251105.10033.arnd@arndb.de>
	<43c137a81003250800n660195c5k42c8516068aeda8d@mail.gmail.com>
In-Reply-To: <43c137a81003250800n660195c5k42c8516068aeda8d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/25/2010 09:00 AM, Csdncannon wrote:
> I am really sorry that the previously attached code is wrong, this one
> "timebase.c" is the right one, and the "log_timebase" file is the right log.
> 
> We are using FreeScale PowerPc 8378, kernel 2.6.28 and compiled as 32-bit.


volatile unsigned long long getTimeBase()
{
	unsigned long upper,lower,upper2;
	do {
		asm volatile("sync; isync":::"memory");
		asm volatile("mftbu %0" : "=r" (upper));
		asm volatile("sync; isync":::"memory");
		asm volatile("mftbl %0" : "=r" (lower));
		asm volatile("sync; isync":::"memory");
		asm volatile("mftbu %0" : "=r" (upper2));
		asm volatile("sync; isync":::"memory");
	}while(upper2!=upper);

	return (upper<<32)|lower;
}


Shouldn't "upper" be cast to 64-bit before shifting?

Chris
