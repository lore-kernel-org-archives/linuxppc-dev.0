Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kn.nortel.com (zrtps0kn.nortel.com [47.140.192.55])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "zrtps0kn.nortel.com", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4AE17DDF00
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 08:05:54 +1000 (EST)
Message-ID: <46D34A9E.7010501@nortel.com>
Date: Mon, 27 Aug 2007 16:05:18 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: what is ~1MB of memory allocated at fffea000-fffff000 on ppc64?
References: <46D3326C.3000505@nortel.com> <20070827203157.GD13612@kryten>
In-Reply-To: <20070827203157.GD13612@kryten>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Blanchard wrote:
> Hi,
> 
> 
>>I've got a ppc64 box running 2.6.14.  64-bit kernel, 32-bit userspace. 
>>It has a ~86KB chunk of memory near the top of the process address 
>>space, and I'm not sure who's setting it up and what the purpose is.  In 
>>/proc/<pid>/maps it looks like this:
>>
>>fffea000-fffff000 rw-p fffea000 00:00 0
>>
>>Can anyone enlighten me as to what this is for and who is allocating it?
> 
> 
> Looks like your process stack. BTW we leave the top page
> (0xfffff000 - 0xffffffff) unmapped mostly because of test cases that
> expect
> 
> *(unsigned long *)-1UL
> 
> to fail.


Doh.  Of course, that's almost certainly it.

For some background, we're running an emulator that uses a null pointer 
value of 0xffff0000 and we want any accesses to that address to trap.

Do you anticipate any issues with the following change?

-#define TASK_SIZE_USER32 (0x0000000100000000UL - (1*PAGE_SIZE))
+#define TASK_SIZE_USER32 (0x00000000FFFF0000UL - (1*PAGE_SIZE))


Thanks,

Chris
