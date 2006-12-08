Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 1D14767B6D
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Dec 2006 07:15:54 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Is in_le32 and out_le32 atomic?
Date: Fri, 8 Dec 2006 21:15:38 +0100
References: <4579C586.5040809@grandegger.com>
In-Reply-To: <4579C586.5040809@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612082115.38812.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 08 December 2006 21:05, Wolfgang Grandegger wrote:
> Can anybody tell me why the spin_* protection is needed? I thought that 
> 32-bit read and write operations are atomic.
> 
The spinlocks are needed to guarantee ordering between the completion of
the i/o access and other code. A typical problem is that a store is
still on its way to the I/O device while the CPU has already left the
function that initiated it, and might call code that relies on the
value having arrived there.

	Arnd <><
