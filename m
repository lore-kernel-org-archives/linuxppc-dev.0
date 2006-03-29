Return-Path: <gsmith@nc.rr.com>
Received: from ms-smtp-04-eri0.southeast.rr.com
	(ms-smtp-04-lbl.southeast.rr.com [24.25.9.103])
	by ozlabs.org (Postfix) with ESMTP id 578D6679E6
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 05:20:36 +1100 (EST)
Subject: Re: [OT] ppc64 serialization problem
From: Greg Smith <gsmith@nc.rr.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17450.2061.510951.479016@cargo.ozlabs.ibm.com>
References: <1143597506.3075.53.camel@localhost.localdomain>
	<17450.2061.510951.479016@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 13:20:33 -0500
Message-Id: <1143656433.3075.108.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-03-29 at 15:07 +1100, Paul Mackerras wrote:
> Greg Smith writes:
> 
> > On rare occasions, values A and B will differ!  In the examples that I
> > have seen, there is contention with `lock'.  This phenomenon does not
> > occur on ppc32 or a number of other architectures that we support.
> 
> I would be interested to see the assembler code being generated for
> your code snippets.
> 
> Paul.

This is looking like a compiler optimization issue.  We have two fields

_u32 x,y;

Field y is what we are trying to serialize with the lock.  However,
while we are doing that it appears another thread is updating x.  When x
is updated and with optimization, the code is doing an 8 byte load of x
and y then doing an 8 byte store, wiping out what was stored in y.
Which explains why changing the type to _u64 seemed to fix the problem.

Below are some of the notes the other developer sent me.

Thanks,
Greg Smith




There are OTHER field neighbouring the ints_state field.. (and this is 
probably some of the flags)..

gcc, when optimizing, gcc load and stores 64 bit values, *INCLUDING* the
ints_state field effectivelly breaking serialization.

Here is a sample program :

struct _test1
{
         unsigned long long z;
         unsigned char c;
         unsigned int a:1;
         const volatile unsigned int b;
};

int main()
{
}

unsigned int toto(struct _test1 *data)
{
         data->a=1;
         return data->b;
}

And here is the relevant asm snippet :

.A
         ld 11,8(9) - get 64 bits ->a
         lis 0,0x80 *
         sldi 0,0,32 *
         or 0,11,0 *
.B
         std 0,8(9) * Store 64 bits -> a
         ld 9,112(31) *
         lwz 0,12(9) * get 32 bit b

So it is clear between .A and .B -> value of b was read then written. If
anything happens between .A and .B to ->b, then it is lost.
