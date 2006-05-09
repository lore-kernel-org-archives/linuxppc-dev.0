Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <445FDF62.2030008@am.sony.com>
References: <BE9739CD-B66A-43A4-B5E9-2DE49CEDE5B7@kernel.crashing.org>
	<445FDF62.2030008@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <737B0293-1C5A-4ACC-B052-3B2DB8EA2206@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch] powerpc: remove do-nothing cpu setup routines
Date: Tue, 9 May 2006 02:47:20 +0200
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 	lwz	r5,CPU_SPEC_SETUP(r4)
> 	cmpi	0,r5,0
> 	add	r5,r5,r3
> 	beqlr
> 	mtctr	r5
> 	bctr
>
> But, could this also be:
>
> 	lwz	r5,CPU_SPEC_SETUP(r4)
> 	cmpi	0,r5,0
> 	beqlr
> 	add	r5,r5,r3
> 	mtctr	r5
> 	bctr

Sure.  Except it should be  cmpwi cr0,r5,0  or  cmpwi r5,0 --
cmpi with three arguments is not valid PowerPC assembler code.


Segher
