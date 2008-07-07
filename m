Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id D3710DE752
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 01:55:34 +1000 (EST)
Date: Mon, 7 Jul 2008 10:55:10 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
Message-ID: <20080707155510.GE9594@localdomain>
References: <20080703234140.GC9594@localdomain>
	<18541.35978.437115.957054@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18541.35978.437115.957054@harpo.it.uu.se>
Cc: Benjamin, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mikael Pettersson wrote:
> Nathan Lynch writes:
>  > Some IBM POWER-based platforms have the ability to run in a
>  > mode which mostly appears to the OS as a different processor from the
>  > actual hardware.  For example, a Power6 system may appear to be a
>  > Power5+, which makes the AT_PLATFORM value "power5+".
>  > 
>  > However, some applications (virtual machines, optimized libraries) can
>  > benefit from knowledge of the underlying CPU model.  A new aux vector
>  > entry, AT_BASE_PLATFORM, will denote the actual hardware.  For
>  > example, on a Power6 system in Power5+ compatibility mode, AT_PLATFORM
>  > will be "power5+" and AT_BASE_PLATFORM will be "power6".
> 
> Why on earth would you ever want AT_PLATFORM to differ from AT_BASE_PLATFORM?
> In cases that matter you admit that AT_BASE_PLATFORM takes precedence,
> so why involve a fake lame not-quite-the-platform in the first place?
> 
> Workaround for buggy software?

My apologies, I did not explain the motivation well.

The idea is that while AT_PLATFORM indicates the instruction set
supported, AT_BASE_PLATFORM indicates the underlying
microarchitecture.  It's not a matter of buggy software, or of one
value taking precedence over the other.
