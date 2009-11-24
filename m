Return-Path: <nhorman@tuxdriver.com>
Received: from smtp.tuxdriver.com (charlotte.tuxdriver.com [70.61.120.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D20D1007E8
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 05:11:26 +1100 (EST)
Date: Tue, 24 Nov 2009 13:11:18 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc64: re-enable kexec to allow module loads with
	CONFIG_MODVERSIONS and CONFIG_RELOCATABLE turned on
Message-ID: <20091124181118.GA3496@hmsreliant.think-freely.org>
References: <20091119195216.GC11414@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091119195216.GC11414@hmsreliant.think-freely.org>
Cc: rusty@rustcorp.com.au, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Neil Horman writes:

> 	Before anyone flames me for what a oddball solution this is, let me just
> say I'm trying to get the ball rolling here.  I think there may be better
> solutions that can be impemented in reloc_64.S, but I've yet to make any of
the
> ones I've tried work successfully.  I'm open to suggestions, but this solution
> is the only one so far that I've been able to get to work. thanks :)

I had thought that the CRCs would be the only things with reloc
addends less than 4G, but it turns out that the toolchain folds
expressions like __pa(&sym) into just a load from a doubleword (in the
TOC) containing the physical address of sym.  That needs to be
relocated and its reloc addend will be less than 4GB.  Hence the
crashes early in boot that you were seeing with my proposed patch to
reloc_64.S.

Given that, your solution seems as reasonable as any.  Should this go
via the modules maintainer, Rusty Russell, perhaps?

In any case,

Acked-by: Paul Mackerras <paulus at samba.org>


I'm not 100% sure, it does kind of split the middle in regards to what tree is
should come through.

Rusy, given the previous entries in this thread, do you have any thoughts on the
patch, or which tree it should go through?  I kind of think that the ppc tree is
just fine here since its currently the only user of this code, but I'll defer to
other opinions on the subject.

Thanks & Regards
Neil
