Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id DEAD2DDEF1
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 20:04:27 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 91D4429EC9
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 11:30:34 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 30804-05 for <linuxppc-dev@ozlabs.org>;
	Mon, 25 Aug 2008 11:29:47 +0200 (CEST)
Received: from archvile.prtnl (archvile.prtnl [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id C0FEE29EC4
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 11:29:46 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-dev@ozlabs.org
Subject: Efficient memcpy()/memmove() for G2/G3 cores...
Date: Mon, 25 Aug 2008 11:31:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808251131.02071.david.jander@protonic.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hello,

I was wondering if there is a good replacement for GLibc memcpy() functions, 
that doesn't have horrendous performance on embedded PowerPC processors (such 
as Glibc has).

I did some simple benchmarks with this implementation on our custom MPC5121 
based board (Freescale e300 core, something like a PPC603e, G2, without VMX):

...
unsigned long int a,b,c,d;
unsigned long int a1,b1,c1,d1;
...
while (len >= 32)
{
    a =  plSrc[0];
    b =  plSrc[1];
    c =  plSrc[2];
    d =  plSrc[3];
    a1 = plSrc[4];
    b1 = plSrc[5];
    c1 = plSrc[6];
    d1 = plSrc[7];
    plSrc += 8;
    plDst[0] = a;
    plDst[1] = b;
    plDst[2] = c;
    plDst[3] = d;
    plDst[4] = a1;
    plDst[5] = b1;
    plDst[6] = c1;
    plDst[7] = d1;
    plDst += 8;
    len -= 32;
}
...

And the results are more than telling.... by linking this with LD_PRELOAD, 
some programs get an enourmous performance boost.
For example a small test program that copies frames into video memory (just 
RAM) improved throughput from 13.2 MiB/s to 69.5 MiB/s.
I have googled for this issue, but most optimized versions of memcpy() and 
friends seem to focus on AltiVec/VMX, which this processor does not have.
Now I am certain that most of the G2/G3 users on this list _must_ have a 
better solution for this. Any suggestions?

Btw, the tests are done on Ubuntu/PowerPC 7.10, don't know if that matters 
though...

Best regards,

-- 
David Jander
