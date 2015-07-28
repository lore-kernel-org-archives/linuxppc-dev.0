Return-Path: <thuth@redhat.com>
Message-ID: <55B7ED81.3080103@redhat.com>
Date: Tue, 28 Jul 2015 23:00:49 +0200
From: Thomas Huth <thuth@redhat.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
CC: slof@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@ozlabs.ru,
 linuxppc-dev@lists.ozlabs.org, gkurz@linux.vnet.ibm.com
Subject: Re: [SLOF PATCH 1/2] fbuffer: Improve invert-region helper
References: <1438078795-14360-1-git-send-email-thuth@redhat.com>
 <1438078795-14360-2-git-send-email-thuth@redhat.com>
 <20150728170416.GB28839@gate.crashing.org>
In-Reply-To: <20150728170416.GB28839@gate.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


 Hi Segher,

On 28/07/15 19:04, Segher Boessenkool wrote:
> On Tue, Jul 28, 2015 at 12:19:54PM +0200, Thomas Huth wrote:
>>  : invert-region ( addr len -- )
>> -   0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP drop
>> -;
>> -
>> -: invert-region-x ( addr len -- )
>> -   /x / 0 ?DO dup dup rx@ -1 xor swap rx! xa1+ LOOP drop
>> +   2dup or 7 and CASE
>> +      0 OF 3 rshift 0 ?DO dup dup rx@ -1 xor swap rx! xa1+ LOOP ENDOF
>> +      2 OF 1 rshift 0 ?DO dup dup rw@ -1 xor swap rw! wa1+ LOOP ENDOF
>> +      4 OF 2 rshift 0 ?DO dup dup rl@ -1 xor swap rl! la1+ LOOP ENDOF
>> +      6 OF 1 rshift 0 ?DO dup dup rw@ -1 xor swap rw! wa1+ LOOP ENDOF
>> +      dup OF 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP ENDOF
>> +   ENDCASE
>> +   drop
>>  ;
> 
> Can you access device memory as 64 bits for all supported devices?

Yes, should be fine since 64 bit access was already used in the original
code, see fb8-invert-screen in 
https://github.com/aik/SLOF/commit/99c534ecc7a8566bd9ca6346915d9ac1bfacae1e

> You can get a bigger speedup by writing some of the core blitting
> functions in C, btw.

Well, the above code is for js2x only ... so this is likely not worth
the effort anymore. The code for qemu-spapr calls into a hypercall
already, so this is already accelerated.

> A small simplification:
> 
>    2dup or 7 and CASE
>       0 OF 3 rshift 0 ?DO dup dup rx@ -1 xor swap rx! xa1+ LOOP ENDOF
>       4 OF 2 rshift 0 ?DO dup dup rl@ -1 xor swap rl! la1+ LOOP ENDOF
>       3 and
>       2 OF 1 rshift 0 ?DO dup dup rw@ -1 xor swap rw! wa1+ LOOP ENDOF
>       dup OF 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP ENDOF
>    ENDCASE

Ok, nice idea, makes sense! I'll include it in v2 (after waiting a little
bit to see if there's other feedback)
 
> If this code is often called unaligned, it makes more sense to special-
> case the begin and end probably.

It's only used for drawing the cursor, so it always should be aligned.

 Thomas
