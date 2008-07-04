Return-Path: <mikpe@it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2CCD4DDED9
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 12:43:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18541.35978.437115.957054@harpo.it.uu.se>
Date: Fri, 4 Jul 2008 04:35:54 +0200
From: Mikael Pettersson <mikpe@it.uu.se>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
In-Reply-To: <20080703234140.GC9594@localdomain>
References: <20080703234140.GC9594@localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch writes:
 > Some IBM POWER-based platforms have the ability to run in a
 > mode which mostly appears to the OS as a different processor from the
 > actual hardware.  For example, a Power6 system may appear to be a
 > Power5+, which makes the AT_PLATFORM value "power5+".
 > 
 > However, some applications (virtual machines, optimized libraries) can
 > benefit from knowledge of the underlying CPU model.  A new aux vector
 > entry, AT_BASE_PLATFORM, will denote the actual hardware.  For
 > example, on a Power6 system in Power5+ compatibility mode, AT_PLATFORM
 > will be "power5+" and AT_BASE_PLATFORM will be "power6".

Why on earth would you ever want AT_PLATFORM to differ from AT_BASE_PLATFORM?
In cases that matter you admit that AT_BASE_PLATFORM takes precedence,
so why involve a fake lame not-quite-the-platform in the first place?

Workaround for buggy software?
