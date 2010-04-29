Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 3175BB7D4F
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 12:03:19 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.51])
	by hrndva-qmta02.mail.rr.com with ESMTP
	id <20100429015609911.DYBP12161@hrndva-qmta02.mail.rr.com>
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 01:56:09 +0000
Subject: Re: PowerPC ftrace function trace optimisation
From: Steven Rostedt <rostedt@goodmis.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20100429005117.GA4622@kryten>
References: <20100429005117.GA4622@kryten>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Wed, 28 Apr 2010 21:55:03 -0400
Message-ID: <1272506103.9739.112.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, imunsie@au1.ibm.com, paulus@samba.org,
	amodra@gmail.com
Reply-To: rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-04-29 at 10:51 +1000, Anton Blanchard wrote:
> Hi,

> # gcc -pg -mprofile-kernel
> 
> 0000000000000000 <.foo>:
>    0:   7c 08 02 a6     mflr    r0
>    4:   f8 01 00 10     std     r0,16(r1)
>    8:   48 00 00 01     bl      8 <.foo+0x8>	<--- call to mcount
> 
>    c:   7c 08 02 a6     mflr    r0

Why the extra mflr? Can't we just make it a requirement that mcount
returns with r0 back to what it was?

-- Steve

>   10:   f8 01 00 10     std     r0,16(r1)
>   14:   f8 21 ff d1     stdu    r1,-48(r1)
>   18:   e9 22 00 00     ld      r9,0(r2)
>   1c:   e8 69 00 02     lwa     r3,0(r9)
>   20:   38 21 00 30     addi    r1,r1,48
>   24:   e8 01 00 10     ld      r0,16(r1)
>   28:   7c 08 03 a6     mtlr    r0
>   2c:   4e 80 00 20     blr
> 
> 
> This mean we could support ftrace function trace with very little overhead.
> 
> In fact if we are careful when switching to the new mcount ABI and don't
> rely on the store of r0, we could probably optimise this even further in a
> future gcc and remove the store completely. mcount would be 2 instructions:
> 
>    mflr    r0              
>    bl      8 <.foo+0x8>
> 
> Anton
