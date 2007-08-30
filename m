Return-Path: <pete@bluelane.com>
Received: from mse2fe1.mse2.exchange.ms (outbound.mse2.exchange.ms
	[69.25.50.247]) by ozlabs.org (Postfix) with ESMTP id 66B5ADDE39
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 11:19:36 +1000 (EST)
Message-ID: <46D61B21.1010703@bluelane.com>
Date: Wed, 29 Aug 2007 18:19:29 -0700
From: Pete/Piet Delaney <pete@bluelane.com>
MIME-Version: 1.0
To: pete@bluelane.com
Subject: Re: [Kgdb-bugreport] 2.6.23-rc3-mm1: kgdb build failure on powerpc
References: <20070822020648.5ea3a612.akpm@linux-foundation.org>	<200708222104.29432.m.kozlowski@tuxland.pl>	<20070822124743.fc316963.akpm@linux-foundation.org>	<46CCBC3C.7010307@windriver.com>
	<20070822165318.b82da13c.akpm@linux-foundation.org>
	<46CCFE2C.4050306@windriver.com> <46D604BF.7090905@bluelane.com>
In-Reply-To: <46D604BF.7090905@bluelane.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kgdb-bugreport@lists.sourceforge.net, amitkale@linsyssoft.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Paul Mackerras <paulus@samba.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: pete@bluelane.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pete/Piet Delaney wrote:
> Jason Wessel wrote:
>> Andrew Morton wrote:
>>> On Wed, 22 Aug 2007 17:44:12 -0500
>>> Jason Wessel <jason.wessel@windriver.com> wrote:
>>>
>>>  
>>>> +    while (!atomic_read(&debugger_active));
>>>>     
>>> eek.  We're in the process of hunting down and eliminating exactly this
>>> construct.  There have been cases where the compiler cached the
>>> atomic_read() result in a register, turning the above into an infinite
>>> loop.
>>>
>>> Plus we should never add power-burners like that into the kernel
>>> anyway. That loop should have a cpu_relax() in it.  Which will also
>>> fix the
>>> compiler problem described above.
>>>
>>>   
>> Agreed, and fixed with a cpu_relax.
> 
>>> Thirdly, please always add a newline when coding statements like that:
>>>
>>>     while (expr())
>>>         ;
>>>   
>> The other instances I found of the same problem in the kgdb core are
>> fixed too.
> 
>> I merged all the changes into the for_mm branch in the kgdb git tree.
> 
> Where is the kgdb git tree?

Why am I getting this when I do:

git clone
http://master.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb.git

-
----------------------------------------------------------------------------
error: Couldn't get
http://master.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb.git/refs/tags/v2.6.11
for tags/v2.6.11
The requested URL returned error: 404
error: Could not interpret tags/v2.6.11 as something to pull
rm: cannot remove directory
`/nethome/piet/Src/linux/git/jwessel/linux-2.6-kgdb/.git/clone-tmp':
Directory not empty
/nethome/piet/Src/linux/git/jwessel$
-
----------------------------------------------------------------------------

We are getting a problem with VMware where kernel text is the schedler
is getting wacked with four null bytes into the code. Thought I'd use
the current linux-2.6-kgdb.git tree and possible the CONFIG_DEBUG_RODATA
patch to make kernel text readonly:

 https://www.x86-64.org/pipermail/patches/2007-March/003666.html

I thought the kernel text was RO and gdb had to disable it to
insert a breakpoint.

- -piet

> 
> -piet
> 
>> Thanks,
>> Jason.
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
- -
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG1hshJICwm/rv3hoRAhTGAJ46pq69zYHqRmT+yTmRx+RVh8aBtgCfdyFM
gl91xCFTy0NJxHalVXpd9Os=
=c8FZ
-----END PGP SIGNATURE-----
