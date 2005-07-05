Return-Path: <appro@fy.chalmers.se>
Received: from anubis.medic.chalmers.se (anubis.medic.chalmers.se
	[129.16.30.218]) by ozlabs.org (Postfix) with ESMTP id AE2E467C7A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 01:01:11 +1000 (EST)
Message-ID: <42CAA0AB.4040501@fy.chalmers.se>
Date: Tue, 05 Jul 2005 17:00:59 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
MIME-Version: 1.0
To: openssl-dev@openssl.org
References: <4dd15d1805063003587276af7e@mail.gmail.com>	
	<4dd15d1805063015226379a52c@mail.gmail.com>	
	<42C57F30.902@fy.chalmers.se>
	<4dd15d1805070407352bd5120e@mail.gmail.com>
In-Reply-To: <4dd15d1805070407352bd5120e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC bn_div_words routine rewrite
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Let's start the week off with less hostility and more productive
> criticism on this topic.

If you want productivity, then provide real evidence in form of stack 
backtrace at segmentation violation point, disassemble output in the 
vicinity of segmentation violation point and 'info registers' output at 
the same point. As for hostility I leave it without comment, as you're 
apparently can outrank anybody in that area:-)

>>But you're apparently right about a bug being present in PPC assembler.
> 
> 
> So you are saying there is a bug in the GCC assembler? How confident
> are you in that?  Is the first correct step to examine the assembly
> code for errors before jumping to any conclusion that the GCC
> assembler is bad?

Did I say GCC assembler? I said PPC assembler, which refers to 
crypto/bn/asm/ppc.pl.

>>>>This is a rewrite of the bn_div_words routine for the PowerPC arch,
>>>>tested on a MPC8xx processor.
>>
>>Well, suggested routine apparently sends ssh-keygen on the PPC-based
>>32-bit system I have access to to an end-less loop... 
> 
> 
> If you care to read the c function I supplied or if you don't believe
> it:  If you understand ppc 32-bit instructions, as specified in the
> PowerPC Microprocessor Family: Programming Environments for 32-Bit
> Microprocessors.  My routine would not be able to find a condition
> that will make it go into an end-less loop,unless you messed up bad
> somewhere.

I didn't say that suggested routine goes into an end-less loop, but that 
it "*apparently* sends ssh-keygen into end-less loop." I made no claims 
about which routine exactly loops, and I even admit that I don't know 
for sure if it was in fact end-less loop, because I've chosen to kill 
the process after couple of minutes. Note that normally it takes just 
few seconds on the machine I've tested on, so that couple of minutes is 
essentially unacceptable and by all means *appears* as end-less loop.

> In summary, what I am trying to provide the community is an
> alternative to ... the current implementation of which is
> very questionable.

crypto/bn/asm/ppc.pl distributed with OpenSSL was designed for and 
explicitly tested by IBM under 32- and 64-bit PPC Linux, 32- and 64-bit 
AIX, as well as 32-bit MacOS X. Special care was taken to make sure that 
neither of ABIs/calling conventions used by above listed platforms are 
violated, so that module can be safely invoked by compiler-generated 
code for above mentioned OSes. Afterwards there were reports that it was 
successfully used on unspecified [in report] embedded PPC-based 
platform. Despite this on Friday I could personally confirm on 32-bit 
MacOS X that there admittedly was a bug in ppc.pl, which manifests as 
failure to generate sane decimal ASCII presentation of a BIGNUM, which 
is exactly the kind of operation taking place when you run ssh-keygen -t 
rsa1 [it should be noted decimal ASCII is unfortunately not covered by 
'make test_bn' suite]. But under no circumstances segmentation violation 
was observed. At the same time I could personally confirm that if pasted 
into osx32_ppc.s, suggested implementation induces 'make test_bn' 
failure on 32-bit MacOS X. In particular test/bntest terminates with

print "test BN_sqr\n"
-FF554CAEAE * -FF554CAEAE - FEAB0B30019BBA80FE44
Square test failed!
1

while test/exptest:

BN_mod_exp_recp() problems
14482:error:03082065:bignum routines:BN_div_recp:bad 
reciprocal:bn_recp.c:194:

For me it's enough reasons to become sceptical to submission and conduct 
trouble-shooting of my own. Currently available ppc.pl was verified to 
pass 'make test_bn' on 32-bit MacOS X, 32- and 64-bit AIX [tested by 
IBM], as well as to generate correct decimal ASCII presentation on the 
mentioned platforms. If it doesn't work for you, then submit information 
listed in the beginning of the letter. A.
