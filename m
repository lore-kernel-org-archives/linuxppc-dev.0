Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80B1DDDE04
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 10:12:58 +1100 (EST)
In-Reply-To: <1203719063.6976.22.camel@pasglop>
References: <410c322e7d7e4b9a420a7209f12dfbd105583f6f.1203708822.git.segher@kernel.crashing.org>
	<1203719063.6976.22.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ce84ca8750a56cac6f6a594f09bdfdf8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Get rid of invalid shifts in math-emu
Date: Sat, 23 Feb 2008 00:13:09 +0100
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> _However_ there are significant code changes in there, and I don't
> actually understand that code (well, I admit I haven't tried),

Yeah, it's written in 70's style C.  Yuck.

> so it could definitely use a bit of a commit message explaining
> the rationale

Right.  I had to fix git-send-email and then I forgot to type up
some more comments.

> (you are removing a lot of stuff),

Not actually, more below.

> and maybe somebody
> can run a few tests to make sure things work fine ?

That would be nice.  I don't know any comprehensive IEEE FP test suite
to use on this, nor do I have a platform that normally uses this code
(though I bet I could force a 750 to use it, some way).

I'll resend with some coherent checkin comment after someone has tested
this :-)


This patch is a prime example why diff -c is so much more readable
than diff -u.  But let's not digress, let's look at the code!

So the code used to look like:


#define _FP_FRAC_SLL_2(X,N)                                             
\
   do {                                                                  
\
     if ((N) < _FP_W_TYPE_SIZE)                                          
\
       {                                                                 
\
         if (__builtin_constant_p(N) && (N) == 1)                        
\
           {                                                             
\
             X##_f1 = X##_f1 + X##_f1 + (((_FP_WS_TYPE)(X##_f0)) < 0);   
\
             X##_f0 += X##_f0;                                           
\
           }                                                             
\
         else                                                            
\
           {                                                             
\
             X##_f1 = X##_f1 << (N) | X##_f0 >> (_FP_W_TYPE_SIZE - (N)); 
\
             X##_f0 <<= (N);                                             
\
           }                                                             
\
       }                                                                 
\
     else                                                                
\
       {                                                                 
\
         X##_f1 = X##_f0 << ((N) - _FP_W_TYPE_SIZE);                     
\
         X##_f0 = 0;                                                     
\
       }                                                                 
\
   } while (0)


and after my change it is:


#define _FP_FRAC_SLL_2(X,N)                                             
\
   do {                                                                  
\
     int n = (N);                                                        
\
     if (n >= _FP_W_TYPE_SIZE)                                           
\
       {                                                                 
\
         X##_f1 = X##_f0;                                                
\
         X##_f0 = 0;                                                     
\
         n -= _FP_W_TYPE_SIZE;                                           
\
       }                                                                 
\
     X##_f1 = X##_f1 << n | X##_f0 >> (_FP_W_TYPE_SIZE - n - 1) >> 1;    
\
     X##_f0 <<= n;                                                       
\
   } while (0)


The __builtin_constant_p(N) && (N == 1) special casing in the original
is just noise, it won't result in more efficient code.  When N is a
compile-time constant (remember, this "function" is a preprocessor 
macro),
one of the two branches of the "if" in the original evokes undefined
behaviour (shift by a negative number, resp. shift by a number >= 32).
I rewrote this to "shift" by a whole word first if necessary, and then
by whatever is left.


With recent GCC, all this nonsense doesn't help a bit: f could just have
been a u64, with no worse code generated.  OTOH, I don't really feel
like rewriting all of this.  I might have to though, if I want to get 
rid
of all the "might be used uninitialised" warnings and errors as well :-(


Segher
