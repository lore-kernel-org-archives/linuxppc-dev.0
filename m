Return-Path: <j.glisse@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.205])
	by ozlabs.org (Postfix) with ESMTP id 33AC467B2D
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2005 20:13:23 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so1660314wra
	for <linuxppc-dev@ozlabs.org>; Fri, 08 Apr 2005 03:13:22 -0700 (PDT)
Message-ID: <4240b91605040803137e9e7ddc@mail.gmail.com>
Date: Fri, 8 Apr 2005 11:13:19 +0100
From: Jerome Glisse <j.glisse@gmail.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20050407171026.GO3396@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4240b916050404033230db0551@mail.gmail.com>
	<20050407171026.GO3396@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: linux 2.6.12-rc1-bk5 compilation error
Reply-To: Jerome Glisse <j.glisse@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I think you're the only person building a zImage for a 32bit kernel with
> a 64bit toolchain for MULTIPLATFORM, yes. :)

I should move to 64bits :)
 
> This is a valid problem, however.  Does the following also work for you?

It partly works (correct the problem with disable_6xx_mmu)
but i still have to the following for resolving __flush_disable_L1

I changed the makefile in arch/ppc/kernel to have this :
obj-$(CONFIG_POWER4) += cpu_setup_power4.o
into :
obj-$(CONFIG_POWER4) += l2cr.o cpu_setup_power4.o

Jerome Glisse
