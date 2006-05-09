Return-Path: <geoffrey.levand@am.sony.com>
Message-ID: <445FDF62.2030008@am.sony.com>
Date: Mon, 08 May 2006 17:16:34 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch] powerpc: remove do-nothing cpu setup routines
References: <BE9739CD-B66A-43A4-B5E9-2DE49CEDE5B7@kernel.crashing.org>
In-Reply-To: <BE9739CD-B66A-43A4-B5E9-2DE49CEDE5B7@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: "Levand, Geoffrey" <Geoffrey.Levand@am.sony.com>,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>> Removes the processor specific do-nothing routines  
>>> __setup_cpu_power3 and
>>> __setup_cpu_power4 with the generic routine __setup_cpu_null.
>>
>> Why not just change the caller to test for NULL ?

OK, I see the 32 bit version already does this, but I'm
wondering if there is some restriction on the instruction
sequence between the compare and the branch.  Here's what's
there:

	lwz	r5,CPU_SPEC_SETUP(r4)
	cmpi	0,r5,0
	add	r5,r5,r3
	beqlr
	mtctr	r5
	bctr

But, could this also be:

	lwz	r5,CPU_SPEC_SETUP(r4)
	cmpi	0,r5,0
	beqlr
	add	r5,r5,r3
	mtctr	r5
	bctr

-Geoff
