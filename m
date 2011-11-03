Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 824DEB6F18
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 09:08:12 +1100 (EST)
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AEA4@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AEA4@saturn3.aculab.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <56B53DA2-CB5E-4EB9-A5B3-470B7B0CD0FD@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/usb: use unsigned long to type cast an address of
 ioremap
Date: Thu, 3 Nov 2011 23:08:18 +0100
To: David Laight <David.Laight@ACULAB.COM>
Cc: linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Tabi Timur-B04825 <B04825@freescale.com>,
 Xie Shaohui-B21989 <B21989@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Arithmetic on 'void *' should not be done. I know some versions of
> gcc allow it (provided some warning level/option is enabled) but
> that doesn't mean it is valid.

All relevant GCC versions support it (going back to 2.x at least).
It is _always_ allowed, whatever compiler options you use; -pedantic
or -Wpointer-arith will warn (which you can upgrade to an error).

The Linux kernel is not built with these warnings enabled.

>> A char* is incorrect because a char could be more
>> than one byte, in theory.
>
> It is somewhat difficult to untangle the standard, but
> sizeof (char) is defined to be one.

A char takes exactly one byte.  A byte could be more than eight bits,
of course.

In GCC, sizeof(void) is 1 as well.

> Of course, the C language doesn't actually require that
> you can converts between pointers to different types in
> any well-defined manner.

It does actually, see 6.3.2.3/7.  You can convert any pointer to object
to a pointer to a different object type, as long as it is properly  
aligned.
You cannot in general access the object as that new type of course, but
it is perfectly well-defined; in particular, you can convert it back to
the original type and get the same value again, and you can walk  
consecutive
bytes of the object by using a pointer to character type.


Segher
