Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6vpD51PczDqQ9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 15:09:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Jan Stancek <jstancek@redhat.com>
Cc: christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
 Artem Savkov <asavkov@redhat.com>, Herton Krzesinski <hkrzesin@redhat.com>
Subject: Re: [bug] stack protector panics on v4.10-rc1+
In-Reply-To: <8737g9azuj.fsf@concordia.ellerman.id.au>
References: <627000186.495731.1485210132000.JavaMail.zimbra@redhat.com>
 <1761847918.511957.1485216600665.JavaMail.zimbra@redhat.com>
 <20170124010421.GI30284@gate.crashing.org>
 <8737g9azuj.fsf@concordia.ellerman.id.au>
Date: Tue, 24 Jan 2017 15:09:40 +1100
Message-ID: <87ziih9jzv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Segher Boessenkool <segher@kernel.crashing.org> writes:
>
>> On Mon, Jan 23, 2017 at 07:10:00PM -0500, Jan Stancek wrote:
>>> I'm running into panics with stack protector enabled on ppc64le
>>
>>> I came across following gcc commit:
>>>   https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=0d55f4d0aeaeb16629a2c07c96a190695b83a7e6
>>> which mentions offset above:
>>>   "If TARGET_THREAD_SSP_OFFSET is defined, use -0x7010(13) resp.
>>>    -0x7008(2) instead of reading __stack_chk_guard variable."
>>> 
>>> It looks like it's not reading canary value from __stack_chk_guard variable.
>>> atm. I'm not sure where -28688(r13) falls in ppc kernel (somewhere near paca struct?).
>>> 
>>> Is anyone else seeing these panics?
>>
>> Everyone is.
>
> Are they? I'm not?
>
>> This is fixed in GCC 8 (and will be backported to GCC 7 and GCC 6 and
>> maybe even GCC 5).  See <http://gcc.gnu.org/r244556> (and r244562 and
>> r244677).
>
> # cat /proc/version 
> Linux version 4.10.0-rc5-compiler_gcc-6.3.0-00006-ge357eb97a6be (michael@ka3.ozlabs.ibm.com) (gcc version 6.3.0 (Custom 4b5e15daff8b5444) ) #558 SMP Tue Jan 24 14:29:04 AEDT 2017
>
> # zgrep STACKPROTECTOR /proc/config.gz 
> CONFIG_HAVE_CC_STACKPROTECTOR=y
> CONFIG_CC_STACKPROTECTOR=y
> CONFIG_CC_STACKPROTECTOR_REGULAR=y
>
> I guess I'm just lucky?

No, I'm just using a gcc built without libc as Segher pointed out:

  https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg113181.html

  Right.  Tony's compilers are built using a (modified version of) buildall,
  and buildall goes out of its way to build without libc whatsoever, even
  if the configuration (powerpc64-linux, for example) expects one.
  
  Which leads to TARGET_LIBC_PROVIDES_SSP being undefined (it would normally
  be true for glibc >= 2.4), and that is all.  Mystery solved.  Thanks!


So my inclination is to revert the powerpc stack protector code for
4.10, and we can try again for 4.11 or 12.

cheers
